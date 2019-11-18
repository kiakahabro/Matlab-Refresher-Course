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
        full_error_msg  = string(testRes.Details.DiagnosticRecord.Exception.message);
        stack           = testRes.Details.DiagnosticRecord.Exception.stack;
        error_file      = string(stack(1).name);
        error_line      = stack(1).line;
        error_path      = string(stack(1).file);
        
        %% Find test file parent directory
        cdir            = string(pwd);
        cdirspt         = cdir.split(filesep);
       
        testparent_path = string;
        for i = 1:(length(cdirspt)-1)
            if(i>1)
                testparent_path = testparent_path + string(filesep);
            end
            testparent_path = testparent_path + cdirspt(i);
        end
        error_rpath     = relativepath(char(error_path), char(testparent_path));
        error_rpath(end)= [];
       
        error_link      = sprintf('Error in <a href="matlab:opentoline(''%s'',%d)">%s at line %d</a>', error_rpath, error_line, error_file, error_line);

        
        msg             = full_error_msg;
		if contains(full_error_msg,"href")
			%                        error("contains a href")
            full_error_msgsplt = split(full_error_msg, '</a>');
			msg             = full_error_msgsplt(2);%regexprep(full_error_msg,["Error:(.+)File:",".</a>"],["Error in file","\r\n"]);
			
            
        end
        
        outString = outString + error_link + " " +  string(msg) + "\n";
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

