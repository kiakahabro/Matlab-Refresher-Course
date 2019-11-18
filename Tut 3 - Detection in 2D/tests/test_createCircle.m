%% Main function to generate tests
function tests = test_createCircle(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

function test_numOfPoints(testCase)
    yc              = 0;
    xc              = 0;
    r               = 0;
    
    [x, y]          = createCircle(xc, yc, r);
    
    is_same_dim     = numel(x)==numel(y);
    
    assertTrue(testCase, is_same_dim, 'Expected x and y to have the same dimensions');
    
    is_large_enough    = numel(x)>12;
    assertTrue(testCase, is_large_enough, 'Expected x and y to have dimension of at least 12');
    
end

function test_zeroRadiusZeroCentre(testCase)
    yc          = 0;
    xc          = 0;
    r           = 0;
    
    [x, y]      = createCircle(xc, yc, r);
    
    xc_ap       = mean(x);
    yc_ap       = mean(y);
    
    
    
    expected    = xc;
    actual      = xc_ap;
    assertEqual(testCase, expected, actual, 'Expected x to be zero when (xc,yc,r) = (0,0,0)');
    
    expected    = yc;
    actual      = yc_ap;
    assertEqual(testCase, expected, actual, 'Expected y to be zero when (xc,yc,r) = (0,0,0)');
    
end 

function test_zeroRadiusOffset(testCase)

    assumesPassed(testCase, @test_zeroRadiusZeroCentre);
    yc          = 1;
    xc          = 2;
    r           = 0;
    
    [x, y]      = createCircle(xc, yc, r);
    
    xc_ap       = mean(x);
    yc_ap       = mean(y);
    
    expected    = xc;
    actual      = xc_ap;
    assertEqual(testCase, expected, actual, 'Expected x to be 2 when (xc,yc,r) = (2,1,0)');
    
    expected    = yc;
    actual      = yc_ap;
    assertEqual(testCase, expected, actual, 'Expected y to be 1 when (xc,yc,r) = (2,1,0)');
    
end 
    
function test_oneRadiusZeroCentre(testCase)

    assumesPassed(testCase, @test_zeroRadiusZeroCentre, @test_numOfPoints);
    yc          = 0;
    xc          = 0;
    r           = 1;
    
    [x, y]      = createCircle(xc, yc, r);
    
    expected    = r*ones(size(x));
    actual      = sqrt(x.^2 + y.^2);
    assertEqual(testCase, expected, actual, 'Abstol', 1e-6, 'Expected (x^2 + y^2) to equal 1 when (xc,yc,r) = (0,0,1)');
    
end 

function test_twoRadiusZeroCentre(testCase)

    assumesPassed(testCase, @test_zeroRadiusZeroCentre, @test_numOfPoints);
    yc          = 0;
    xc          = 0;
    r           = 2;
    
    [x, y]      = createCircle(xc, yc, r);
    
    expected    = r*ones(size(x));
    actual      = sqrt(x.^2 + y.^2);
    assertEqual(testCase, expected, actual, 'Abstol', 1e-6, 'Expected (x^2 + y^2) to equal 2 when (xc,yc,r) = (0,0,2)');
    
end 

    
function teardownOnce(testCase)  % do not change function name
   rmpath ../
end

function setupOnce(testCase)
	addpath ../
end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
