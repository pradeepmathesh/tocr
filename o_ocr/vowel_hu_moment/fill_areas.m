function [catlist] = fill_areas(imfile)

imfile = strcat(imfile, '.mat');

fd = fopen(imfile, 'r');

numcat = fscanf(fd, '%d\n', 1);

global AREADATA;

for i = size(AREADATA, 2)+1:6
  AREADATA{i} = [];
end

for count = 1:numcat
   
  category = fscanf(fd, '%s\n', 1);

   if (strcmp(category, 'c'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{6} = category; 
     for i = 1:catcount
       fscanf(fd, '%f', 7);
       %fscanf(fd, '\n', 1);
     end
     % AREADATA{6} = [];
     
   elseif (strcmp(category, 'a'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{1} = category; 
     area = fscanf(fd, '%f', catcount);
     AREADATA{1} = [AREADATA{1}  area'];
     
   elseif (strcmp(category, 'e'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{2} = category; 
     area = fscanf(fd, '%f', catcount);
     AREADATA{2} = [AREADATA{2}  area'];
     
   elseif (strcmp(category, 'i'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{3} = category; 
     area = fscanf(fd, '%f', catcount);
     AREADATA{3} = [AREADATA{3}  area'];
   
   elseif (strcmp(category, 'o'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{4} = category; 
     area = fscanf(fd, '%f', catcount);
     AREADATA{4} = [AREADATA{4}  area'];
   
   elseif(strcmp(category, 'u'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{5} = category; 
     area = fscanf(fd, '%f', catcount);
     AREADATA{5} = [AREADATA{5}  area'];
   
   end
   
   %fscanf(fd, '\n', 2);
end

fclose(fd);
