function testPrint(testResults)

	fail_idx	= find([testResults.Failed]);
	nfailed		= length(fail_idx);
	ntests		= length(testResults);
	npassed		= length(testResults) - nfailed;
	
	tick		= @()cprintf('green'," %c ", char(hex2dec('2713')));
	cross		= @()cprintf('red', " %c ", char(hex2dec('2717')));
	
	
	
	if(nfailed~=0)
		cprintf('*red','%d/%d tests passed\n', npassed, ntests);
	else
		cprintf('*green','All tests passed!\n');
	end
	
	for j = 1:ntests
		testname	= testResults(j).Name;
		failed		= testResults(j).Failed == 1;
		if(~failed)
			tick();
			cprintf('black','%s\n', testname);
		
		else
			cross();
			cprintf('black','%s\n', testname);
			
			outString	= "";
			string1		= testResults(j).Details.DiagnosticRecord.Event;
			if strcmpi(string1,'VerificationFailed')
				for ii = 1:length(testResults(j).Details.DiagnosticRecord)
					outString = outString + string(testResults(j).Details.DiagnosticRecord(ii).TestDiagnosticResults.DiagnosticText) + "\n";
				end
			elseif strcmpi(string1,'ExceptionThrown')
				if contains(testResults(j).Details.DiagnosticRecord.Exception.message,"href")
					%                        error("contains a href")
					msg = regexprep(string(testResults(j).Details.DiagnosticRecord.Exception.message),["Error:(.+)File:",".</a>"],["Error in file","\r\n"]);
					outString = outString+ msg + "\n";

				else
					outString = outString + string(testResults(j).Details.DiagnosticRecord.Exception.message) + "\n";
				end
			elseif strcmpi(string1,'AssertionFailed')
				for ii = 1:length(testResults(j).Details.DiagnosticRecord)
					outString = outString + string(testResults(j).Details.DiagnosticRecord(ii).TestDiagnosticResults.DiagnosticText) + "\n";
				end
			else
				disp(string1)
				error('test failure mode not yet encountered')
			end
			
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
	
	