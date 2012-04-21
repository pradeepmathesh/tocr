function [cat_data] = fill_cats(imfile)

imfile = strcat(imfile, '.mat');

fd = fopen(imfile, 'r');

numcat = fscanf(fd, '%d\n', 1);

for count = 1:numcat
  cat_data{count} = fscanf(fd, '%s', 1);  
end
