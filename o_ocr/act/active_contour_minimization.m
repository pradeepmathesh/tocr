%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Author: 	Xavier Bresson (xbresson@math.ucla.edu)
% Description: Fast minimization algorithm for General Active Contour Model
% For more details, see the report:
% X. Bresson, "A Short Guide on a Fast Global Minimization Algorithm for Active Contour Models"
% See also these reports: 
% 1- T. Goldstein, X. Bresson, and S. Osher, Geometric Applications of the 
% Split Bregman Method: Segmentation and Surface Reconstruction,
% CAM Report 09-06, 2009. 
% 2- T.F.Chan, L.A.Vese, Active contours without edges, IEEE
% Transactions on Image Processing. 10:2, pp. 266-277, 2001.
% (Segmentation model for smooth/non-texture images)
% 3- N. Houhou, J-P. Thiran and X. Bresson, 
% Fast Texture Segmentation based on Semi-Local Region Descriptor and Active Contour, 2009
% (Segmentation model for texture images)
% Last version: April 3, 2009
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function [u,c,h]=active_contour_minimization(Im0,VecParameters,cpt_fig);



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
MODEL_SMOOTH_IMAGE = 0; % Chan-Vese Model
MODEL_TEXTURE_IMAGE = 1; % Houhou-Thiran-Bresson Model




%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Default values
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
maxI = 256; % max image intensity






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Process input image
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[Ny,Nx,Nc] = size(Im0); 
if Nc>1; Im0=rgb2gray(Im0); end; % Convert color image to gray-scale image
Im0 = double(Im0);
Im0 = Im0/ max(Im0(:)); % Intensity range = [0 1]
Im0 = 1 + maxI* Im0; % Intensity range = [1 maxI]
Im0Ref = Im0;

% figure(cpt_fig); imagesc(Im0); colormap(gray); title('Input image'); colorbar;
% cpt_fig = cpt_fig + 1; 






%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute edge detector function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
use_edge_detector = 2;
if use_edge_detector == 1
    
    std_Gb = 1;
    beta = 50/maxI^2;

    % Smooth input image
    Ng=ceil(6*std_Gb)+1; Gaussian = fspecial('gaussian',[Ny Nx],std_Gb);
    Im0s = ifftshift( ifft2( fft2(Im0) .* fft2(Gaussian) ) );

    % Norm of the gradient of the smoothed image
    [Gx,Gy] = gradient(Im0s);
    NormGrad = sqrt(Gx.^2 + Gy.^2);

    % Edge detector function
    Gb = ones(size(Im0))./ (1 + beta* NormGrad.^2);

    figure(cpt_fig); imagesc(Gb); colormap(gray); title('The stopping function'); colorbar;
    cpt_fig = cpt_fig + 1; 

else
    Gb = ones(Ny,Nx);
end











%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Segmentation code in mex/c
% Open "active_contour_minimization_mex.c" for more details
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Mex function
ModelSeg = VecParameters(3);
if ModelSeg == MODEL_SMOOTH_IMAGE
    [u,MeanIn,MeanOut] = active_contour_minimization_mex(single(Im0),single(Gb),single(VecParameters));
    FT = Im0;
elseif ModelSeg == MODEL_TEXTURE_IMAGE
    [u,pIn,pOut,FT] = active_contour_minimization_mex(single(Im0),single(Gb),single(VecParameters));
    % FT: Texture Feature
end
u = double(u);




 
% Display result
if ModelSeg == MODEL_SMOOTH_IMAGE
    
  %  disp('Final Inside Mean and Outside Mean:');
  %  MeanIn
   % MeanOut

 
   %figure(cpt_fig); clf;
  %subplot(221); imagesc(Im0Ref); title('Image'); colormap(gray); colorbar; axis off;
  
%% Modified ... PMP 
    %subplot(222); imagesc(Im0Ref); title('Segmentation'); colormap(gray); colorbar; axis off;
   %hold on;
 [c,h] = contour(u,[0.5 0.5],'m-'); 
 close all;
%set(h,'LineWidth',2);

%%
   % subplot(223); imagesc(u); title('u'); colormap(gray); colorbar; axis off;
   % subplot(224); imagesc(u>0.5); title('Thresholded u (u>0.5)'); colormap(gray); colorbar; axis off;
 %   sI=2; truesize(cpt_fig,[round(sI*Ny) round(sI*Nx)]);



end




% End of main function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






