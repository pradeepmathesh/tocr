function showcount(seg)

for i=1:size(seg,2)
   
   imshow(seg{i});
   i
   a = input('%s\n');
end