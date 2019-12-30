clc
clear
%% House Keeping
tickFontSize = 10;
set(0,'defaultaxesfontsize',tickFontSize)
set(0,'defaultaxeslabelfontsize',18/tickFontSize)
set(0,'defaultaxestitlefontsize',25/tickFontSize)
%% Generate image
nv		= 15;
nu		= 15;

image	= 30*rand(nv, nu);

template= [0,	0,	128,	0,	0;
		   0, 128, 255, 128, 0;
		   128, 255, 255, 255, 128;
		   0, 128, 255, 128, 0;
		   0, 0, 128, 0, 0;];
	 
nv_t				= size(template,1);
nu_t				= size(template,2);

idxvi				= randi(nv- nv_t,1);
idxui				= randi(nu- nu_t,1);

idxv				= idxvi + (1:nv_t) -1;
idxu				= idxui + (1:nu_t) -1;

image(idxv, idxu)	= template;
%% Plot image and template
fh_image	= figure(1);clf;
set(fh_image,'name','Input image');
set(fh_image,'color','w');
input_ax = subplot(1,2,1);
imshow(uint8(255-image), 'InitialMagnification', 'fit');
title('Find Ball');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
hold on
axis on
template_ax = subplot(1,2,2);
imshow(uint8(255-template), 'InitialMagnification', 'fit');
title('Template');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
%% Object recognition
%TODO: Call image filter.

%TODO: Find the pixel with the highest score.

%TODO: use createCircle and plot to plot a circle around the highest
%scoring pixel.
%HINT: provide "plot" with handle of the axis you would like to plot on (see help plot).

%% Cost Function
fh_cost = figure(2);clf;
set(fh_cost,'name','Simlarity measure');
set(fh_cost,'color','w');
%TODO: use contourf to display the similarity matrix.

title('Similarity Measure');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
daspect([1,1,10000])
colorbar
set(gca,'ydir','reverse'); %This is because for images the origin is in the top left and for everything else it is in the bottom left

%% Run Tests
addpath ../testfeedback
runAllTests
restoredefaultpath