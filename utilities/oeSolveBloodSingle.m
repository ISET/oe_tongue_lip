function [global_params, weights, finalFluorophores, err] = oeSolveBloodSingle(wave, data, fixedFluorophores, varargin)
% oeSolveBlood - Finds the blood optical density
%
% Synopsis
%   [global_params, weights, finalFluorophores, err] = oeSolveBloodSingle(wave, data, fixedFluorophores, varargin)
%
% Brief Description
%  We input a fixed set of fluorophores.  We modify the first column,
%  which is typically collagen1-smooth, to account for blood optical
%  density.
%
% Inputs:
%   wave - vector of x-values
%   data - matrix of spectral emissions (each column is a spectrum)
%   fixedFluorophores - must be the same length as wave
%
% Optional key/val
%   initialparameters -  initial optical density
%
% Outputs:
%   global_params - Fitted parameters [oxy, mean, sd, skew]
%   weights   - Matrix of non-negative weights (3 x num_spectra) for each
%               spectrum based on the finalFluorophores
%   finalFluorophores - Matrix of modified fixedFluorophores with blood
%           applied the first column and additional fluorophore to the last
%           column
%
% See also
%   oeSolveJoint

% Example:
%{

%}

%%

varargin = ieParamFormat(varargin);
p = inputParser;
p.addRequired('wave',@isvector);
p.addRequired('data',@ismatrix);
p.addRequired('fixedFluorophores',@ismatrix);
p.addParameter('initialparameters',[],@isnumeric);

p.parse(wave,data,fixedFluorophores,varargin{:});

%% Initial guesses for parameters.
if isempty(p.Results.initialparameters)
    od0    = 10;   % Initial guess at blood oxygen   
else
    od0 = p.Results.initialparameters;
end

%% Merge the parameters
p0 = od0;

% Lower and upper bounds for parameters
lb = 0;  
ub = 50;

num_spectra = size(data,2);

% Objective function for optimizing the shared parameters
    function err = fit_global_params(p)

        % Determine the transmittance
        oxyblood.opticalDensity = p(1);
        oxyTransmittance = oxyblood.transmittance;

        % Build the full matrix from the search parameters, putting blood
        % into the first column and adding a new column at the end for the
        % skewed Gaussian.
        finalFluorophores = fixedFluorophores;
        finalFluorophores(:,1) = fixedFluorophores(:,1).*oxyTransmittance;
        
        % Solve for non-negative weights using lsqnonneg for each spectrum
        weights = zeros(size(finalFluorophores,2), num_spectra);
        for kk = 1:num_spectra
            weights(:, kk) = lsqnonneg(finalFluorophores, data(:, kk));
        end

        % This is the error accumulated across all the data
        approx_S = finalFluorophores * weights;  % Reconstruct spectra
        err = data(:) - approx_S(:);  % Flatten error for optimization        
        % err = rmse(data(:),approx_S(:));          
    end

% Optimize shared parameters
% options = optimset('Display', 'off');
options = optimset('Display', 'off', ...  % Show progress at each iteration
    'MaxIter', 5000, ...  % Increase the number of iterations
    'MaxFunEvals', 25000, ...  % Increase function evaluations
    'TolFun', 1e-10, ...  % Tighter function tolerance (encourages finer tuning)
    'TolX', 1e-10);       % Tighter parameter tolerance (better precision)

oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);
global_params = lsqnonlin(@fit_global_params, p0, lb, ub, options);

% We have the global parameter fit.

% Compute non-negative weights using lsqnonneg.  The finalFluorophores
% have the blood factored into the collagen.
weights = zeros(size(finalFluorophores,2), num_spectra);
err = zeros(1,num_spectra);
for k = 1:num_spectra
    weights(:, k) = lsqnonneg(finalFluorophores, data(:, k));
    % This is the error accumulated across all the data
    est = finalFluorophores * weights;  % Reconstruct spectra
    err(k) = rmse(data(:),est(:));  
end

end
