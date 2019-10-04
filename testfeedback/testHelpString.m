function outString = testHelpString(testRes)
%TESTHELPSTRING Summary of this function goes here
%   Detailed explanation goes here
	outString	= "";
	string1		= testRes.Details.DiagnosticRecord.Event;
	if strcmpi(string1,'VerificationFailed')
		for ii = 1:length(testRes.Details.DiagnosticRecord)
			outString = outString + string(testRes.Details.DiagnosticRecord(ii).TestDiagnosticResults.DiagnosticText) + "\n";
		end
	elseif strcmpi(string1,'ExceptionThrown')
		if contains(testRes.Details.DiagnosticRecord.Exception.message,"href")
			%                        error("contains a href")
			msg = regexprep(string(testRes.Details.DiagnosticRecord.Exception.message),["Error:(.+)File:",".</a>"],["Error in file","\r\n"]);
			outString = outString+ msg + "\n";

		else
			outString = outString + string(testRes.Details.DiagnosticRecord.Exception.message) + "\n";
		end
	elseif strcmpi(string1,'AssertionFailed')
		for ii = 1:length(testRes.Details.DiagnosticRecord)
			outString = outString + string(testRes.Details.DiagnosticRecord(ii).TestDiagnosticResults.DiagnosticText) + "\n";
		end
	elseif strcmpi(string1,'AssumptionFailed')
		for ii = 1:length(testRes.Details.DiagnosticRecord)
			outString = outString + string(testRes.Details.DiagnosticRecord(ii).TestDiagnosticResults.DiagnosticText) + "\n";
		end
	else

		disp(string1)
		error('test failure mode not yet encountered')
	end

end

