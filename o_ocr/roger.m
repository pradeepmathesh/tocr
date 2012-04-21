function omi(omega);
	tic
	clc;
	%omega = 0; %0 means test!...  1 means train!
	path(path,'feature_extraction');
	path(path,'vowel_hu_moment');
	path(path,'aff_mom');
	path(path,'mom_inv');
	path(path,'Gabor');
	%dirprefix='/home/pradeep/Desktop/project/dataset/blob1250/';

	%training data location
	if(omega == 1)
	dirprefix='/home/pradeep/Desktop/project/dataset/tam/test16_prop_bin/';
	%dirprefix='/home/pradeep/Desktop/project/dataset/small/';
	fout = fopen('/home/pradeep/Desktop/project/dataset/feature_train.txt','w+'); % always overwrite
	else
	%testing data location
	dirprefix='/home/pradeep/Desktop/project/dataset/orderrnbin/';
	%dirprefix='/home/pradeep/Desktop/project/dataset/small/';
	fout = fopen('/home/pradeep/Desktop/project/dataset/feature_test.txt','w+'); % always overwrite
	end
	xdir = dir(dirprefix);
	numIm = size(xdir,1);
	fin=readinv('afinv12indep.txt'); 
	vstrsp = [];
	vmw = [];
	vrings = [];
	vmaxs_maxpoint = [];
	% Setting
	count = 1;
	ccount = 1;
	resize_im=32;
	M = resize_im*resize_im;  % size of image vector, i.e., number of pixels
	d = 100;   % dim of new feature space
	DATA = [];
	dillips_feature = [];
	humom_feature = [];
	for i = 1 : numIm
	%xdir(i).name
		if(strcmp(xdir(i).name,'.') || strcmp(xdir(i).name,'..'))
			continue;
		end
		MODEL_SMOOTH_IMAGE = 0; % Chan-Vese Model

		maxI = 256; % max image intensity

		t = sprintf('%s%s',dirprefix,xdir(i).name);
		Img = imread(t);
		[Ny,Nx,Nc] = size(Img); 
		if Nc>1; 
			Img=rgb2gray(Img); 
		end; % Convert color image to gray-scale image
	%	Img=imresize(Img, [32 32]); 
		ModelSeg = MODEL_SMOOTH_IMAGE;

		mu = 1e3; 
		lambda = mu* 5;
		cpt_fig = 1; % figure number
		VecParameters = [Ny; Nx; ModelSeg; lambda; mu; ]; % parameters for active contour function
		[u,c,h]=active_contour_minimization(Img,VecParameters,cpt_fig); % active contour function credit goes to Xavier bresson, UCLA

		x=c(2,:);
		L=length(x);
		count=1;
		ind=0;
		y=[];
		ct = [];
		while count < L
			ind=ind+1;
			y(ind)=x(count);
			ct(ind) = count;
			count=count+y(ind)+1;
		end
		[l,m] = max(y);
		w = length(y);
		if(m == w)
		  xc = c(1,ct(m)+1:L);
		  yc = c(2,ct(m)+1:L);
		else	  
		  xc = c(1,ct(m)+1:ct(m+1)-1);
		  yc = c(2,ct(m)+1:ct(m+1)-1);
		end
		minx = min(xc);
		maxx = max(xc);	
		miny = min(yc);
		maxy = max(yc);
		[dum,numContours] = size(y);
		[maxs_maxpoint,dummy] = max(y);
		rings = 0;
		for j = 1:numContours
			if j ~= numContours
				txc = c(1,ct(j)+1:ct(j+1)-1);
				tyc = c(2,ct(j)+1:ct(j+1)-1);
			else
				txc = c(1,ct(j)+1:L);
				tyc = c(2,ct(j)+1:L);
			end
			tminx = min(txc);
			tmaxx = max(txc);	
			tminy = min(tyc);
			tmaxy = max(tyc);
			if tminx > minx  && tmaxx < maxx
				rings = rings + 1;
			end 
		end
		w = size(y,2);
		s = xdir(i).name;
		[strsp dum] = strtok(s,'.');

		strsp = str2num(strsp);
		vstrsp = [vstrsp strsp];
		vmw = [vmw w];
		vrings = [vrings rings];
		vmaxs_maxpoint = [vmaxs_maxpoint maxs_maxpoint];
		Img=imresize(Img, [32 32]); 
		Img = im2double(Img);
		DATA(:, ccount) = reshape (Img, resize_im*resize_im, 1);%random projection
		v(ccount,:) = testgabor(Img); % gabor feature
		mm=cm(Img,12); % moment computation
		v1(ccount,:)=cafmi(fin,mm); % invariant evaluation
		% Geometry Invariant Properties based feature  ## credit goes to Dinesh Dillip, IISc 
		features=feature_extractor_2d(Img);
		dillips_feature = [dillips_feature features];
		% Hu's moment based features ## credit goes to Vivek Kwasara, UNC
		humom = [humoments(Img)]';
		humom_feature = [humom_feature 	humom];
		ccount = ccount + 1;
	end

	%Random Projection ## credit goes to Qinfeng Shi, University of Adelaide

	A = DATA;

	randn('state',200);
	R = randn(d,M);% using random matrix
	phi = R*A;

	for j = 1:size(phi,2)
		norm2 = norm(phi(:,j),2);
		norm2_phi(:,j)= phi(:,j)./norm2;
	end
	if(omega == 1)
	%else
		%load feature_train_essence.mat
	%	fprintf(fout,'%d\n%d\n',numIm-2,555);
		for i=1:numIm-2
			fprintf(fout,'%d ',vstrsp(i));
			fprintf(fout,'%f %f %f ',vmw(i),vrings(i),vmaxs_maxpoint(i));% stored as maxvmw, maxvmaxs_maxpoint,maxrings total number of points,number of points of maximum contour length,number of rings
			for k=1:d
				fprintf(fout,'%f ',norm2_phi(k,i));%stored
			end
			for j=1:55
				fprintf(fout,'%f ',dillips_feature(j,i));
			end
			for w=1:size(humom,1)
				fprintf(fout,'%f ',humom_feature(w,i));
			end
			for w=1:310
				fprintf(fout,'%f ',v(i,w));
			end
			for w=1:80
				fprintf(fout,'%f ',v1(i,w));
			end
			fprintf(fout,'\n');
		end
	else
		%save('feature_test.mat');
		for i=1:numIm-2
			fprintf(fout,'%d ',vstrsp(i));
			fprintf(fout,'%f %f %f ',vmw(i),vrings(i),vmaxs_maxpoint(i));% stored as maxvmw, maxvmaxs_maxpoint,maxrings total number of points,number of points of maximum contour length,number of rings
			for k=1:d
				fprintf(fout,'%f ',norm2_phi(k,i));%stored
			end
			for j=1:55
				fprintf(fout,'%f ',dillips_feature(j,i));
			end
			for w=1:size(humom,1)
				fprintf(fout,'%f ',humom_feature(w,i));
			end
			for w=1:310
				fprintf(fout,'%f ',v(i,w));
			end
			for w=1:80
				fprintf(fout,'%f ',v1(i,w));
			end
			fprintf(fout,'\n');
		end
	end
	fclose(fout);
	toc