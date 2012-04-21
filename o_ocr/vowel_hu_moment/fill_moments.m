function [catlist] = fill_moments(imfile)

imfile = strcat(imfile, '.mat');

fd = fopen(imfile, 'r');

numcat = fscanf(fd, '%d\n', 1);

global MOMENTDATA;

for i = size(MOMENTDATA, 2)+1:6
  MOMENTDATA{i} = [];
end

for count = 1:numcat
   
  category = fscanf(fd, '%s\n', 1);

   if (strcmp(category, 'c'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{6} = category; 
     for i = 1:catcount
       fscanf(fd, '%e', 7);
       %fscanf(fd, '\n', 1);
     end
     % MOMENTDATA{6} = [];
     
   elseif (strcmp(category, 'a'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{1} = category; 
     humom = fscanf(fd, '%e', [7,catcount]);
     MOMENTDATA{1} = [MOMENTDATA{1} ; humom'];
     
   elseif (strcmp(category, 'e'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{2} = category; 
     humom = fscanf(fd, '%e', [7,catcount]);
     MOMENTDATA{2} = [MOMENTDATA{2} ; humom'];
     
   elseif (strcmp(category, 'i'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{3} = category; 
     humom = fscanf(fd, '%e', [7,catcount]);
     MOMENTDATA{3} = [MOMENTDATA{3} ; humom'];
   
   elseif (strcmp(category, 'o'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{4} = category; 
     humom = fscanf(fd, '%e', [7,catcount]);
     MOMENTDATA{4} = [MOMENTDATA{4} ; humom'];
   
   elseif(strcmp(category, 'u'))
     catcount = fscanf(fd, '%d\n', 1);
     catlist{5} = category; 
     humom = fscanf(fd, '%e', [7,catcount]);
     MOMENTDATA{5} = [MOMENTDATA{5} ; humom'];
   
   end
   
   %fscanf(fd, '\n', 2);
end

fclose(fd);
