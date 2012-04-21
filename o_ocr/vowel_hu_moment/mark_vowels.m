function [marked] = mark_vowels(inimage)

global AIMAGE;
global EIMAGE;
global IIMAGE;
global OIMAGE;
global UIMAGE;
global NIMAGE;

global MOMENTDATA;
global AREADATA;

ubar = dilate(erode(UIMAGE, ones(1,2)), ones(4,4));
nbar = dilate(erode(NIMAGE, ones(1,2)), ones(4,4));                  

max_area_thresh = 5;
min_area_thresh = 5;

max_area_thresh_i = 2;
min_area_thresh_i = 2;

match_thresh_aeo = 15; 
match_thresh_u = -8;
match_thresh_n = -10;
match_thresh_i_0 = 3; 
match_thresh_i_1 = 8; 

moment_thresh = 100;
moment_thresh_i = 15;

[stat, seg, label, num] = segment(inimage);

marked = im2double(inimage);
marked(:,:,:) = 0;

min_aeou_area = min( [AREADATA{1} AREADATA{2} AREADATA{4} AREADATA{5}] ) - min_area_thresh;
max_aeou_area = max( [AREADATA{1} AREADATA{2} AREADATA{4} AREADATA{5}] ) + max_area_thresh;

min_a_area = min( AREADATA{1} ) - min_area_thresh;
max_a_area = max( AREADATA{1} ) + max_area_thresh;

min_i_area = min( AREADATA{3} ) - min_area_thresh_i;
max_i_area = max( AREADATA{3} ) + max_area_thresh_i;


for count = 1:size(stat, 1)
   vowel{count} = 0;
end 

for count = 1:size(stat, 1)
   
   if (vowel{count} == 0)
      if (stat(count).EulerNumber == 0)
         %look for a,e,o
         
         if ( (stat(count).Area <= max_aeou_area) & (stat(count).Area >= min_aeou_area) )
            
            amatch = match_letters(AIMAGE, stat(count).Image);
            ematch = match_letters(EIMAGE, stat(count).Image);
            omatch = match_letters(OIMAGE, stat(count).Image);
            
            maxmatch = max( [ amatch ematch omatch] );
            
            if (maxmatch > match_thresh_aeo)
               vowel{count} = 1;
            else
               mom = humoments(im2double(stat(count).Image));
               
               adist = mymahal(mom, MOMENTDATA{1},7);
               edist = mymahal(mom, MOMENTDATA{2},7);
               odist = mymahal(mom, MOMENTDATA{4},7);
               
               mindist = min( [adist edist odist] );
               
               %mindist = mymin(mindist, adist);
               %mindist = mymin(mindist, edist);
               %mindist = mymin(mindist, odist);
               
               %if (mindist == -1)
               %vowel{count} = 0;	    
               if (mindist <= moment_thresh)
                  vowel{count} = 1;
               else
                  vowel{count} = 0;
               end
               
            end
            
         else
            vowel{count} = 0;
         end
         
      elseif (stat(count).EulerNumber == -1)
         %look for a
         
         if ( (stat(count).Area <= max_aeou_area) & (stat(count).Area >= min_aeou_area) )
            
            amatch = match_letters(AIMAGE, stat(count).Image);
            
            if (amatch > match_thresh_aeo)
               vowel{count} = 1;
            else
               mom = humoments(im2double(stat(count).Image));
               
               adist = mymahal(mom, MOMENTDATA{1},7);
               
               if (adist <= moment_thresh)
                  vowel{count} = 1;
               else
                  vowel{count} = 0;
               end
               
            end
            
         else
            vowel{count} = 0;
         end
         
      elseif (stat(count).EulerNumber == 1)
         %look for a e i o u
         if ( (stat(count).Area <= max_a_area) & (stat(count).Area >= min_a_area) )
            
            amatch = match_letters(AIMAGE, stat(count).Image);
            ematch = match_letters(EIMAGE, stat(count).Image);
            omatch = match_letters(OIMAGE, stat(count).Image);
            
            maxmatch = max( [ amatch ematch omatch] );
            
            if (maxmatch > match_thresh_aeo)
               vowel{count} = 1;
            else
               mom = humoments(im2double(stat(count).Image));
               
               adist = mymahal(mom, MOMENTDATA{1},7);
               edist = mymahal(mom, MOMENTDATA{2},7);
               odist = mymahal(mom, MOMENTDATA{4},7);
               udist = mymahal(mom, MOMENTDATA{5},4);
               
               [mindist, vow] = min( [adist edist odist udist] );
               
               if (mindist < moment_thresh)
                  
                  if (vow == 4)
                     imgbar = dilate(erode(bwmorph(bwmorph(stat(count).Image,'close'),'skel'), ones(1,2)), ones(4,4));
                     
                     umatch = match_letters(ubar, imgbar);
                     nmatch = match_letters(nbar, imgbar);
                     
                     if (nmatch > match_thresh_n)
                        vowel{count} = 0;
                     elseif (umatch > match_thresh_u)
                        vowel{count} = 1;
                     else
                        vowel{count} = 0;
                     end
                     
                  else
                     vowel{count} = 1;
                  end
                  
               else
                  vowel{count} = 0;
               end
               
            end
            
         elseif ( (stat(count).Area <= max_i_area) & (stat(count).Area >= min_i_area) )
            %look for i
            
            stimg = imrotate(stat(count).Image, 90-stat(count).Orientation,'crop');
            
            imatch1 = match_letters(IIMAGE, stimg);
            imatch0 = match_letters(IIMAGE, stimg);
            
            if (imatch1 > match_thresh_i_1)
               vowel{count} = 1;
            elseif (imatch0 > match_thresh_i_0)
               vowel{count} = 1;
            else
               mom = humoments(im2double(stimg));
               
               idist = mymahal(mom, MOMENTDATA{3}, 3);
               
               if (idist < moment_thresh)
                  vowel{count} = 1; 
               else
                  vowel{count} = 0;
               end
            end
            
            if (vowel{count} == 1)
               
               se = ones(15,1);
               se = imrotate(se, stat(count).Orientation-90);
               
               segimg = dilate(dilate(seg{count}), se);% - segimg;
               
               [rows, cols] = find(segimg);
               
               objects = bwselect(label, cols, rows); 
               
               objlab = im2double(objects).*label;
               
               [rows, cols, vals] = find(objlab);
               
               dotval = 0;
               currval = 0;
               for j=1:size(vals, 1)
                  if (currval ~= vals(j))
                     currval = vals(j);
                     dot = bwmorph(stat(currval).Image, 'skel');
                     dotnum = find(dot);
                     if (size(dotnum, 1) <= 6)
                        dotval = currval;
                     end
                  end
               end
               
               if (dotval == 0)
                  vowel{count} = 0;
               else
                  vowel{dotval} = 1;
               end
               
            end
            
         else
            vowel{count} = 0;
         end
         
      end
      
   end
   
end

for count = 1:size(stat, 1)
   if (vowel{count} == 1)
      marked = marked + im2double(seg{count});
   end
end

function [minval] = mymin(a, b)

if (a == -1)
   minval = b;
elseif (b == -1)
   minval = a;
else
   if (a < b)
      minval = a;
   else
      minval = b;
   end
end
