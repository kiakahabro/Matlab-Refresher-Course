function assumesPassed(testCase,varargin)
%ASSUMESPASSED Summary of this function goes here
%   Detailed explanation goes here
	[ares, astr]= assumes(varargin{:});
	assumeTrue(testCase, ares, astr);
end

