clc
clear
%% House Keeping
tickFontSize = 10;
set(0,'defaultaxesfontsize',tickFontSize)
set(0,'defaultaxeslabelfontsize',18/tickFontSize)
set(0,'defaultaxestitlefontsize',25/tickFontSize)
set(0,'defaultlinelinewidth',2)
%% Generate image
nv		= 30;
nu		= 60;

image	= zeros(nv, nu);

template= [0,	0,	128,	0,	0;
		   0, 128, 255, 128, 0;
		   128, 255, 255, 255, 128;
		   0, 128, 255, 128, 0;
		   0, 0, 128, 0, 0;];
	 
nv_t				= size(template,1);
nu_t				= size(template,2);
nballs_known		= 10;
for i = 1:nballs_known
	idxvi				= randi(nv- nv_t,1);
	idxui				= randi(nu- nu_t,1);

	idxv				= idxvi + (1:nv_t) -1;
	idxu				= idxui + (1:nu_t) -1;

	image(idxv, idxu)	= image(idxv, idxu) + template;
end

% Constrain image to valid bounds
image_cl				= image;
istoohigh				= image_cl>255;
istoolow				= image_cl<0;
image_cl(istoohigh)		= 255;
image_cl(istoolow)		= 0;

% Add noise and constrain image to valid bounds
image_noise				= image + 10*randn(nv, nu);
istoohigh				= image_noise>255;
istoolow				= image_noise<0;
image_noise(istoohigh)	= 255;
image_noise(istoolow)	= 0;

fh_image	= figure(1);clf;
set(fh_image,'name','Input image');
set(fh_image,'color','w');

subplot(1,2,1);
imshow(uint8(255-image_cl), 'InitialMagnification', 'fit');
title('True image');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on

subplot(1,2,2);
imshow(uint8(255-image_noise), 'InitialMagnification', 'fit');
title('Noisy image observation');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;
%% Object Recognition
threshold	= 0.8; %Must be 0.8 for tests to pass!
%TODO: Call image filter with the noisy image, template and zncc metric

%TODO: Find all elements above threshold.

%TODO: Circle all above threshold.
%HINT: Use a for loop to loop over each detection.

%% Plot similarity
fh_cost = figure(2);clf;
set(fh_cost,'name','Simlarity image');
set(fh_cost,'color','w');
%TODO: Use "contourf" to display the similarity measure

title('Similarity');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
daspect([1,1,10000])
colorbar
set(gca,'ydir','reverse'); %This is because for images the origin is in the top left and for everything else it is in the bottom left
%% Run Tests
addpath ../testfeedback
runAllTests
restoredefaultpath