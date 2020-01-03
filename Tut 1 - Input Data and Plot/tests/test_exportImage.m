%% Main function to generate tests
function tests = test_exportImage(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

function test_twoImages(testCase)
	
	imagepaths	= dir('./*.png');
	nimages		= length(imagepaths);
	
	expected	= 2;
	actual		= nimages;

    assertEqual(testCase, actual, expected, 'Expecting two images in directory "Figures"');
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
