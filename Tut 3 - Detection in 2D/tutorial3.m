clc
clear

%% House Keeping
tickFontSize = 10;
set(0,'defaultaxesfontsize',tickFontSize)
set(0,'defaultaxeslabelfontsize',18/tickFontSize)
set(0,'defaultaxestitlefontsize',25/tickFontSize)

%% Number we are searching for
% Note: Tests will fail if this number is not 42
pattern     = 42;
data        = createImage(5, 20, pattern);

%% Plot using imshow
fh_image	= figure(1);clf;
set(fh_image,'color','w');
imshow(data, 'InitialMagnification', 'fit');
title('Pattern');
xlabel('u - [pixels]');
ylabel('v - [pixels]');
axis on
hold on;

%% Use for loop to find 42



%% Find the pixel equal to 42 without any for loops


%% Validate both methods agree
%HINT: use the Matlab function "assert"


%% Draw circle around pixel
% TODO: Complete the [x,y] = createCircle(xc, yc, r) function


%% TODO export figures


%% Run tests on output
addpath ../../testfeedback
runAllTests();
restoredefaultpath
