%% Main function to generate tests
function tests = test_imageVsBar(testCase)
	tests = functiontests(localfunctions);

end

%% Test Functions

%% Check for one subplot
function test_numAxesF1(testCase)
	param 			= testCase.TestData.param;
	
	actual			= param.fig(1).nsubplot;
	expected		= 1;
	
		
    assertEqual(testCase, actual, expected, 'Expecting one subplot in figure 1');
end

function test_numAxesF2(testCase)
	param 					= testCase.TestData.param;
	
	actual		= param.fig(2).nsubplot;
	expected	= 1;

    assertEqual(testCase, actual, expected, 'Expecting one subplot in figure 2');
end


function test_F1_naming(testCase)
	param 					= testCase.TestData.param;
	
	assumesPassed(testCase, @test_numAxesF1);
		
	f1						= param.fig(1);
	
	axes					= f1.axes(1);
	
	actual_label			= axes.title;
	exp_label.string		= 'Pattern';
	exp_label.interpreter	= 'latex';
	exp_label.fontsize		= 25;
	checkFields(testCase, '[figure 1] at title', actual_label, exp_label);
	
	actual_label			= axes.xlabel;
	exp_label.string		= 'u - [pixels]';
	exp_label.interpreter	= 'latex';
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 1] at xlabel', actual_label, exp_label);
	
	actual_label			= axes.ylabel;
	exp_label.string		= 'v - [pixels]';
	exp_label.interpreter	= 'latex';
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 1] at ylabel', actual_label, exp_label);
end

function test_F2_naming(testCase)

	
	param 					= testCase.TestData.param;
	
	assumesPassed(testCase, @test_numAxesF2);
		
	f2						= param.fig(2);
	
	axes					= f2.axes(1);
	
	actual_label			= axes.title;
	exp_label.string		= '1D Image';
	exp_label.interpreter	= 'latex';
	exp_label.fontsize		= 25;
	checkFields(testCase, '[figure 2] at title', actual_label, exp_label);
	
	actual_label			= axes.xlabel;
	exp_label.string		= 'u - [pixels]';
	exp_label.interpreter	= 'latex';
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 2] at xlabel', actual_label, exp_label);
	
	actual_label			= axes.ylabel;
	exp_label.string		= 'Image Intensity';
	exp_label.interpreter	= 'latex';
	exp_label.fontsize		= 18;
	checkFields(testCase, '[figure 2] at ylabel', actual_label, exp_label);
end

function test_F1_image(testCase)
	assumesPassed(testCase, @test_numAxesF1);
	
	param 					= testCase.TestData.param;
	f1						= param.fig(1);
	f1ah					= f1.axes(1).handle;
	h_plot					= get(f1ah,'Children');
	
	actual					= get(h_plot,'type');
	expected				= 'image';
	isimage					= strcmpi(actual, expected);
	assertTrue(testCase, isimage, 'Expecting an image in figure 1');
end

function test_F2_bar(testCase)

	assumesPassed(testCase, @test_numAxesF2);

	param 					= testCase.TestData.param;
	f2						= param.fig(2);
	f2ah					= f2.axes(1).handle;
	h_plot					= get(f2ah,'Children');
	
	actual					= get(h_plot,'type');
	expected				= 'bar';
	isimage					= strcmpi(actual, expected);
	assertTrue(testCase, isimage, 'Expecting a bar plot in figure 2');
end

function test_F1_equal_F2_image(testCase)
	
	assumesPassed(testCase, @test_numAxesF1, @test_numAxesF2);
	
	param 					= testCase.TestData.param;
	f1						= param.fig(1);
	f1ah					= f1.axes(1).handle;
	h1_plot					= get(f1ah,'Children');
	h1_data					= get(h1_plot,'cdata');
	
	f2						= param.fig(2);
	f2ah					= f2.axes(1).handle;
	h2_plot					= get(f2ah,'Children');
	h2_data					= get(h2_plot,'ydata');
	
	expected				= h1_data;
	actual					= h2_data;
	
	assertEqual(testCase, actual, expected, 'Expecting data in figure 1 and figure 2 to be consistent');
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
	
	aestr = @(a,e,name)(assertTrue(testCase, strcmpi(a, e), ['Failed on ', name, '.\nExpected: "', e, '" | Actual: "', a ,'" ']));
% 	assertEqual(testCase, actual, expected, sprintf('Failed on %s string', name));
	aestr(actual, expected, [name, ' string']);

end
