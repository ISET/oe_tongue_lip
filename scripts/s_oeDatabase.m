%
% 

% 
% ieDatabase(fields)


dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');
dataFiles = dir([dataDir,'/*.mat']);

fields =     {'date',  'file',  'subject', 'substrate','ewave', 'elevel','roi'};
fieldtypes = {'string','string','string',  'string',   'double','double','double'};

oeDatabase = table('Size', [numel(dataFiles), length(fields)], ...
    'VariableNames', fields, ...
    'VariableTypes',fieldtypes);
oeDatabase.Properties.VariableTypes


for ff = 1:numel(dataFiles)
    name = dataFiles(ff).name;

    % Date
    oeDatabase.date{ff}  = name(5:14);

    % File
    oeDatabase.file{ff}  = name;

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

    % Substrate
    if contains(name,'lip'),        oeDatabase.substrate(ff) = 'lip';
    elseif contains(name,'Lip'),    oeDatabase.substrate(ff) = 'lip';
    elseif contains(name,'tongue'), oeDatabase.substrate(ff) = 'tongue';
    elseif contains(name,'Tongue'), oeDatabase.substrate(ff) = 'tongue';
    elseif contains(name,'lettuce'), oeDatabase.substrate(ff) = 'lettuce';
    else, oeDatabase.substrate{ff} = 'unknown';
    end

    % Excitation wavelength - Notice the use of () instead of {} for
    % numeric table entries
    if contains(name,'405nm'),     oeDatabase.ewave(ff) = 405;
    elseif contains(name,'415nm'), oeDatabase.ewave(ff) = 415;
    elseif contains(name,'450nm'), oeDatabase.ewave(ff) = 450;
    else,                          oeDatabase.ewave(ff) = 0;
    end

    % Excitation level 
    if contains(name,'80mA'),      oeDatabase.elevel(ff) = 80;
    elseif contains(name,'90mA'),  oeDatabase.elevel(ff) = 90;  
    elseif contains(name,'170mA'), oeDatabase.elevel(ff) = 170;
    elseif contains(name,'460mA'), oeDatabase.elevel(ff) = 460;
    elseif contains(name,'560mA'), oeDatabase.elevel(ff) = 560;
    elseif contains(name,'870mA'), oeDatabase.elevel(ff) = 870;
    elseif contains(name,'910mA'), oeDatabase.elevel(ff) = 910;
    elseif contains(name,'980mA'), oeDatabase.elevel(ff) = 980;        
    elseif contains(name,'1000mA'),oeDatabase.elevel(ff) = 1000;
    else, oeDatabase.elevel(ff) = 0;
    end

    % ROI - Sometimes there are 2 ROIs
    if contains(name,'R01'),     oeDatabase.roi(ff) = 1;
    elseif contains(name,'R02'), oeDatabase.roi(ff) = 2;
    else,                        oeDatabase.roi(ff) = 1;
    end

end

size(oeDatabase)
oeDatabase

files = ieTableGet(oeDatabase,'operator','and','subject','J');

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