clc;
close all;
%~ order = 1;
%~ if order == 0;
%~ dirprefix='/home/pradeep/Desktop/project/dataset/Numberedbin/';
%~ fout = fopen('/home/pradeep/Desktop/project/dataset/feature_2train.txt','w+');
%~ else
%~ dirprefix='/home/pradeep/Desktop/project/dataset/orderrnbin/';
%~ fout = fopen('/home/pradeep/Desktop/project/dataset/feature_2test.txt','w+');
%~ end
order = 0;
if order == 0;
dirprefix='/home/pradeep/Desktop/project/dataset/tha/';
%dirprefix='/home/pradeep/Desktop/project/dataset/Numberedbin/';
fout = fopen('/home/pradeep/Desktop/project/dataset/feature_3tha.txt','w+');
else
%dirprefix='/home/pradeep/Desktop/project/dataset/orderrnbin/';
fout = fopen('/home/pradeep/Desktop/project/dataset/feature_1test.txt','w+');
end
xdir = dir(dirprefix);
numIm = size(xdir,1);
for i = 1 : numIm
if(strcmp(xdir(i).name,'.') || strcmp(xdir(i).name,'..'))
	continue;
end
t = sprintf('%s%s',dirprefix,xdir(i).name);
Img = imread(t);
[Ny,Nx,Nc] = size(Img); 
if Nc>1; 
Img=rgb2gray(Img); 
end
features=feature_extractor_2d(Img);
%format long;
s = xdir(i).name;
[strsp dum] = strtok(s,'.');
fprintf(fout,'%s ',strsp);
for j=1:55
fprintf(fout,'%d:%f ',j+103,features(j));
end
fprintf(fout,'\n');
end
fclose(fout);