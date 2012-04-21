% this function is supposed to extract features from the input image
% function [mainfeat]=feature_extractor(image);
% this function zones the input image
% and extracts features for each image using gabor filters.

clc;clear all;close all;
%dirprefix1='F:\MTECH\3rdsem\Project\featExtrNW_project\Gabor_new\Train_new1\';
dirprefix1='/home/pradeep/Desktop/project/dataset/blob1250/';
%folder consonents
xdir1 = dir(dirprefix1);
numIm1 = size(xdir1,1);
%no of folders inside consonents
fullgabor=zeros((numIm1-2)*20,311);
k=1;
l=1;
for j=3:numIm1
    
    t = sprintf('%s%s',dirprefix1,xdir1(j).name)
    xdir2 = dir(t);
    numIm2 = size(xdir2,1);
    t1=strcat(t,'\');
    for i = 3 : numIm2
        fullgabor(k,1)=(j-2);
        t = sprintf('%s%s',t1,xdir2(i).name)
			img_in = imread ( t );
        if length(size(img_in))>2 % checking if rgb image;
            img_in=rgb2gray(image);
            img_in=im2bw(image,graythresh(image));
        end 
        gabfeat=testgabor(img_in);
%         size(gabfeat)
%         disp('extracted feature of class');
%         disp(i);
%         gabfeat;
        fullgabor(l,2:end)= gabfeat;
%            disp('hiiiiiiiiii');
        k=k+1;
        l=l+1  ;
    end
   
        
end

%%save file as matfile
 
%% normalizing and creating the dat file
fullgabor= normalizeTrainFeatures(fullgabor);
 
savefile = '/home/pradeep/Desktop/project/dataset/gabfeat.mat';
 
save(savefile, 'fullgabor');