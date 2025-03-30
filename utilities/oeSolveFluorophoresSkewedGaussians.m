function [global_params, weights, Gaussians] = oeSolveFluorophoresSkewedGaussians(wave, data, oxyTransmittance)
% oeSolveFluorophoresSkewedGaussians - Fits a weighted sum of three skewed
% Gaussians to multiple spectra. 
% 
% Brief Description
%  Uses the same mu, sigma, and a across all spectra but allows weights to
%  vary per spectrum. The weights are constrained to be non-negative.
%
% Inputs:
%   wave - vector of x-values
%   data - matrix of spectral emissions (each column is a spectrum)
%   oxyTransmittance - must be the same length as wave
%
% Outputs:
%   global_params - Fitted parameters [means, sds, skews]
%   weights   - Matrix of non-negative weights (3 x num_spectra) for each spectrum
%   Gaussians - Matrix of skewed Gaussians with blood applied the first
%               column
% See also
%
%
% TODO
%  Enable setting how many skewed Gaussians to create.  From 2 to maybe 4
%  would be a good range.
%

% Example:
%{

wave = linspace(400, 700, 100); % Example x-values (e.g., wavelengths)
data = rand(100, 10); % Replace with actual spectral data (100 points, 5 spectra)

oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);
oxyblood.opticalDensity = 2;
oxyTransmittance = oxyblood.transmittance;
% plot(wave,oxyTransmittance);

[global_params, weights, Gaussians] = oeSolveFluorophoresSkewedGaussians(wave, data, oxyTransmittance);

disp('Optimized Gaussian Parameters:');
disp(global_params);

disp('Non-Negative Weights for each spectrum:');
disp(weights);

% This is the error. 
fitError = data - Gaussians*weights;
rmserror = norm(fitError(:),2);
disp('RMSE');
disp(rmserror);

ieFigure; plot(wave,Gaussians);

%}

assert(numel(oxyTransmittance) - size(data,1) == 0);

num_spectra = size(data, 2);  % Number of spectra

% Initial guesses for shared parameters
mu0    = linspace(min(wave), max(wave), 3);  % Evenly spaced initial guesses for mu
sigma0 = std(wave) * [0.5, 1, 1.5];  % Different scales for sigma
a0     = [0, 0, 0];  % Initial skewness

% List of 9 parameters
p0 = [mu0, sigma0, a0];

% Lower and upper bounds for shared parameters
lb = [350, 350, 350, 10, 10, 10, -15, -15, -15];
ub = [650 650 650, 200, 200, 200, 15, 15, 15];

% We will change this to incorporate blood.
    function Gaussians = skewed_gaussians(p, x)
        skewed_gaussian = @(mu, sigma, a, x) ...
            (normpdf((x - mu) / sigma) .* (1 + normcdf(a * x)))'; % Transpose to ensure column output

        % Ensure Gaussians is a matrix with columns as separate functions
        Gaussians = [skewed_gaussian(p(1), p(4), p(7), x), ...
            skewed_gaussian(p(2), p(5), p(8), x), ...
            skewed_gaussian(p(3), p(6), p(9), x)];
    end

% Objective function for optimizing the shared parameters
    function err = fit_global_params(p)
        Gaussians = skewed_gaussians(p, wave);

        % Always apply blood transmittance to the first column
        Gaussians(:,1) = Gaussians(:,1).*oxyTransmittance;

        % Now solve for the weights
        weights = zeros(3, num_spectra);

        % Solve for non-negative weights using lsqnonneg for each spectrum
        for j = 1:num_spectra
            weights(:, j) = lsqnonneg(Gaussians, data(:, j));
        end

        % This is the error accumulated across all the data
        approx_S = Gaussians * weights;  % Reconstruct spectra
        err = data(:) - approx_S(:);     % Flatten error for optimization
    end

% Optimize shared parameters
options = optimset('Display', 'off');
global_params = lsqnonlin(@fit_global_params, p0, lb, ub, options);

% Compute final non-negative weights using lsqnonneg
Gaussians = skewed_gaussians(global_params, wave);
Gaussians(:,1) = Gaussians(:,1).*oxyTransmittance;

weights = zeros(3, num_spectra);

for j = 1:num_spectra
    weights(:, j) = lsqnonneg(Gaussians, data(:, j));
end

end
