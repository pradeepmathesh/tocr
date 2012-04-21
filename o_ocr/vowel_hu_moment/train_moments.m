function [moment_data, cat_data] = train_moments(inimage, varargin)

[imstats, seg, lab, num] = segment(inimage);

numcat = 6;

for i=1:6
  moment_data{i} = [];
  catlist{i} = catname(i);
end

for count = 1:num
  segimg = im2double(imstats(count).Image);
  % segimg = im2double(seg{count});
   imshow(seg{count});
   
   if ((nargin > 1) & (size(varargin{1}, 2) == num))
     category = varargin{1}{count};
   else
     category = input('Category of this alphabet : ', 's');
   end
   cat_data{count} = category;
 
   catpos = position(category);
   
   %if (count == 1)
   %  numcat = 1;
   % catlist{1} = category;
   %newcat = 1;
   % else
   %   catpos = strmatch(category, catlist, 'exact');
   %   if (size(catpos, 1) == 0)
   %     numcat = numcat + 1;
   %    catlist{numcat} = category;
   %   newcat = 1;
   %else
   %  newcat = 0;
   %end
   %end
   
   %if (newcat == 1)
   %  moment_data{numcat}(1, :) = humoments(segimg);
   %else
   moment_data{catpos}(size(moment_data{catpos}, 1) + 1, :) = humoments(segimg);
   %end
end

if (nargin <= 2)
   imfile = input('Name of file to save moments in : ', 's');   
else
   imfile = varargin{2};
end

imfile = strcat(imfile, '.mat');

fd = fopen(imfile, 'w');

fprintf(fd, '%d\n', numcat);

for count = 1:numcat
   fprintf(fd, '%s\n', catlist{count});
   fprintf(fd, '%d\n', size(moment_data{count}, 1));
   for hucount = 1:size(moment_data{count}, 1)
      fprintf(fd, '%e ', moment_data{count}(hucount, :));
      fprintf(fd, '\n');
   end
   fprintf(fd, '\n');
end
   
fclose(fd);



if (nargin <= 3)
   imfile = input('Name of file to save categories in : ', 's');   
else
   imfile = varargin{3};
end

imfile = strcat(imfile, '.mat');

fd = fopen(imfile, 'w');

fprintf(fd, '%d\n', num);

for count = 1:num
   fprintf(fd, '%s\n', cat_data{count});
end

fclose(fd);



function [catpos] = position(category)

if (strcmp(category, 'a'))
  catpos = 1;
elseif (strcmp(category, 'e'))
  catpos = 2;
elseif (strcmp(category, 'i'))
  catpos = 3;
elseif (strcmp(category, 'o'))
  catpos = 4;
elseif(strcmp(category, 'u'))  
  catpos = 5;
else
  catpos = 6;
end


function [name] = catname(position)

if (position == 1)
  name = 'a';
elseif (position == 2)
  name = 'e';
elseif (position == 3)
  name = 'i';
elseif (position == 4)
  name = 'o';
elseif (position == 5)
  name = 'u';
elseif (position == 6)
  name = 'c';
end
