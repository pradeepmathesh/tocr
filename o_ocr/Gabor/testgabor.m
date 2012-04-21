function [gabfeat]=testgabor(img_in)
% function [gabfeat]=gabor_example(img_in)

% an example to demonstrate the use of gabor filter.
% requires lena.jpg in the same path.
% the results mimic:
% http://matlabserver.cs.rug.nl/edgedetectionweb/web/edgedetection_examples
% .html
% using default settings (except for in radians instead of degrees)
%
% note that gabor_fn only take scalar inputs, and multiple filters need to
% be generated using (nested) loops
%
% also, apparently the scaling of the numbers is different from the example
% software at
% http://matlabserver.cs.rug.nl
% but are consistent with the formulae shown there
 lambda=[16 8 4 2 1];
a=length(lambda);
% theta=zeros(1,8);
theta=[0 10 20 30 40 50 60 70 80 90 100 110 120 130 140 150 160 170 180 190 200 210 220 230 240 250 260 270 280 290 300 ];
% for k=1:8
% theta(k)   = k*(pi/8);
% end
b=length(theta);
 psi     = [0 pi/2];
 gamma   = 0.5;
 bw      = 1;
 N       = a*b;
% img_in = im2double(imread('lena.jpg'));
% img_in(:,:,2:3) = [];   % discard redundant channels, it's gray anyway
 img_out = zeros(size(img_in,1), size(img_in,2), N);
 n=1;
%  while n<=N
 for j=1:a
     for i=1:b
%          lambda(j)
%          theta(i)
     gb = gabor_fn(bw,gamma,psi(1),lambda(j),theta(i))...
         + 1i * gabor_fn(bw,gamma,psi(2),lambda(j),theta(i));
     
     % gb is the n-th gabor filter
     img_out(:,:,n) = imfilter(img_in, gb, 'symmetric');
%       figure();
%  img_out_disp = sum(abs(img_out).^2, 3).^0.5;
% %  img_out_disp
%  % default superposition method, L2-norm
%  img_out_disp = img_out_disp./max(img_out_disp(:));
%  % normalize
%  imshow(img_out_disp);
%  title('gabor output, L-2 super-imposed, normalized');
% %     % filter output to the n-th channel
     %theta = theta + 2*pi/N;
     % next orientation
     n=n+1;
     end
     
 end
 
%  disp('end');
%         disp(n);
%  end
%  figure(1);
%  imshow(img_in);
%  title('input image');



gabfeat=zeros(2*N,1);
%% extracting mean and stdDev from each gabor filtered image which acts as
%% features

for n=0:N-1
img_out(:,:,(n+1))=abs(img_out(:,:,(n+1)));
gabfeat((2*n)+1,1) = mean2(img_out(:,:,(n+1)));
gabfeat((2*n)+2,1) = std2(img_out(:,:,(n+1)));
end
  size(gabfeat);
