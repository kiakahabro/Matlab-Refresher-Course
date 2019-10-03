function runAllTests(paths)

	FileList    = dir(fullfile('tests',['*','.m']));
	
	nfiles      = length(FileList);

	for i = 1:nfiles
		filedir		= string(FileList(i).folder);
		filename 	= string(FileList(i).name);
		fullname	= filedir + filesep + filename;
		
		if(i == 1)
			cprintf('*black',' Running %s\n ', filename);
		else
			cprintf('*black','\n\n Running %s\n ', filename);
		end
		
		testResults = runtests(fullname, 'OutputDetail', 0);
		testPrint(testResults);
	end


end

