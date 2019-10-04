%% Main function to generate tests
function tests = test_greyscale(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

function test_numAxesF1(testCase)
	param 					= testCase.TestData.param;
	actual					= param.fig(1).nsubplot;
	expected				= 2;

    assertEqual(testCase, actual, expected, 'Incorrect number of subplots');
end

function test_F1A1_colour(testCase)
	param 					= testCase.TestData.param;

	assumesPassed(testCase, @test_numAxesF1);
	
	axes					= param.fig.axes(1);
	axes_h					= axes.handle;
	imagedata				= axes_h.Children.CData;
	[nv, nu, nc]			= size(imagedata);
	actual					= imagedata;
	expectedDim				= [nv, nu, 3];
	

    assertSize(testCase, actual, expectedDim, 'Expecting a colour image in [figure 1 subplot 1]');
end

function test_F1A2_grey(testCase)
	param 					= testCase.TestData.param;
	
	assumesPassed(testCase, @test_numAxesF1);

	axes					= param.fig.axes(2);
	axes_h					= axes.handle;
	imagedata				= axes_h.Children.CData;
	[nv, nu, nc]			= size(imagedata);
	actual					= imagedata;
	expectedDim				= [nv, nu, 1];
	

    assertSize(testCase, actual, expectedDim, 'Expecting a greyscale image in [figure 1 subplot 2]');
end

function teardownOnce(testCase)  % do not change function name
    
end

function setupOnce(testCase)
	testCase.TestData.param	= getAllFigureProperties();
	param					= testCase.TestData.param;
	
	actual					= param.nfig;
	expected				= 1;

    assertEqual(testCase, actual, expected, 'All tests failed. Expected 41 active figure. \nConsider using the command "close all" to clear irrelevant active figures');

end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
