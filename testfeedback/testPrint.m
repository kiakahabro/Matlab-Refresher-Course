function testPrint(testResults)

	ntests		= length(testResults);
	idx			= 1:ntests;
	
	fail_log	= [testResults.Failed];
	incomp_log	= [testResults.Incomplete] & ~fail_log;
	pass_log	= [testResults.Passed];
	
	fail_idx	= find([testResults.Failed]);
	incomp_idx	= find([testResults.Incomplete] & ~[testResults.Failed]);
	pass_idx	= find([testResults.Passed]);
	
	
	
	nfailed		= length(fail_idx);
	
	npassed		= sum(pass_log);
	
	tick		= @()cprintf('green'," %c ", char(hex2dec('2713')));
	cross		= @()cprintf('red', " %c ", char(hex2dec('2717')));
	question	= @()cprintf('*orange', ' ? ');
	
	
	
	if(nfailed~=0)
		cprintf('*red','%d/%d tests passed\n', npassed, ntests);
	else
		cprintf('*green','All tests passed!\n');
	end
	
	for j = 1:ntests
		testname	= testResults(j).Name;
		passed		= pass_log(j);
		incomplete	= incomp_log(j);
		failed		= fail_log(j);
		if(passed)
			tick();
			cprintf('black','%s\n', testname);
		elseif(incomplete)
			question();
			cprintf('black','%s\n', testname);
			cprintf('black','\t%s\n', "Test ignored. Depends on:");
			
			outString	= testHelpString(testResults(j));
			
			outStrs		= strsplit(outString, "\\n");
			noutstrs	= length(outStrs);
			for ii = 1:(noutstrs-1)
				cprintf('black','\t%s passing\n', outStrs(ii));
			end
		elseif(failed)
			cross();
			cprintf('black','%s\n', testname);
			
			outString	= testHelpString(testResults(j));
			
			outStrs		= strsplit(outString, "\\n");
			noutstrs	= length(outStrs);
			
			cprintf('red','   %s\n', outStrs(1));
			for ii = 2:(noutstrs-1)
				cprintf('black','\t%s\n', outStrs(ii));
			end
			
		end
		
		if(nfailed~=0)
			
			
		end
		
	end
	
	