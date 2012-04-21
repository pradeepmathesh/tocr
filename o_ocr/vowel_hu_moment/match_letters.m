function [match] = match_letters(image1, image2, varargin)

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

r1 = size(image1, 1);
c1 = size(image1, 2);
r2 = size(image2, 1);
c2 = size(image2, 2);

if ( r1 < r2 )
   image1(r1+1:r2, :) = 0;
elseif ( r1 > r2 )
   image2(r2+1:r1, :) = 0;
end

if ( c1 < c2 )
   image1(:, c1+1:c2) = 0;
elseif ( c1 > c2 )
  image2(:, c2+1:c1) = 0;
end

p1p2 = find(image1 & image2);
p1n2 = find(image1 & ~image2);
n1p2 = find(~image1 & image2);

if (nargin > 2)
   match = size(p1p2, 1);
else      
   match = size(p1p2, 1) - ( size(p1n2, 1) + size(n1p2, 1) );
end