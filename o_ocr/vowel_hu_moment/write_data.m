function write_data(catlist)

global MOMENTDATA;

numcat = size(catlist, 2);

fd = fopen('test.mat', 'w');

fprintf(fd, '%d\n', numcat);

for count = 1:numcat
   fprintf(fd, '%s\n', catlist{count});
   fprintf(fd, '%d\n', size(MOMENTDATA{count}, 1));
   for hucount = 1:size(MOMENTDATA{count}, 1)
      fprintf(fd, '%e ', MOMENTDATA{count}(hucount, :));
      fprintf(fd, '\n');
   end
   fprintf(fd, '\n');
end
   
fclose(fd);


