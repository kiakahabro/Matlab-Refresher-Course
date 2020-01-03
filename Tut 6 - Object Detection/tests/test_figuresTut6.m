%% Main function to generate tests
function tests = test_figuresTut6(testCase)
tests = functiontests(localfunctions);

end

%% Test Functions
function test_f1_axes_has_graphics(testCase)
param                   = testCase.TestData.param;
f1                      = param.fig(1);
ah                      = f1.axes.handle;
ga                      = get(ah,'children');


expected				= 2;
actual					= length(ga);
assertEqual(testCase, expected, actual,'Expected 2 subplots in figure 1.');

end

function test_f2_axes_has_graphics(testCase)
param                   = testCase.TestData.param;
f2                      = param.fig(2);
ah                      = f2.axes.handle;
ga                      = get(ah,'children');


expected				= 1;
actual					= length(ga);
assertEqual(testCase, expected, actual,'Expected only one axis in figure 2.');

end

function test_f1PlotContents(testCase)
assumesPassed(testCase, @test_f1_axes_has_graphics);

param                   = testCase.TestData.param;
%% Check figure 1
f1                      = param.fig(1);
ah                      = f1.axes(1).handle;
ga                      = get(ah,'children');

nga                     = length(ga);
types                   = get(ga,'type');
%% Line
isline                  = strcmpi(types,'line');

actual = sum(isline);
expected = 1;
verifyEqual(testCase, actual,expected,...
    'Expecting 1 circle in Figure 1, subplot 1');
%% Image
isimage                  = strcmpi(types,'image');

actual = sum(isimage);
expected = 1;
verifyEqual(testCase, actual,expected,...
    'Expecting 1 image in Figure 1, subplot 1');
end

function test_f2plotContents(testCase)
assumesPassed(testCase, @test_f2_axes_has_graphics);

param                   = testCase.TestData.param;
f2                      = param.fig(2);
ah                      = f2.axes.handle;
ga                      = get(ah,'children');
type = get(ga,'type');

actual = type;
expected = 'contour';

verifyMatches(testCase,actual,expected,...
    'Expected figure 2 to contain a contour plot.')

end

function test_circleCentredCorrect(testCase)

assumesPassed(testCase, @test_f2plotContents, @test_f1_axes_has_graphics);

param                   = testCase.TestData.param;
f1						= param.fig(1);
ah                      = f1.axes(1).handle;
ga                      = get(ah,'children');

nga                     = length(ga);
types                   = get(ga,'type');

isline                  = strcmpi(types,'line');
gaCircle                = ga(isline);
%%
f2						= param.fig(2);
ah                      = f2.axes(1).handle;
ga                      = get(ah,'children');

score = ga.ZData;

xc = round(mean(gaCircle.XData));
yc = round(mean(gaCircle.YData));

expected = 1;
actual = score(yc,xc);
verifyEqual(testCase,actual,expected,'abstol',1e-5,...
    'Expected the score ploted in figure 2 to equal 1 at the pixel the circle is centred around in figure 1.');
end

function teardownOnce(testCase)  % do not change function name

end

function setupOnce(testCase)
drawnow;
testCase.TestData.param	= getAllFigureProperties();
param		= testCase.TestData.param;

actual		= param.nfig;
expected	= 2;

assertEqual(testCase, actual, expected, 'All tests failed. Expected 2 active figures. \nConsider using the command ''close all'' to clear irrelevant active figures');

end

%% Optional fresh fixtures
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
