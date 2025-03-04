%
% 

% 
oeDatabase = table();

dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');
dataFiles = dir([dataDir,'/*.mat']);

for ff = 1:numel(dataFiles)
    name = dataFiles(ff).name;

    % Date
    oeDatabase.date{ff}  = name(5:14);
    oeDatabase.file{ff}  = dataFiles(ff).name;

    % Subject
    if contains(name,'-J-'),          oeDatabase.subject{ff} = 'J';
    elseif contains(name,'-B-'),      oeDatabase.subject{ff} = 'B';
    elseif contains(name,'-B_'),      oeDatabase.subject{ff} = 'B';
    elseif contains(name,'-Z-'),      oeDatabase.subject{ff} = 'Z';
    elseif contains(name,'-Jafter-'), oeDatabase.subject{ff} = 'Jafter';
    elseif contains(name,'-D-'),      oeDatabase.subject{ff} = 'D';
    elseif contains(name,'-D_'),      oeDatabase.subject{ff} = 'D';
    else,                             oeDatabase.subject{ff} = 'Unknown';
    end

    % Excitation wavelength
    if contains(name,'405nm'),     oeDatabase.eWave{ff} = 405;
    elseif contains(name,'415nm'), oeDatabase.eWave{ff} = 415;
    elseif contains(name,'450nm'), oeDatabase.eWave{ff} = 450;
    else,                          oeDatabase.eWave{ff} = [];
    end

    % Substrate
    if contains(name,'lip'),        oeDatabase.substrate{ff} = 'lip';
    elseif contains(name,'Lip'),    oeDatabase.substrate{ff} = 'lip';
    elseif contains(name,'tongue'), oeDatabase.substrate{ff} = 'tongue';
    elseif contains(name,'Tongue'), oeDatabase.substrate{ff} = 'tongue';
    elseif contains(name,'lettuce'), oeDatabase.substrate{ff} = 'lettuce';
    else, oeDatabase.substrate{ff} = 'unknown';
    end

    % ROI - Sometimes there are 2 ROIs
    if contains(name,'R01'),     oeDatabase.roi{ff} = 1;
    elseif contains(name,'R02'), oeDatabase.roi{ff} = 2;
    else,                        oeDatabase.roi{ff} = 1;
    end
    
    % eLevel 
    if contains(name,'80mA'),      oeDatabase.eLevel{ff} = 80;
    elseif contains(name,'90mA'),  oeDatabase.eLevel{ff} = 90;  
    elseif contains(name,'170mA'), oeDatabase.eLevel{ff} = 170;
    elseif contains(name,'460mA'), oeDatabase.eLevel{ff} = 460;
    elseif contains(name,'560mA'), oeDatabase.eLevel{ff} = 560;
    elseif contains(name,'870mA'), oeDatabase.eLevel{ff} = 870;
    elseif contains(name,'910mA'), oeDatabase.eLevel{ff} = 910;
    elseif contains(name,'980mA'), oeDatabase.eLevel{ff} = 980;        
    elseif contains(name,'1000mA'),oeDatabase.eLevel{ff} = 1000;
    else, oeDatabase.eLevel{ff} =[];
    end

end

% For string fields
matchingFiles = oeDatabase(strcmp(oeDatabase.substrate, 'lettuce'), :);

% For numeric fields.
matchingFiles = oeDatabase( cellfun(@(x) isequal(x, 450), oeDatabase.eWave), :);

matchingFiles = oeDatabase( cellfun(@(x) isequal(x, 1000), oeDatabase.eLevel), :);

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