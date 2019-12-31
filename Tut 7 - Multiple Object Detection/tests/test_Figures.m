%% Main function to generate tests
function tests = test_image(testCase)
tests = functiontests(localfunctions);

end

%% Test Functions
function test_figure1axes(testCase)
param                   = testCase.TestData.param;
f1                      = param.fig(1);

expected				= 2;
actual					= f1.nsubplot;
assertEqual(testCase, expected, actual,'Expected 2 subplots in figure 1.');

end

function test_figure2axes(testCase)
param                   = testCase.TestData.param;
f2                      = param.fig(2);

expected				= 1;
actual					= f2.nsubplot;
assertEqual(testCase, expected, actual,'Expected only one axis in figure 2.');

end

function test_figure1Content(testCase)
assumesPassed(testCase, @test_figure1axes);
param                   = testCase.TestData.param;
%% Check figure 1, subplot 1
f1                      = param.fig(1);
ah                      = f1.axes(1).handle;
ga                      = get(ah,'children');

nga                     = length(ga);
actual = nga;
expected = 1;
verifyEqual(testCase, actual, expected, ...
    'Expected only 1 thing plotted in subplot 1.')

ctypes = get(ga,'type');
%% Image
isimage                  = strcmpi(ctypes,'image');
actual = sum(isimage);
expected = 1;
verifyEqual(testCase,actual,expected,...
    'Expected 1 image in Figure 1, subplot 1.')



%% Check figure 1, subplot 2
f1                      = param.fig(1);
ah                      = f1.axes(2).handle;
ga                      = get(ah,'children');

nga                     = length(ga);
ctypes                   = get(ga,'type');


%% Line
isline                  = strcmpi(ctypes,'line');
actual = sum(isline);
floor = 1;
verifyGreaterThan(testCase,actual,floor,...
    'Expected multiple circles in subplot 2.')
%% Image
isimage     = strcmpi(ctypes, 'image');

actual      = sum(isimage);
expected    = 1;
verifyEqual(testCase, actual,expected,...
    'Expecting 1 image in Figure 1, subplot 2');
end

function test_figure2Content(testCase)
assumesPassed(testCase, @test_figure2axes);

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

function test_circleNumber(testCase)
assumesPassed(testCase,@test_figure1Content,@test_figure2Content)

param                   = testCase.TestData.param;
%Get number of circles
f1                      = param.fig(1);
ah                      = f1.axes(2).handle;
ga                      = get(ah,'children');

ctypes                   = get(ga,'type');
isline                  = strcmpi(ctypes,'line');

% Get score
f2                      = param.fig(2);
ah                      = f2.axes.handle;
ga                      = get(ah,'children');

score = ga.ZData;

expected = sum(score>0.8,'all');
actual   = sum(isline);
verifyEqual(testCase,actual,expected, ...
    'Expected the number of circles plotted to be equal to the number of pixels scoring higher than 0.8')

end

function test_circleCentresUnique(testCase)
assumesPassed(testCase,@test_figure1Content)

param                   = testCase.TestData.param;
%Get number of circles
f1                      = param.fig(1);
ah                      = f1.axes(2).handle;
ga                      = get(ah,'children');

ctypes                   = get(ga,'type');
isline                  = strcmpi(ctypes,'line');
Circle = ga(isline);

centre = nan(length(Circle),1);
for i = 1:length(Circle)
    centre(i,1) = round(mean(Circle(i).XData));
    centre(i,2) = round(mean(Circle(i).YData));
end

actual   = length(centre);
expected = length(unique(centre,'row'));
verifyEqual(testCase,actual,expected, ...
    'Expected all circles plotted to be unique.')
end

function test_circleCentredCorrect(testCase)
assumesPassed(testCase,@test_figure1Content,@test_figure2Content)

param                   = testCase.TestData.param;
%Get circle centres
f1                      = param.fig(1);
ah                      = f1.axes(2).handle;
ga                      = get(ah,'children');

ctypes                   = get(ga,'type');
isline                  = strcmpi(ctypes,'line');
Circle = ga(isline);

centre = nan(length(Circle),1);
for i = 1:length(Circle)
    centre(i,1) = round(mean(Circle(i).XData));
    centre(i,2) = round(mean(Circle(i).YData));
end

% Get score
f2                      = param.fig(2);
ah                      = f2.axes.handle;
ga                      = get(ah,'children');

score = ga.ZData;

for i =1:length(Circle)
u = centre(i,1);
v = centre(i,2);

actual = score(v,u);
floor = 0.8;
msg = sprintf('The circle centred at [u,v] = [%d,%d] does not correspond to a score greather than 0.8 in the input image.',u,v);
verifyGreaterThan(testCase, actual,floor, ...
    msg)
end



centreScores = score(u,v);

% assertFail(testCase,'unconditional fail')
% assumesPassed(testCase, @test_figure2axes);
% 
% param                   = testCase.TestData.param;
% f1						= param.fig(1);
% ah                      = f1.axes(1).handle;
% ga                      = get(ah,'children');
% 
% nga                     = length(ga);
% types                   = get(ga,'type');
% stypes                  = string;
% for i = 1:nga
%     stypes(i)               = types{i};
% end
% isline                  = strcmpi(stypes,'line');
% gaCircle                = ga(isline);
% %%
% f2						= param.fig(2);
% ah                      = f2.axes(1).handle;
% ga                      = get(ah,'children');
% 
% score = ga.ZData;
% 
% xc = round(mean(gaCircle.XData));
% yc = round(mean(gaCircle.YData));
% 
% expected = 1;
% actual = score(yc,xc);
% verifyEqual(testCase,actual,expected,'abstol',1e-5,...
%     'Expected the score ploted in figure 2 to equal 1 at the pixel the circle is centred around in figure 1.');
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
