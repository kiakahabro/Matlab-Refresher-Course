%% Main function to generate tests
function tests = test_imageFilter(testCase)
tests = functiontests(localfunctions);

end

%% Test Functions
function test_outputFloat(testCase)
f = testCase.TestData.f;
K = [0 0 0
    0 1 0
    0 0 0];
g = imageFilter(f,K);
verifyTrue(testCase, isfloat(g),...
    'Expected output of imageFilter to be a float, Hint: initialise the output variable as a double in imageFilter.')

end

function test_outputSize(testCase)

f = testCase.TestData.f;
K = [0 0 0
    0 1 0
    0 0 0];
g = imageFilter(f,K);

actual = g;
expectedSize = size(f);
verifySize(testCase, actual, expectedSize,...
    'Expected the dimensions of the output of imageFilter to the same as the input image.')
end

function test_outputIdentity1(testCase)
f = testCase.TestData.f;
K = [1];
g = imageFilter(f,K);

actual = double(g);
expected = double(f);
verifyEqual(testCase, actual, expected,'absTol',1e-5,...
    'Expected output to equal input for a trivial kernel [1].')
end

function test_outputIdentity3(testCase)
f = testCase.TestData.f;
K = zeros(3,3);
K(2,2) = 1;
g = imageFilter(f,K);

actual = double(g);
expected = double(f);
verifyEqual(testCase, actual, expected,'absTol',1e-5,...
    'Expected output to equal input for a trivial kernel with size 3x3.')
end

function test_outputIdentity5(testCase)
f = testCase.TestData.f;
K = zeros(5,5);
K(3,3) = 1;
g = imageFilter(f,K);

actual = double(g);
expected = double(f);
verifyEqual(testCase, actual, expected,'absTol',1e-5,...
    'Expected output to equal input for a trivial kernel with size: 5x5.')
end

function test_symmetricKernel(testCase)
f = testCase.TestData.f;
K = testCase.TestData.K_gaussian;
g = imageFilter(f,K);

actual = g;
expected = filter2(K,f,'same');
verifyEqual(testCase, actual, expected,'absTol',1e-5,...
    'Expected output to be consistent with Matlab convolution for a symetric kernel.')
end

function test_squareKernel(testCase)
f = testCase.TestData.f;
K = testCase.TestData.K;
g = imageFilter(f,K);

actual = g;
expected = filter2(K,f,'same');
verifyEqual(testCase, actual, expected,'absTol',1e-5,...
    'Expected output to be consistent with Matlab convolution.')
end

function test_rectengularKernel(testCase)
f = testCase.TestData.f;
K = testCase.TestData.K(1:end-2,:);
g = imageFilter(f,K);

actual = g;
expected = filter2(K,f,'same');
verifyEqual(testCase, actual, expected,'absTol',1e-5,...
    'Expected output to be consistent with Matlab convolution.')
end



function test_useMetric(testCase)
f = testCase.TestData.f;
K = testCase.TestData.K(1:end-2,:);
%%
metric = @(a,b)pi;
g = imageFilter(f,K,metric);

actual = g;
expected = pi*ones(size(f));
verifyEqual(testCase,actual,expected, 'absTol',1e-5, ...
    'Expected different results for calling imageFilter with and without a metric.');
%%
metric = @zncc;
g = imageFilter(f,K);
gzncc = imageFilter(f,K,metric);

verifyNotEqual(testCase,g,gzncc, ...
    'Expected different results for calling imageFilter with and without a metric.');
end



function teardownOnce(testCase)  % do not change function name
rmpath ../
rng('shuffle');
end

function setupOnce(testCase)
addpath ../
rng(0)
testCase.TestData.f = uint8(randi(255,100,90));
testCase.TestData.K = rand(5,5);

sigma		= 1;
h			= ceil(3*sigma);
u			= -h:h;
v			= u;
U2			= u.^2;
V2			= v.^2;
cov			= U2+V2';
K_gaussian = 1/(2*pi*sigma) * exp(-cov./(2*sigma^2));
testCase.TestData.K_gaussian = K_gaussian/sum(K_gaussian(:));
end

%% Optional fresh fixtures
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
