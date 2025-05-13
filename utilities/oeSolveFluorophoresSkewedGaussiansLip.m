function [global_params, weights, Gaussians] = oeSolveFluorophoresSkewedGaussiansLip(wave, data, oxyTransmittance, nFluorophores)
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
%   nFluorophores    - Use two or three fluorophores
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

if notDefined('nFluorophores'), nFluorophores = 2; end

assert(numel(oxyTransmittance) - size(data,1) == 0);
assert(nFluorophores == 2 || nFluorophores == 3 || nFluorophores == 3.1);

num_spectra = size(data, 2);  % Number of spectra

% This is designed to find 3 fluorophores for the tongue.  The code is not
% general.  If we want to just find 2 fluorophores for the lip, we need a
% separate version.

% Initial guesses for shared parameters.
if nFluorophores == 3
    mu0 = [400 475 530];      % Collagen and FAD
    sigma0 = [100, 100, 100];  % Spread
    a0     = [0, 0, 0];      % Initial skewness

    % Lower and upper bounds for three fluorophores
    lb = [390, 430, 460, 10,  10,  10, -25, -25, -25];
    ub = [420, 500, 560, 300, 300, 300, 25, 25, 25];

elseif nFluorophores == 3.1
    mu0 = [400 450 550];      % Collagen and FAD
    sigma0 = [200, 200, 100];  % Spread
    a0     = [0, 0, 0];      % Initial skewness

    % Lower and upper bounds for three fluorophores
    lb = [390, 400, 460, 10,  10,  10, -25, -25, -25];
    ub = [420, 600, 560, 300, 300, 300, 25, 25, 25];
    
elseif nFluorophores == 2
    % Lower and upper bounds for shared parameters
    lb = [390, 460, 10, 10,  -25, -25];
    ub = [420  560, 300, 300, 25, 25];

    mu0 = [400 530];      % Collagen and FAD
    sigma0 = [100, 100];  % Spread
    a0     = [0, 0];      % Initial skewness
end

% List of 6 or 9 parameters
p0 = [mu0, sigma0, a0];

% We will change this to incorporate blood.
    function Gaussians = skewed_gaussians(p, x)
        skewed_gaussian = @(mu, sigma, a, x) ...
            (normpdf((x - mu) / sigma) .* (1 + normcdf(a * x)))'; % Transpose to ensure column output

        % Ensure Gaussians is a matrix with columns as separate functions
        if nFluorophores == 2
            Gaussians = [skewed_gaussian(p(1), p(3), p(5), x), ...
                skewed_gaussian(p(2), p(4), p(6), x)];
        elseif nFluorophores == 3 || nFluorophores == 3.1
            % Case of three, with collagen and elastin
            Gaussians = [skewed_gaussian(p(1), p(4), p(7), x), ...
                skewed_gaussian(p(2), p(5), p(8), x), ...
                skewed_gaussian(p(3), p(6), p(9), x)
                ];
        end

    end

% Objective function for optimizing the shared parameters
    function err = fit_global_params(p, nFluorophores)
        Gaussians = skewed_gaussians(p, wave);

        % Always apply blood transmittance to the first column
        if nFluorophores == 3
            Gaussians(:,1) = Gaussians(:,1).*oxyTransmittance;
            Gaussians(:,2) = Gaussians(:,2).*oxyTransmittance;
        elseif nFluorophores == 3.1 || nFluorophores == 2
            Gaussians(:,1) = Gaussians(:,1).*oxyTransmittance;
        end

        % Now solve for the weights
        if nFluorophores == 3 || nFluorophores == 3.1
            weights = zeros(3, num_spectra);
        else
            weights = zeros(2, num_spectra);
        end


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
global_params = lsqnonlin(@fit_global_params, p0, lb, ub, options, nFluorophores);

% Compute final non-negative weights using lsqnonneg
Gaussians = skewed_gaussians(global_params, wave);
if nFluorophores == 3
    Gaussians(:,1) = Gaussians(:,1).*oxyTransmittance;
    Gaussians(:,2) = Gaussians(:,2).*oxyTransmittance;
elseif nFluorophores == 3.1 || nFluorophores == 2
    Gaussians(:,1) = Gaussians(:,1).*oxyTransmittance;
end

if nFluorophores == 3 || nFluorophores == 3.1
    weights = zeros(3, num_spectra);
else
    weights = zeros(2, num_spectra);
end
for j = 1:num_spectra
    weights(:, j) = lsqnonneg(Gaussians, data(:, j));
end

end
