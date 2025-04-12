function params = oeSolveSkewedGaussianCGPT(x, E)
% oeSolveSkewedGaussianCGPT fits a skewed Gaussian function to data
%
% Synopsis
%
% Inputs
%  x - independent variable (wavelength or frequency values)
%  E - observed spectral emission data
%
% Outputs
%  params
%
% See also
%  ieSkewedGaussian

%{
wave = 350:5:700;
thisF = fiReadFluorophore('CollagenWuQu','wave',wave);
thisF = fiReadFluorophore('KeratinWuQu','wave',wave);
thisF = fiReadFluorophore('NADHWuQu','wave',wave);
thisF = fiReadFluorophore('FADWuQu','wave',wave);

emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
estimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r-',...
wave,estimate,'bo-', 'LineWidth',2);
legend({'emission','estimate'});
grid on;
%}
%{
wave = 400:10:700;
D = daylight(wave,6000,'energy')';
estimates = oeSolveSkewedGaussianCGPT(wave,D);
DFit = ieSkewedGaussian(estimates,wave);
ieFigure; plot(wave,D,'r-',wave,DFit,'bo-','LineWidth',2);
legend({'daylight','estimate'});
grid on;
%}

x = x(:); E = E(:);

% Initial guess for parameters: [mu, sigma, a]
mu0 = mean(x);
sigma0 = std(x);
a0 = 0;  % Start with no skew
p0 = [mu0, sigma0, a0];

% Set lower and upper bounds for parameters
lb = [min(x), 1e-3, -10];
ub = [max(x), max(x)-min(x), 10];

% Use lsqcurvefit for fitting
options = optimset('Display', 'off');
params = lsqcurvefit(@ieSkewedGaussian, p0, x, E, lb, ub, options);
end

%{
function y = tmpFunc(p, x)
% Computes the skewed Gaussian function
%
% Parameters
%    p(1) = mu, p(2) = sigma, p(3) = a
%

mu = p(1);
sigma = p(2);
a = p(3);

% Compute standard normal PDF
phi = exp(-0.5 * ((x - mu) ./ sigma).^2) / (sigma * sqrt(2*pi));

% Compute CDF for skew term
skew_term = 1 + normcdf(a * x, 0, 1);

% Compute skewed Gaussian
y = phi .* skew_term;

end

%}

