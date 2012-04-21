%clc;
clear all;
Iter = 20;
w=[];
dirprefix='/home/pradeep/class/poems/leisure/project/dataset/iso_sam/';
pre='ca';
wdirprefix = sprintf('%s%s/',dirprefix,pre);
%fout = fopen('/home/pradeep/Desktop/project/dataset/result','w+'); % always overwrite
xdir = dir(wdirprefix);
numIm = size(xdir,1);
count = 1;
for i = 1 : numIm
	if(strcmp(xdir(i).name,'.') || strcmp(xdir(i).name,'..'))
		continue;
	end
	if(count > 10)
		break
	end
	count = count + 1;
	t = sprintf('%s%s',wdirprefix,xdir(i).name);
	Img = imread(t);
	Img=imresize(Img, [32 32]); 
	%~ [Ny,Nx,Nc] = size(Img); 
	%~ if Nc>1; 
		%~ Img=rgb2gray(Img); 
	%~ end
	%~ Img=imresize(Img, [32 32]); 	
	%~ w = graythresh(Img);
	%~ Img = im2bw(Img,w);
	%~ eul = bweuler(Img,8);
	%~ [xw1 numc]= bwlabel(Img,4);
	%~ fprintf(fout,'%s %d %d\n',t,numc,eul);
	Img = Img(:,:,1);
	Img = double(Img);
	[row,col] = size(Img);
	phi = ones(row,col);
	phi(10:row-10,10:col-10) = -1;
	u = - phi;
	[c, h] = contour(u, [0 0], 'r');
	title('Initial contour');
	% hold off;

	sigma = 1;
	G = fspecial('gaussian', 5, sigma);

	delt = 1;

	mu = 25;%this parameter needs to be tuned according to the images

	for n = 1:Iter
	    [ux, uy] = gradient(u);
	   
	    c1 = sum(sum(Img.*(u<0)))/(sum(sum(u<0)));% we use the standard Heaviside function which yields similar results to regularized one.
	    c2 = sum(sum(Img.*(u>=0)))/(sum(sum(u>=0)));
	    
	    spf = Img - (c1 + c2)/2;
	    spf = spf/(max(abs(spf(:))));
	    
	    u = u + delt*(mu*spf.*sqrt(ux.^2 + uy.^2));
	    
	    %~ if mod(n,10)==0
	    %~ imagesc(Img,[0 255]); colormap(gray);hold on;
	    %~ [c, h] = contour(u, [0 0], 'r');
	    %~ iterNum = [num2str(n), 'iterations'];
	    %~ title(iterNum);
	    %~ pause(0.02);
	    %~ end
	    u = (u >= 0) - ( u< 0);% the selective step.
	    u = conv2(u, G, 'same');
	end
	%imagesc(Img,[0 255]);colormap(gray);hold on;
	[c, h] = contour(u, [0 0], 'b');close all;
	w = [w;size(c,2)];
end
w
fprintf(1,'class `%s`: min = %d, max = %d\n',pre,min(w),max(w));
%fclose(fout);