function [res, errmsg] = assumes(varargin)
%ASSUMES Summary of this function goes here
%   Detailed explanation goes here
	ntests		= nargin;
	namefail	= string;
	
	res			= false;
	errmsg	= "";
	
	j = 1;
	for i = 1:ntests
		fh			= varargin{i};
		fs			= functions(fh);
		filepath	= fs.file;
		fhname		= fs.function;
		testres		= runtests(filepath ,'ProcedureName',fhname, 'OutputDetail', 0);
		
		if(~testres.Passed)
			namefail(j)	= string(fhname);
			j = j+1;
		end
	end
	
	if(strlength(namefail)==0)
		res = true;
		return;
	end
	
	nfail	= length(namefail);
	
	for i = 1:nfail
		errmsg = errmsg + " - " + namefail(i) + "\n";
	end
	
end

