function train_moments(inimage, varargin)

global MOMENTDATA;

[seg, lab, num] = segment(inimage);

numcat = 0;

for count = 1:num
   segimg = im2double(seg{count});
   imshow(segimg);
   category = input('Category of this alphabet : ', 's');   
   if (count == 1)
      numcat = 1;
      catlist{1} = category;
      newcat = 1;
   else
      catpos = strmatch(category, catlist, 'exact');
      if (size(catpos, 1) == 0)
         numcat = numcat + 1;
         catlist{numcat} = category;
         newcat = 1;
      else
         newcat = 0;
      end
   end
   
   if (newcat == 1)
      MOMENTDATA{numcat}(1, :) = humoments(segimg);
   else
      MOMENTDATA{catpos}(size(MOMENTDATA{catpos}, 1) + 1, :) = humoments(segimg);
   end
end

if (nargin == 1)
   imfile = input('Name of file to save in : ', 's');   
else
   imfile = varargin{1};
end

imfile = strcat(imfile, '.mat');

fd = fopen(imfile, 'w');

fprintf(fd, '%d\n', numcat);

for count = 1:numcat
   fprintf(fd, '%s\n', catlist{count});
   fprintf(fd, '%d\n', size(MOMENTDATA{count}, 1));
   for hucount = 1:size(MOMENTDATA{count}, 1)
      fprintf(fd, '%f ', MOMENTDATA{count}(hucount, :));
      fprintf(fd, '\n');
   end
   fprintf(fd, '\n');
end
   
fclose(fd);

