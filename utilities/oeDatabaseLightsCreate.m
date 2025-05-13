function [oeDatabase,dataDir] = oeDatabaseLightsCreate
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
T = oeDatabaseLightsCreate;
[files,tRows] = ieTableGet(T,'condition','calibrate','ewave',405);
%}

dataDir = fullfile(oeTongueLipRootPath,'data','ExcitationLights');
dataFiles = dir([dataDir,'/*.mat']);

varNames = {'date',  'file',  'condition','spf',   'lpf',   'ewave', 'elevel','rep'};
varTypes = {'string','string','string',   'double','double','double','double','double'};

oeDatabase = table('Size', [numel(dataFiles), length(varNames)], ...
    'VariableNames', varNames, ...
    'VariableTypes',varTypes);

for ff = 1:numel(dataFiles)
    name = dataFiles(ff).name;

    % Date
    oeDatabase.date{ff}  = name(5:14);

    % Files
    oeDatabase.file{ff}  = name;

    name = lower(name);

    % Condition
    if contains(name,'calib'),          oeDatabase.condition{ff} = 'calibrate'; 
    elseif contains(name,'verif'),      oeDatabase.condition{ff} = 'experiment';
    elseif contains(name,'noisecheck')
        oeDatabase.condition{ff} = 'unwantedreflected';
        oeDatabase.lpf(ff) = 475;
    else,                               oeDatabase.condition{ff} = 'Unknown';
    end

    % spf - Short pass filter
    if contains(lower(name),'450spf'),  oeDatabase.spf(ff) = 450;    
    else, oeDatabase.spf(ff) = 0;
    end

    % LED wavelength - Notice the use of () instead of {} for
    % numeric table entries
    if contains(name,'-405nm'),     oeDatabase.ewave(ff) = 405;
    elseif contains(name,'-415nm'), oeDatabase.ewave(ff) = 415;
    elseif contains(name,'-425nm'), oeDatabase.ewave(ff) = 425;
    elseif contains(name,'-450nm'), oeDatabase.ewave(ff) = 450;
    else,                          oeDatabase.ewave(ff) = 0;
    end

    % Excitation level  - Notice that 80 is part of 980.  So we check 980
    % first.  Others like that.  Decreasing level should take care of this
    % problem.
    
    if contains(name,'1500ma'),    oeDatabase.elevel(ff) = 1500;
    elseif contains(name,'1300ma'),oeDatabase.elevel(ff) = 1300;
    elseif contains(name,'1000ma'),oeDatabase.elevel(ff) = 1000;
    elseif contains(name,'980ma'), oeDatabase.elevel(ff) = 980;
    elseif contains(name,'970ma'), oeDatabase.elevel(ff) = 970;
    elseif contains(name,'920ma'), oeDatabase.elevel(ff) = 920;
    elseif contains(name,'910ma'), oeDatabase.elevel(ff) = 910;
    elseif contains(name,'870ma'), oeDatabase.elevel(ff) = 870;
    elseif contains(name,'880ma'), oeDatabase.elevel(ff) = 880;
    elseif contains(name,'840ma'), oeDatabase.elevel(ff) = 840;
    elseif contains(name,'830ma'), oeDatabase.elevel(ff) = 830;
    elseif contains(name,'570ma'), oeDatabase.elevel(ff) = 570;
    elseif contains(name,'560ma'), oeDatabase.elevel(ff) = 560;
    elseif contains(name,'530ma'), oeDatabase.elevel(ff) = 530;
    elseif contains(name,'500ma'), oeDatabase.elevel(ff) = 500;
    elseif contains(name,'490ma'), oeDatabase.elevel(ff) = 490;
    elseif contains(name,'480ma'), oeDatabase.elevel(ff) = 480;
    elseif contains(name,'460ma'), oeDatabase.elevel(ff) = 460;
    elseif contains(name,'450ma'), oeDatabase.elevel(ff) = 450;
    elseif contains(name,'320ma'), oeDatabase.elevel(ff) = 320;
    elseif contains(name,'170ma'), oeDatabase.elevel(ff) = 170; 
    elseif contains(name,'120ma'), oeDatabase.elevel(ff) = 120;
    elseif contains(name,'100ma'), oeDatabase.elevel(ff) = 100;
    elseif contains(name,'90ma'),  oeDatabase.elevel(ff) = 90;  
    elseif contains(name,'80ma'),  oeDatabase.elevel(ff) = 80;
    elseif contains(name,'50ma'),  oeDatabase.elevel(ff) = 50;
    else,                          oeDatabase.elevel(ff) = 0;
    end

    % Rep - Sometimes there are multiple replications
    if contains(name,'(1)'),     oeDatabase.rep(ff) = 2;
    else,                        oeDatabase.rep(ff) = 1;
    end

end

end

