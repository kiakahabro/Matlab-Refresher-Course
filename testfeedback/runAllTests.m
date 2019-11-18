function runAllTests()

    if(exist('tests','dir')==7)
        [~, testResults] = evalc('runtests(''tests'')');
%         testResults     = runtests('tests');
        testPrint(testResults);
    else
        cprintf('*orange','No directory called \"tests\"\n');
    end


end

