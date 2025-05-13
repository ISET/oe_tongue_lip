function [odBest,odError] = oeBloodEstimateOD(F,Fnames,data,wave,odLevels)
% From base fluorophores, and data, estimate blood optical density
%
% Synopsis
%   [odBest,odError] = oeBloodEstimateOD(fluorophoresB,lipData,odLevels)
%
% Inputs
%   F        - Base set of fluorophores, with no blood
%   data     - Fluorescent data
%   odLevels - a vector of optical densities to try.  If empty, we try 1:20
%
% Outputs
%   odBest - Optical density
%   odError - Vector of the RMSE errors
%
% Description
%   For a fluorophore basis, F, and a fluorescent data set, data, we sweep
%   through a number of blood optical density levels, fitting the data.  We
%   find the OD level that provides the best fit to the data.
%
%   We return that level and the vector of RMSE values.
%
% See also
%

%%
if notDefined('F'), error('Fluorophore matrix required.'); end
if notDefined('Fnames'), error('Fluorophore names required.'); end
if notDefined('data'), error('Fluorescent data matrix required.'); end
if notDefined('odLevels'), odLevels = 1:20; end

%%
wgtsNN = zeros(size(F,2),size(data,2));
odError = zeros(numel(odLevels),1);
oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);

for oo = 1:numel(odLevels)
    % Set the OD level
    oxyblood.opticalDensity = odLevels(oo);

    % Apply the blood to F
    fluorophores = oeApplyBlood(F,Fnames,oxyblood);

    % See how well it fits all of the columns in data
    for dd = 1:size(data,2)
        wgtsNN(:,dd) = lsqnonneg(fluorophores,data(:,dd));
    end
    tmp = data - fluorophores*wgtsNN;

    % Story the RMSE for this level, for all of the data
    odError(oo) = norm(tmp(:));
end

% Store the best od (minimum error) in odBest
[~,idx] = min(odError);
odBest = odLevels(idx);

end