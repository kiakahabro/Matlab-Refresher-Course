%% Main function to generate tests
function tests = test_forVsIdx(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

%% Check for one subplot
function test_numAxesF3(testCase)
	param 					= testCase.TestData.param;
	
	actual					= param.fig(3).nsubplot;
	expected				= 1;

    assertEqual(testCase, actual, expected, 'Expecting one subplot in figure 3');
end

function test_numAxesF4(testCase)
	param 					= testCase.TestData.param;
	
	actual					= param.fig(4).nsubplot;
	expected				= 1;

    assertEqual(testCase, actual, expected, 'Expecting one subplot in figure 4');
end


function test_F3_naming(testCase)
	param 					= testCase.TestData.param;

	assumesPassed(testCase, @test_numAxesF3);


	f3						= param.fig(3);
	
	axes					= f3.axes(1);
	
	actual_label			= axes.title;
	exp_label.string		= "Find with for loop";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 25;
	checkFields(testCase, '[figure 3] at title', actual_label, exp_label);
	
	actual_label			= axes.xlabel;
	exp_label.string		= "u - [pixels]";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 3] at xlabel', actual_label, exp_label);
	
	actual_label			= axes.ylabel;
	exp_label.string		= "Pixel occupation";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 3] at ylabel', actual_label, exp_label);
end

function test_F4_naming(testCase)
	param 					= testCase.TestData.param;

	assumesPassed(testCase, @test_numAxesF4);
	

	f4						= param.fig(4);
	
	axes					= f4.axes(1);
	
	actual_label			= axes.title;
	exp_label.string		= "Find with indexing";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 25;
	checkFields(testCase, '[figure 4] at title', actual_label, exp_label);
	
	actual_label			= axes.xlabel;
	exp_label.string		= "u - [pixels]";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 4] at xlabel', actual_label, exp_label);
	
	actual_label			= axes.ylabel;
	exp_label.string		= "Pixel occupation";
	exp_label.interpreter	= "latex";
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 4] at ylabel', actual_label, exp_label);
end

function test_F3_bar(testCase)

	assumesPassed(testCase, @test_numAxesF4);
	
	param 					= testCase.TestData.param;
	f3						= param.fig(3);
	f3ah					= f3.axes(1).handle;
	h_plot					= get(f3ah,'Children');
	
	actual					= get(h_plot,'type');
	expected				= 'bar';
	isbar					= strcmpi(actual, expected);
	assertTrue(testCase, isbar, 'Expecting a bar plot in figure 3');
end

function test_F4_bar(testCase)

	assumesPassed(testCase, @test_numAxesF4);
	
	param 					= testCase.TestData.param;
	f4						= param.fig(4);
	f4ah					= f4.axes(1).handle;
	h_plot					= get(f4ah,'Children');
	
	actual					= get(h_plot,'type');
	expected				= 'bar';
	isbar					= strcmpi(actual, expected);
	assertTrue(testCase, isbar, 'Expecting a bar plot in figure 4');
		
end

function test_F3_equal_F4_bar(testCase)


	assumesPassed(testCase, @test_F3_bar, @test_F4_bar);
	
	param 					= testCase.TestData.param;
	f3						= param.fig(3);
	f3ah					= f3.axes(1).handle;
	h3_plot					= get(f3ah,'Children');
	h3_data					= get(h3_plot,'ydata');
	
	f4						= param.fig(4);
	f4ah					= f4.axes(1).handle;
	h4_plot					= get(f4ah,'Children');
	h4_data					= get(h4_plot,'ydata');
	
	expected				= h3_data;
	actual					= h4_data;
	
	assertEqual(testCase, actual, expected, 'Expecting data in figure 3 and figure 4 to be consistent');
end


function teardownOnce(testCase)  % do not change function name
    
    
end

function setupOnce(testCase)
	testCase.TestData.param	= getAllFigureProperties();
	param		= testCase.TestData.param;
	
	actual		= param.nfig;
	expected	= 4;

    assertEqual(testCase, actual, expected, 'All tests failed. Expected 4 active figures. \nConsider using the command "close all" to clear irrelevant active figures');

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

	% actual		= actual_label.interpreter;
	% expected	= expected_label.interpreter;
	% aestr(actual, expected, name + " interpreter");%assertEqual(testCase, actual, expected, sprintf('Failed on %s interpreter', name));

	% actual		= string(actual_label.fontsize);
	% expected	= string(expected_label.fontsize);
	% aestr(actual, expected, name + " fontsize");%assertEqual(testCase, actual, expected, sprintf('Failed on %s fontsize', name));
end
