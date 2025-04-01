function [global_params, weights, Gaussians] = oeSolveFluorophoresSkewedGaussiansLip(wave, data, oxyTransmittance)
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
% This code is designed to find 2 fluorophores for the lip.  The code is
% not general.  If we want to find 3 fluorophores for the tongue, we need
% use the other version.
%
% See also
%


% Example:
%{
%}

assert(numel(oxyTransmittance) - size(data,1) == 0);

num_spectra = size(data, 2);  % Number of spectra

% This is designed to find 3 fluorophores for the tongue.  The code is not
% general.  If we want to just find 2 fluorophores for the lip, we need a
% separate version.

% Initial guesses for shared parameters.
mu0 = [400 530];      % Collagen and FAD
sigma0 = [100, 100];  % Spread
a0     = [0, 0];      % Initial skewness

% List of 6 parameters
p0 = [mu0, sigma0, a0];

% Lower and upper bounds for shared parameters
lb = [390, 460, 10, 10,  -25, -25];
ub = [420  560, 300, 300, 25, 25];

% We will change this to incorporate blood.
    function Gaussians = skewed_gaussians(p, x)
        skewed_gaussian = @(mu, sigma, a, x) ...
            (normpdf((x - mu) / sigma) .* (1 + normcdf(a * x)))'; % Transpose to ensure column output

        % Ensure Gaussians is a matrix with columns as separate functions
        Gaussians = [skewed_gaussian(p(1), p(3), p(5), x), ...
            skewed_gaussian(p(2), p(4), p(6), x)];
    end

% Objective function for optimizing the shared parameters
    function err = fit_global_params(p)
        Gaussians = skewed_gaussians(p, wave);

        % Always apply blood transmittance to the first column
        Gaussians(:,1) = Gaussians(:,1).*oxyTransmittance;

        % Now solve for the weights
        weights = zeros(2, num_spectra);

        % Solve for non-negative weights using lsqnonneg for each spectrum
        for j = 1:num_spectra
            weights(:, j) = lsqnonneg(Gaussians, data(:, j));
        end

        % This is the error accumulated across all the data
        approx_S = Gaussians * weights;  % Reconstruct spectra
        err = data(:) - approx_S(:);     % Flatten error for optimization
    end

% Optimize shared parameters
% options = optimset('Display', 'off');
% {
options = optimset('Display', 'off', ...  % Show progress at each iteration
                   'MaxIter', 5000, ...  % Increase the number of iterations
                   'MaxFunEvals', 25000, ...  % Increase function evaluations
                   'TolFun', 1e-4, ...  % Tighter function tolerance (encourages finer tuning)
                   'TolX', 1e-4);       % Tighter parameter tolerance (better precision)

%}
global_params = lsqnonlin(@fit_global_params, p0, lb, ub, options);

% Compute final non-negative weights using lsqnonneg
Gaussians = skewed_gaussians(global_params, wave);
Gaussians(:,1) = Gaussians(:,1).*oxyTransmittance;

weights = zeros(2, num_spectra);

for j = 1:num_spectra
    weights(:, j) = lsqnonneg(Gaussians, data(:, j));
end

end
