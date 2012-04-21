function [imstats, letters, labels, num] = segment(inimage, varargin)

if (nargin > 1)
   thresh = varargin{1};
   if (nargin > 2)
      connected = varargin{2};
   else
      connected = 8;
   end
else
   thresh = 0.55;
   connected = 8;
end

if (thresh == 0)
   thresh = 0.55;
end

interim = im2bw(inimage, thresh);

% forget what is above

inimage = im2double(inimage);
bwimglow = im2double(im2bw(inimage, 0.4));
bwimg = im2double(im2bw(inimage, 0.4));
holes = im2double(bwfill(bwimg, 'holes')) - bwimg;
holes = im2double(dilate(holes, ones(4,4)));
%holes = im2double(dilate(holes));
fillimg = inimage + holes;
fillbwimg = im2bw(fillimg, 0.6);

%fillbwimg = bwmorph(fillbwimg, 'clean');
%fillbwimg = bwmorph(fillbwimg, 'spur');
%fillbwimg = bwmorph(fillbwimg, 'hbreak');
connected = 8;

bwimg = fillbwimg & bwimglow;
[labeled, num] = bwlabel(bwimg, connected);
%odd = roicolor(labeled, 1:2:num);
%even = roicolor(labeled, 2:2:num);

%labels(:,:,1) = odd;
%labels(:,:,3) = even;
%labels = even;

%outimage = labeled;

labels = labeled;


imstats = imfeature(labeled, 'all');

for count = 1:num
   letters{count} = roicolor(labeled, [count]);
%   filllabeled = bwmorph(filllabeled, 'diag');
%   letterlabel = filllabeled & bwimg;
end
