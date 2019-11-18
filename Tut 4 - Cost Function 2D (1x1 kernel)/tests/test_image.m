%% Main function to generate tests
function tests = test_image(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

function test_f1_axes_has_graphics(testCase)
    param                   = testCase.TestData.param;
    f1                      = param.fig(1);
	ah                      = f1.axes.handle;
    ga                      = get(ah,'children');
    
	
	expected				= 1;
	actual					= length(ga);
    assertEqual(testCase, expected, actual,'Expecting only an image to be in figure 1\n');

end

function test_f2_axes_has_graphics(testCase)
    param                   = testCase.TestData.param;
    f2                      = param.fig(2);
	ah                      = f2.axes.handle;
    ga                      = get(ah,'children');
    
	
	expected				= 11;
	actual					= length(ga);
    assertEqual(testCase, expected, actual,'Expecting both image and 10 circles to be in the same axes in figure 2\n');

end


function test_plot_has_image(testCase)
    assumesPassed(testCase, @test_f1_axes_has_graphics, @test_f2_axes_has_graphics);
    
    param                   = testCase.TestData.param;
    
	f1						= param.fig(1);
	ah                      = f1.axes.handle;
	ga                      = get(ah,'children');
    
    
    types                   = {get(ga,'type')};
	isimage                 = types == "image";
    nimage                  = sum(isimage);
    
	actual					= nimage;
	expected				= 1;
    assertEqual(testCase, expected, actual,'Expecting one image to be in figure 1');
    
	f2						= param.fig(2);
	ah                      = f2.axes(1).handle;
	ga                      = get(ah,'children');
    
    nga                     = length(ga);
    types                   = get(ga,'type');
    stypes                  = string;
    for i = 1:nga
        stypes(i)               = types{i};
    end
	
	isimage                 = stypes == "image";
    nimage                  = sum(isimage);
    
	actual					= nimage;
	expected				= 1;
    assertEqual(testCase, expected, actual,'Expecting one image to be in figure 2');
end

function test_plot_has_circles(testCase)
    assumesPassed(testCase, @test_f1_axes_has_graphics, @test_f2_axes_has_graphics);

    param                   = testCase.TestData.param;
    
    %% Check figure 1
    f1                      = param.fig(1);
	ah                      = f1.axes.handle;
    ga                      = get(ah,'children');
    
	nga                     = length(ga);
    types                   = {get(ga,'type')};
    stypes                  = string;
    for i = 1:nga
        stypes(i)               = types{i};
    end
	
    isline                  = stypes == "line";
	
	isplot					= sum(isline)==0;
    assertTrue(testCase, isplot,'Expecting no circles or lines to be in figure 1');
    
    %% Check figure 2
    f2                      = param.fig(2);
	ah                      = f2.axes.handle;
    ga                      = get(ah,'children');
    
	nga                     = length(ga);
    types                   = get(ga,'type');
    stypes                  = string;
    for i = 1:nga
        stypes(i)               = types{i};
    end
	
    isline                  = stypes == "line";
    isplot					= sum(isline)>0;
	assertTrue(testCase, isplot,'Expecting circles to be in figure 2');
end

function test_costSorted(testCase)

    assumesPassed(testCase, @test_plot_has_circles, @test_plot_has_image);
    
    param                   = testCase.TestData.param;
    f2                      = param.fig(2);
	ah                      = f2.axes.handle;
    ga                      = get(ah,'children');
    
    types                   = get(ga,'type');
    stypes                  = string;
    for i = 1:length(types)
        stypes(i)               = types{i};
    end
	
    isline                  = stypes == "line";
    isimage                 = stypes == "image";
	circs                   = ga(isline);
    
    costval                 = get(ga(isimage), 'cdata');
    
    ncirc                   = length(circs);
    cost                    = zeros(ncirc,1);
    for i = 1:ncirc
        h_plot                  = circs(i);
        x                       = mean(get(h_plot,'xdata'));
        y                       = mean(get(h_plot,'ydata'));
        xidx                    = round(x);
        yidx                    = round(y);
        cost(i)              	= costval(yidx, xidx);
    end

    dc                      = diff(cost);
    isIncreasing            = all(dc<=0);
    
    assertTrue(testCase, isIncreasing, 'Circles are not plotted in order of increasing cost');
end


function test_circleCentredCorrect(testCase)

    assumesPassed(testCase, @test_costSorted);
    param                   = testCase.TestData.param;
	f1						= param.fig(1);
	ah                      = f1.axes(1).handle;
	ga                      = get(ah,'children');
    
	
    
    h_image                 =ga;
    
    f2						= param.fig(2);
	ah                      = f2.axes(1).handle;
	ga                      = get(ah,'children');
    types                   = get(ga,'type');
    stypes                  = string;
    for i = 1:length(types)
        stypes(i)               = types{i};
    end
	isline                  = stypes == "line";
    h_allplot               = ga(isline);
    h_plot                  = h_allplot(end); % first plot
    
    image                   = get(h_image,'cdata');
    
    numToFind               = 42;
    f                       = (double(image) - numToFind).^2;
    
    [~, idx]                = min(f(:));
    [y42, x42]              = ind2sub(size(f), idx);
    
    x                       = mean(get(h_plot,'xdata'));
    y                       = mean(get(h_plot,'ydata'));
	
    expected                = x42;
    actual                  = round(mean(x));
    assertEqual(testCase, expected, actual,'abstol',0.1,sprintf('Expecting the x component of the circle to be centred on 42.\nxc = %g, expected xc = %g', actual, expected));

    expected                = y42;
    actual                  = round(mean(y));
    assertEqual(testCase, expected, actual,'abstol',0.1,sprintf('Expecting the y component of the circle to be centred on 42.\nyc = %g, expected yc = %g', actual, expected));


end
    
function teardownOnce(testCase)  % do not change function name
   
end

function setupOnce(testCase)
    drawnow;
	testCase.TestData.param	= getAllFigureProperties();
	param		= testCase.TestData.param;
	
	actual		= param.nfig;
	expected	= 2;

    assertEqual(testCase, actual, expected, 'All tests failed. Expected 2 active figures. \nConsider using the command "close all" to clear irrelevant active figures');

end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
