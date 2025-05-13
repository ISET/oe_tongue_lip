% DEPRECATED
% See utilities and ieTableGet

size(oeDatabase)
oeDatabase

files = ieTableGet(oeDatabase,'operator','and','subject','J','e wave',415);
variableTypes = varfun(@class, oeDatabase, 'OutputFormat', 'cell')

% For string fields
matchingFiles = oeDatabase(strcmp(oeDatabase.substrate, 'lettuce'), :);

% For numeric fields.
matchingFiles = oeDatabase(oeDatabase.ewave == 450, :);

matchingFiles = oeDatabase( oeDatabase.elevel == 1000, :);

%{
 Add data for each file
fileDatabase.SubjectID{1} = 'Subject1';
fileDatabase.Condition{1} = 'ConditionA';
fileDatabase.FilePath{1} = '/path/to/file1.mat';
fileDatabase.SubjectID{2} = 'Subject2';
fileDatabase.Condition{2} = 'ConditionB';
fileDatabase.FilePath{2} = '/path/to/file2.mat';
fileDatabase.SubjectID{3} = 'Subject1';
fileDatabase.Condition{3} = 'ConditionB';
fileDatabase.FilePath{3} = '/path/to/file3.mat';

% Find files for Subject1 with ConditionB
subjectID = 'Subject1';
condition = 'ConditionB';
matchingFiles = fileDatabase(strcmp(fileDatabase.SubjectID, subjectID) & strcmp(fileDatabase.Condition, condition), :);

% Get the file paths
filePaths = matchingFiles.FilePath;

disp(filePaths);
%}