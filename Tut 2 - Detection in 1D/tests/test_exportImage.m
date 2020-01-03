%% Main function to generate tests
function tests = test_exportImage(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

function test_fourImages(testCase)
	
	imagepaths	= dir('../*/*.png');
	nimages		= length(imagepaths);
	
	expected	= 4;
	actual		= nimages;

    assertEqual(testCase, actual, expected, 'Expecting four images in directory ''Figures''');
end



function teardownOnce(testCase)  % do not change function name
   
end

function setupOnce(testCase)
	
end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end
