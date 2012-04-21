function [moment_data, cat_data] = train_areas(inimage, varargin)

[imstats, seg, lab, num] = segment(inimage);

numcat = 6;

for i=1:6
  area_data{i} = [];
  catlist{i} = catname(i);
end

for count = 1:num

  imshow(seg{count});
   
   if ((nargin > 1) & (size(varargin{1}, 2) == num))
     category = varargin{1}{count};
   else
     category = input('Category of this alphabet : ', 's');
   end
   cat_data{count} = category;
 
   catpos = position(category);

   area_data{catpos}(size(area_data{catpos}, 2) + 1) = imstats(count).Area;

end

if (nargin <= 2)
   imfile = input('Name of file to save areas in : ', 's');   
else
   imfile = varargin{2};
end

imfile = strcat(imfile, '.mat');

fd = fopen(imfile, 'w');

fprintf(fd, '%d\n', numcat);

for count = 1:numcat
   fprintf(fd, '%s\n', catlist{count});
   fprintf(fd, '%d\n', size(area_data{count}, 2));
   for hucount = 1:size(area_data{count}, 2)
      fprintf(fd, '%f ', area_data{count}(hucount));
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
