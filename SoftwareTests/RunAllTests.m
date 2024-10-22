function RunAllTests(EnableReport,ReportFolder)
arguments
    EnableReport (1,1) logical = false;
    ReportFolder (1,1) string = "public";
end

import matlab.unittest.plugins.TestReportPlugin;

% Create a runner
Runner = matlab.unittest.TestRunner.withTextOutput;
if EnableReport
    Folder = fullfile(currentProject().RootFolder,ReportFolder);
    if ~isfolder(Folder)
        mkdir(Folder)
    else
        rmdir(Folder,'s')
        mkdir(Folder)
    end
    Plugin = TestReportPlugin.producingHTML(Folder,...
        "IncludingPassingDiagnostics",true,...
        "IncludingCommandWindowText",true,...
        "LoggingLevel",matlab.automation.Verbosity(1));
        Runner.addPlugin(Plugin);
end

% Create the test suite with SmokeTest and Function test if they exist
Suite = testsuite("SmokeTests");
Suite = [Suite testsuite("FunctionTests")];
Suite = [Suite testsuite("SolnSmokeTests")];

% Run the test suite
Results = Runner.run(Suite);

if EnableReport
    web(fullfile(Folder,"index.html"))
end

% Format the results in a table and save them
ResultsTable = table(Results')
writetable(ResultsTable,fullfile(currentProject().RootFolder,...
    "SoftwareTests","TestResults_R"+version("-release")+".txt"));

% Assert success of test
assertSuccess(Results);

end
