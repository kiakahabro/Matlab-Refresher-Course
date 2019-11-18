clc
clear

% rng(0)
%% House Keeping
tickFontSize = 10;
set(0,'defaultaxesfontsize',tickFontSize)
set(0,'defaultaxeslabelfontsize',18/tickFontSize)
set(0,'defaultaxestitlefontsize',25/tickFontSize)
set(0,'defaultlinelinewidth',3);

% Parameters which must be constant for unit testing to work
numToFind	= 42;
nOI			= 10;

% 
nu			= 30;
nv			= 10;
nel			= nu*nv;

uint8range	= 255;
image_d		= uint8range*rand(nv, nu);
img			= uint8(image_d);

%% Plot using imshow
figure(1);clf;
imshow(img, 'InitialMagnification', 'fit');
title('Pattern');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;

%% Cost over the image



%% Plot cost
% Plot cost in figure 2
figure(2);clf


%% Find minimums



%% Plot circles around results



%% Run tests on output
addpath ../../testfeedback

runAllTests();
restoredefaultpath