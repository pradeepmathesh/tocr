segment gives a labeled image
assumption: each region does contain atleast one full letter (forget the i and j's)..
i.e. number of regions in the segmented image is no more than the actual number of regions 
bcos no letter is broken (note that holes may not be preserved though)

b1 = im2bw(a1, 0.4)
dif1 = b1 - bwfill(b1, 'holes')
imshow(double(a1)/255 + double(dilate(dif1)))