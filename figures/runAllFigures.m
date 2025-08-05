%% Run all the oeFigure m-files

ieSessionSet('init clear',false);

mFiles = dir('oeFigure*.m');

% Loop through each file and run it
for k = 1:length(mFiles)
    disp(mFiles(k).name);
    run(mFiles(k).name);
end

%%