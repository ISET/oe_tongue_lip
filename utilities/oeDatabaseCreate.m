function [oeDatabase,dataDir] = oeDatabaseCreate
% How to create the table database for OE
%
% Each data set will need a custom version of this to define
%
%  varNames
%  varTypes
%  data dir and files
%
% Afterwards, we should be able to use ieTableGet() to return the relevant
% (selected) data files.
%
% See also
%   ieTableGet
%

% Example:
%{
T = oeDatabaseCreate;
uniqueValues = unique(T.subject); disp(uniqueValues);
uniqueValues = unique(T.ewave); disp(uniqueValues);
% arrayfun(@(i) fprintf('Row %d: %s\n', i, string(T.subject(i))), 1:height(T));
%}

dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');
dataFiles = dir([dataDir,'/*.mat']);

varNames =     {'date',  'file',  'subject', 'substrate','ewave', 'elevel','roi'};
varTypes = {'string','string','string',  'string',   'double','double','double'};

oeDatabase = table('Size', [numel(dataFiles), length(varNames)], ...
    'VariableNames', varNames, ...
    'VariableTypes',varTypes);

for ff = 1:numel(dataFiles)
    name = dataFiles(ff).name;

    % Date
    oeDatabase.date{ff}  = name(5:14);

    % File
    oeDatabase.file{ff}  = name;

    % Subject
    if contains(name,'Jafter'),       oeDatabase.subject{ff} = 'Jafter'; 
    elseif contains(name,'-B_'),      oeDatabase.subject{ff} = 'B';
    elseif contains(name,'-B-'),      oeDatabase.subject{ff} = 'B';
    elseif contains(name,'-Z-'),      oeDatabase.subject{ff} = 'Z';
    elseif contains(name,'-J-'),      oeDatabase.subject{ff} = 'J';
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

    % Excitation level  - Notice that 80 is part of 980.  So we check 980
    % first.  Others like that.  Decreasing level should take care of this
    % problem.
    if contains(name,'1000mA'),    oeDatabase.elevel(ff) = 1000;
    elseif contains(name,'910mA'), oeDatabase.elevel(ff) = 910;
    elseif contains(name,'980mA'), oeDatabase.elevel(ff) = 980;        
    elseif contains(name,'870mA'), oeDatabase.elevel(ff) = 870;
    elseif contains(name,'560mA'), oeDatabase.elevel(ff) = 560;
    elseif contains(name,'460mA'), oeDatabase.elevel(ff) = 460;
    elseif contains(name,'170mA'), oeDatabase.elevel(ff) = 170; 
    elseif contains(name,'90mA'),  oeDatabase.elevel(ff) = 90;  
    elseif contains(name,'80mA'),  oeDatabase.elevel(ff) = 80;
    else,                          oeDatabase.elevel(ff) = 0;
    end

    % ROI - Sometimes there are 2 ROIs
    if contains(name,'R01'),     oeDatabase.roi(ff) = 1;
    elseif contains(name,'R02'), oeDatabase.roi(ff) = 2;
    else,                        oeDatabase.roi(ff) = 1;
    end

end

end

