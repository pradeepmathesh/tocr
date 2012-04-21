
a1 = imread('alpha1.tif', 'tif');
a2 = imread('alpha2.tif', 'tif');
a3 = imread('alpha3.tif', 'tif');

a1 = imadjust(a1, [0 1], [1 0]);
a2 = imadjust(a2, [0 1], [1 0]);
a3 = imadjust(a3, [0 1], [1 0]);

[stat1 seg1 lab1 num1] = segment(a1);
[stat3 seg3 lab3 num3] = segment(a3);

global AIMAGE;
global EIMAGE;
global IIMAGE;
global OIMAGE;
global UIMAGE;
global NIMAGE;

AIMAGE = imread('aimage.tif');
EIMAGE = imread('eimage.tif');
IIMAGE = imread('iimage.tif');
OIMAGE = imread('oimage.tif');
UIMAGE = imread('uimage.tif');
NIMAGE = imread('nimage.tif');

global MOMENTDATA;
global AREADATA;

MOMENTDATA = [];
AREADATA = [];

catdata1 = fill_cats('catdata1');
catdata3 = fill_cats('catdata3');
fill_moments('hudata1');
fill_areas('areadata1');

