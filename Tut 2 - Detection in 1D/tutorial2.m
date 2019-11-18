clc
clear

%% House Keeping
tickFontSize = 10;
set(0,'defaultaxesfontsize',tickFontSize)
set(0,'defaultaxeslabelfontsize',18/tickFontSize)
set(0,'defaultaxestitlefontsize',25/tickFontSize)

%% Number we are searching for
% Note: Tests will fail if this number is not 120
pattern				= 120;

%% Generate Fake Data


%% Find image statistics - max, min, and mean pixel value

% TODO: find image statistics

% TODO: Use disp or fprintf to print statistics to console


%% Plot using image
fh_image	= figure(1);clf;
% TODO: Use image plot to show data

% TODO: Labels


%% Plot using bar
fh_bar	= figure(2);clf;
% TODO: Use bar plot to show data

% TODO: Labels

%% Find with for loop
% TODO: Use for loop to find the location of "pattern"

% Display result from for loop
fh_forocc	= figure(3);clf;

% TODO: Use bar plot to show location of the pattern

% TODO: Labels

% TODO: Use disp or fprintf to print location to console

%% Find  with indexing
% TODO: Use logical indexing to find the location of "pattern"

fh_logicalocc	= figure(4);clf;

% TODO: Use bar plot to show location of the pattern

% TODO: Labels

% TODO: Use disp or fprintf to print location to console

%% Save images
savedir		= 'Figures';
savedirpath = [savedir, filesep];

% TODO: Save figures as png to the Figures directory


%% Run tests on output
addpath ../testfeedback
runAllTests();
restoredefaultpath
