function [diff] = diff_letters(image1, image2)

if ( size(image1, 1) < size(image2, 1) )
   image2 = imcrop(image2, [ 0 0 size(image2, 2) size(image1, 1)]);
elseif ( size(image1, 1) > size(image2, 1) )
   image1 = imcrop(image1, [ 0 0 size(image1, 2) size(image2, 1)]);
end

if ( size(image1, 2) < size(image2, 2) )
   image2 = imcrop(image2, [ 0 0 size(image1, 2) size(image2, 1)]);
elseif ( size(image1, 2) > size(image2, 2) )
   image1 = imcrop(image1, [ 0 0 size(image2, 2) size(image1, 1)]);
end

diffimg = find(im2double(image1) - im2double(imag2));

diff = size(diffimg, 1);