function [outString, npassed, ntests]  = testToString(testResults)

	outString	= "";
	fail_idx	= find([testResults.Failed]);
	nfailed		= length(fail_idx);
	ntests		= length(testResults);
	npassed		= length(testResults) - nfailed;
	if(nfailed~=0)
		outString = string(npassed) + "/" + string(ntests) + " tests passed\n";
	end
	
	for j = 1:nfailed
		jj			= fail_idx(j);
		string1		= testResults(jj).Details.DiagnosticRecord.Event;
		if strcmpi(string1,'VerificationFailed')
			for ii = 1:length(testResults(jj).Details.DiagnosticRecord)
				outString = outString + string(testResults(jj).Details.DiagnosticRecord(ii).TestDiagnosticResults.DiagnosticText) + "\n";
			end
		elseif strcmpi(string1,'ExceptionThrown')
			if contains(testResults(jj).Details.DiagnosticRecord.Exception.message,"href")
				%                        error("contains a href")
				msg = regexprep(string(testResults(jj).Details.DiagnosticRecord.Exception.message),["Error:(.+)File:",".</a>"],["Error in file","\r\n"]);
				outString = outString+ msg + "\n";

			else
				outString = outString + string(testResults(jj).Details.DiagnosticRecord.Exception.message) + "\n";
			end
		elseif strcmpi(string1,'AssertionFailed')
			for ii = 1:length(testResults(jj).Details.DiagnosticRecord)
				outString = outString + string(testResults(jj).Details.DiagnosticRecord(ii).TestDiagnosticResults.DiagnosticText) + "\n";
			end
		else
			disp(string1)
			error('test failure mode not yet encountered')
		end
	end
	
	if(outString.strlength == 0)
		outString = "All tests passed!\n";
	end