%% Main function to generate tests
function tests = test_zncc(testCase)
	tests = functiontests(localfunctions);
end

%% Test Functions

function test_outputDimension(testCase)
T = testCase.TestData.template;
s = zncc(T,zeros(size(T)));

actual = s;
expectedSize = [1 1];
verifySize(testCase,actual,expectedSize, ...
    'Expected the output of zncc to be a scalar.');
end

function test_identicalInput(testCase)
T = testCase.TestData.template;
s = zncc(T,T);

actual = s;
expected = 1;
verifyEqual(testCase,actual,expected, 'AbsTol',1e-5, ...
    'Expected the output of zncc to be 1 for I1 = I2.');
end

function test_invariantToIntensityScale(testCase)
T = testCase.TestData.template;
s = zncc(T,0.9*T);

actual = s;
expected = 1;
verifyEqual(testCase,actual,expected, 'AbsTol',1e-5, ...
    'Expected the output of zncc to be 1 for I2 = a*I1.');
end

function test_invariantToIntensityOffset(testCase)
T = testCase.TestData.template;
s = zncc(T,T+10);

actual = s;
expected = 1;
verifyEqual(testCase,actual,expected, 'AbsTol',1e-5, ...
    'Expected the output of zncc to be 1 for I2 = I1+b.');
end

function test_invariantToIntensityOffsetAndScale(testCase)
T = testCase.TestData.template;
s = zncc(T,0.9*T+10);

actual = s;
expected = 1;
verifyEqual(testCase,actual,expected, 'AbsTol',1e-5, ...
    'Expected the output of zncc to be 1 for I2 = a*I1+b.');
end

function teardownOnce(testCase)  % do not change function name
   rmpath ../
   rng('shuffle')
end

function setupOnce(testCase)
	addpath ../
    rng(0)
    testCase.TestData.template = randi(255,5,5);
    
end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
