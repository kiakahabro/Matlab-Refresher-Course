function assumesPassed(test_case,varargin)
%ASSUMESPASSED Summary of this function goes here
%   Detailed explanation goes here
% 	[ares, astr]= assumes();
    ntests      = length(varargin);
    idx_fail    = false(ntests, 1);
    namefail    = string;
    j           = 1;
    

	tst         = test_case.copy();
    
    for t = 1:ntests
        f           = varargin{t};
        try
        	f(tst);
        catch
            fs              = functions(f);
            
            if(isempty(fs.file))
                error('Function %s does not exist', fs.function);
            end
            namefail(j)     = fs.function;
            idx_fail(t)     = true;
            j               = j + 1;
        end
    end
    
    nfail   = length(namefail);
    errmsg  = string;
    for i = 1:nfail
		errmsg = errmsg + " - " + namefail(i) + "\n";
    end
    
    ares    = sum(idx_fail)==0;
    
	assumeTrue(test_case, ares, errmsg);
end

