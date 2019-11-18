%% Main function to generate tests
function tests = test_figureLabeling(testCase)
	tests = functiontests(localfunctions);
end

%% Test Functions

function test_numAxesF1(testCase)
	param 					= testCase.TestData.param;
	actual					= param.fig(1).nsubplot;
	expected				= 2;
    
    assertEqual(testCase, actual, expected, 'Incorrect number of subplots');
end

function test_F1A1_naming(testCase)
	param 					= testCase.TestData.param;

	assumesPassed(testCase, @test_numAxesF1);

	f1						= param.fig(1);
	
	axes					= f1.axes(1);
	
	actual_label			= axes.title;
	exp_label.string		= "Colour Wally";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 25;
	checkFields(testCase, '[figure 1 subplot 1] at title', actual_label, exp_label);
	
	actual_label			= axes.xlabel;
	exp_label.string		= "u - [pixels]";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 1 subplot 1] at xlabel', actual_label, exp_label);
	
	actual_label			= axes.ylabel;
	exp_label.string		= "v - [pixels]";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 1 subplot 1] at ylabel', actual_label, exp_label);
end

function test_F1A2_naming(testCase)

	assumesPassed(testCase, @test_numAxesF1);

	param 					= testCase.TestData.param;
	f1			= param.fig(1);
	
	axes		= f1.axes(2);
	actual_label			= axes.title;
	exp_label.string		= "Greyscale Wally";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 25;
	checkFields(testCase, '[figure 1 subplot 2] at title', actual_label, exp_label);
	
	actual_label			= axes.xlabel;
	exp_label.string		= "u - [pixels]";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 1 subplot 2] at xlabel', actual_label, exp_label);
	
	actual_label			= axes.ylabel;
	exp_label.string		= "v - [pixels]";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 1 subplot 2] at ylabel', actual_label, exp_label);
end

function teardownOnce(testCase)  % do not change function name
    
end

function setupOnce(testCase)
	testCase.TestData.param	= getAllFigureProperties();
	param		= testCase.TestData.param;
	
	actual		= param.nfig;
	expected	= 1;

    assertEqual(testCase, actual, expected, 'All tests failed. Expected 1 active figures. \nConsider using the command "close all" to clear irrelevant active figures');

end

%% Optional fresh fixtures  
function setup(testCase)  % do not change function name
end

function teardown(testCase)  % do not change function name
end

function checkFields(testCase, name, actual_label, expected_label)
	actual		= actual_label.string;
	expected	= expected_label.string;
	
	aestr = @(a,e,name)(assertTrue(testCase, strcmpi(a, e), "Failed on " + name + ".\nExpected: """ + e + """ | Actual: """ + a + """ "));
% 	assertEqual(testCase, actual, expected, sprintf('Failed on %s string', name));
	aestr(actual, expected, name + " string");

% 	actual		= actual_label.interpreter;
% 	expected	= expected_label.interpreter;
% 	aestr(actual, expected, name + " interpreter");%assertEqual(testCase, actual, expected, sprintf('Failed on %s interpreter', name));

	actual		= string(actual_label.fontsize);
	expected	= string(expected_label.fontsize);
	aestr(actual, expected, name + " fontsize");%assertEqual(testCase, actual, expected, sprintf('Failed on %s fontsize', name));
end
