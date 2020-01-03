%% Main function to generate tests
function tests = test_image(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

function test_plot_axes_has_graphics(testCase)
    param                   = testCase.TestData.param;
    f1                      = param.fig(1);
	ah                      = f1.axes.handle;
    ga                      = get(ah,'children');
    
	
	expected				= 2;
	actual					= length(ga);
    assertEqual(testCase, expected, actual,'Expecting both image and circle to be in the same axes\n');

end

function test_plot_has_circle(testCase)
    assumesPassed(testCase, @test_plot_axes_has_graphics);

    param                   = testCase.TestData.param;
    f1                      = param.fig(1);
	ah                      = f1.axes.handle;
    ga                      = get(ah,'children');
    
	h_plot					= ga(1);
	
	actual					= get(h_plot,'type');
	expected				= 'line';
	isplot					= strcmpi(actual, expected);
    assertTrue(testCase, isplot,'Expecting circle to be in figure');
end

function test_plot_has_image(testCase)
    assumesPassed(testCase, @test_plot_axes_has_graphics);

    param                   = testCase.TestData.param;
	f1						= param.fig(1);
	ah                      = f1.axes(1).handle;
	ga                      = get(ah,'children');
    
	h_image					= ga(2);
	
	actual					= get(h_image,'type');
	expected				= 'image';
	isimage					= strcmpi(actual, expected);
    assertTrue(testCase, isimage,'Expecting image to be in figure');
end

function test_circleCentredCorrect(testCase)

    assumesPassed(testCase, @test_plot_has_circle, @test_plot_has_image);
    param                   = testCase.TestData.param;
	f1						= param.fig(1);
	ah                      = f1.axes(1).handle;
	ga                      = get(ah,'children');
    
	h_image                 = ga(2);
	h_plot					= ga(1);
	
    image                   = get(h_image,'cdata');
    
    [y42, x42]              = find(image==42);
    
    x                       = get(h_plot,'xdata');
    y                       = get(h_plot,'ydata');
	
    expected                = x42;
    actual                  = mean(x);
    assertEqual(testCase, expected, actual,'abstol',0.1,'Expecting the x component of the circle to be centred on 42');

    expected                = y42;
    actual                  = mean(y);
    assertEqual(testCase, expected, actual,'abstol',0.1,'Expecting the y component of the circle to be centred on 42');


end
    
function teardownOnce(testCase)  % do not change function name
   
end

function setupOnce(testCase)
	testCase.TestData.param	= getAllFigureProperties();
	param		= testCase.TestData.param;
	
	actual		= param.nfig;
	expected	= 1;

    assertEqual(testCase, actual, expected, 'All tests failed. Expected 1 active figures. \nConsider using the command ''close all'' to clear irrelevant active figures');

end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
