function showskel(seg)

for i=1:size(seg,2)
   
   %   imshow(bwmorph(seg{i}, 'thin'));
   imshow(bwmorph(bwmorph(seg{i},'close'),'skel'));
   i
   a = input('%s\n');
end