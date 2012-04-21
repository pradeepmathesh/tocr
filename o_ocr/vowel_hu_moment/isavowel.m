function [markimg, marked] = isavowel(inimage)

img = imread(inimage);
img = imadjust(img, [0 1], [1 0]);

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

fill_moments('hudata1');
fill_areas('areadata1');

marked = mark_vowels(img);

markimg(:,:,1) = img;
markimg(:,:,2) = img;
markimg(:,:,3) = img;

markimg(:,:,2) = im2uint8( im2double( markimg(:,:,2) ) - im2double( marked ) );
markimg(:,:,3) = im2uint8( im2double( markimg(:,:,3) ) - im2double( marked ) );

imshow(markimg);
