clc
clear
%% House Keeping
tickFontSize = 10;
set(0,'defaultaxesfontsize',tickFontSize)
set(0,'defaultaxeslabelfontsize',18/tickFontSize)
set(0,'defaultaxestitlefontsize',25/tickFontSize)
%% Load input
imc	= imread('peppers.png'); %peppers.png is an image that comes with MATLAB
img = rgb2gray(imc);

%% Plot image
fh_image	= figure(1);clf;
set(fh_image,'name','Input image');
set(fh_image,'color','w');
imshow(imc, 'InitialMagnification', 'fit');
title('Image');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;
%% Create mean smooth image
nkw			= 5;
K_smooth	= ones(nkw, nkw)/(nkw^2);
im_smooth	= uint8(imageFilter(img, K_smooth));

fh_smooth	= figure(2);clf;
set(fh_smooth,'name','Mean Smoothed Image');
set(fh_smooth,'color','w');
imshow(im_smooth, 'InitialMagnification', 'fit');
title('Mean smooth');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;

%% Create gaussian smooth image
sigma		= 2;
h			= ceil(3*sigma);
u			= -h:h;
v			= u;
U2			= u.^2;
V2			= v.^2;
cov			= U2+V2';


K_gaussian = 1/(2*pi*sigma) * exp(-cov./(2*sigma^2));
K_gaussian = K_gaussian/sum(K_gaussian(:));
im_gaussian= uint8(imageFilter(img, K_gaussian));

fh_gaussian	= figure(3);clf;
set(fh_gaussian,'name','Gaussian Smoothed Image');
set(fh_gaussian,'color','w');
imshow(im_gaussian, 'InitialMagnification', 'fit');
title('Gaussian Smooth');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;

%% Create Edge detector
% Chapter 12 of Robotics Vision and Control (Corke, 2011)
Du			= [-1, 0, 1;
			   -2, 0, 2;
			   -1, 0, 1];
Dv			= Du';		   
im_Du		= imageFilter(img, Du);
im_Dv		= imageFilter(img, Dv);

im_edgeu	= uint8(255-im_Du);
im_edgev	= uint8(255-im_Dv);
im_edge		= uint8(255-sqrt(im_Du.^2 + im_Dv.^2));

fh_edgeu	= figure(4);clf;
set(fh_edgeu,'name','Du Image');
set(fh_edgeu,'color','w');
imshow(im_edgeu, 'InitialMagnification', 'fit');
title('Du edge detection kernel');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;

fh_edgev	= figure(5);clf;
set(fh_edgev,'name','Dv Image');
set(fh_edgev,'color','w');
imshow(im_edgev, 'InitialMagnification', 'fit');
title('Dv edge detection kernel');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;

fh_edge	= figure(6);clf;
set(fh_edge,'color','w');
set(fh_edge,'name','Edge Detection');
imshow(im_edge, 'InitialMagnification', 'fit');
title('Edge detection kernel');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;

%% Run tests on output
addpath ../testfeedback

runAllTests();
restoredefaultpath
