function [global_params, weights, finalFluorophores] = oeSolveJoint(wave, data, fixedFluorophores, varargin)
% oeSolveJoint - Fits a fixed matrix to joint lip and tongue data.
%
% Synopsis
%   [global_params, weights, finalFluorophores] = oeSolveJoint(wave, data, fixedFluorophores, varargin)
%
% Brief Description
%  We take a fixed set of fluorophores in.  We modify the first
%  column, which is typically collagen1-smooth, to account for blood
%  optical density.  We then add an extra column that is a
%  skewedGaussian.  We search for the skewed Gaussian parameters.
%
% Inputs:
%   wave - vector of x-values
%   data - matrix of spectral emissions (each column is a spectrum)
%   fixedFluorophores - must be the same length as wave
%
% Optional key/val
%   initialparameters -  vector of od0, mu0, sigma0, a0
%
% Outputs:
%   global_params - Fitted parameters [oxy, mean, sd, skew]
%   weights   - Matrix of non-negative weights (3 x num_spectra) for each
%   spectrum based on the finalFluorophores
%   finalFluorophores - Matrix of modified fixedFluorophores with blood
%           applied the first column and additional fluorophore to the last
%           column
%
% See also
%   oeSolveBlood (does not add another fluorophore)

% Example:
%{

%}

%%

varargin = ieParamFormat(varargin);
p = inputParser;
p.addRequired('wave',@isvector);
p.addRequired('data',@ismatrix);
p.addRequired('fixedFluorophores',@ismatrix);
p.addParameter('initialparameters',[],@isvector);

p.parse(wave,data,fixedFluorophores,varargin{:});

%% Initial guesses for parameters.
if isempty(p.Results.initialparameters)
    od0    = 10;   % Initial guess at blood oxygen
    mu0    = 475;  % Center wavelength in nm
    sigma0 = 50;   % Standard deviation
    a0     = 5;    % Initial skewness
else
    initial = p.Results.initialparameters;
    od0 = initial(1);
    mu0 = initial(2);
    sigma0 = initial(3);
    a0 = initial(4);
end

%% Merge the parameters
p0 = [od0, mu0, sigma0, a0];

% Lower and upper bounds for parameters
lb = [0  mu0 - 50,  10, -15];
ub = [50 mu0 + 50, 500,  15];

% Inline function to calculate skewed Gaussian
skewed_gaussian = @(mu, sigma, a, x) ...
    (normpdf((x - mu) / sigma) .* (1 + normcdf(a * x)))';

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

        
        skewedG = skewed_gaussian(p(2),p(3),p(4),wave);
        finalFluorophores = cat(2,finalFluorophores,skewedG);

        % Solve for non-negative weights using lsqnonneg for each spectrum
        weights = zeros(5, num_spectra);
        for kk = 1:num_spectra
            weights(:, kk) = lsqnonneg(finalFluorophores, data(:, kk));
        end

        % This is the error accumulated across all the data
        approx_S = finalFluorophores * weights;  % Reconstruct spectra
        err = data(:) - approx_S(:);             % Flatten error for optimization
    end

% Optimize shared parameters
% options = optimset('Display', 'off');
options = optimset('Display', 'off', ...  % Show progress at each iteration
    'MaxIter', 5000, ...  % Increase the number of iterations
    'MaxFunEvals', 25000, ...  % Increase function evaluations
    'TolFun', 1e-4, ...  % Tighter function tolerance (encourages finer tuning)
    'TolX', 1e-4);       % Tighter parameter tolerance (better precision)

oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);
global_params = lsqnonlin(@fit_global_params, p0, lb, ub, options);

% We have the global parameter fit.
%

% % Modified the first column with blood oxygenation
% oxyblood.opticalDensity = global_params(1);
% oxyTransmittance = oxyblood.transmittance;
% finalFluorophores(:,1) = fixedFluorophores(:,1).*oxyTransmittance;
% 
% % Add the skewed gaussian column
% finalFluorophores = cat(2,finalFluorophores,skewed_gaussian(global_params(2),global_params(3),global_params(4), wave));

% Compute non-negative weights using lsqnonneg
weights = zeros(5, num_spectra);
for k = 1:num_spectra
    weights(:, k) = lsqnonneg(finalFluorophores, data(:, k));
end

end
