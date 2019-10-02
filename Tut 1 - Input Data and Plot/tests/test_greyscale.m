%% Main function to generate tests
function tests = test_greyscale(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

function test_F1A1_colour(testCase)
	global param;
	
	axes		= param.fig.axes(1);
	axes_h		= axes.handle;
	imagedata	= axes_h.Children.CData;
	[nv, nu, nc]= size(imagedata);
	actual		= imagedata;
	expectedDim	= [nv, nu, 3];
	

    assertSize(testCase, actual, expectedDim, 'Expecting a colour image in [figure 1 subplot 1]');
end

function test_F1A2_grey(testCase)
	global param;
	
	axes		= param.fig.axes(2);
	axes_h		= axes.handle;
	imagedata	= axes_h.Children.CData;
	[nv, nu, nc]= size(imagedata);
	actual		= imagedata;
	expectedDim	= [nv, nu, 1];
	

    assertSize(testCase, actual, expectedDim, 'Expecting a greyscale image in [figure 1 subplot 2]');
end

function teardownOnce(testCase)  % do not change function name
    clearvars -global param 
    
end

function setupOnce(testCase)
	global param
	% Figure 1
	param	= getAllFigureProperties();
end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
