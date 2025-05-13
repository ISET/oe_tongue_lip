function y = ieSkewedGaussian(p, x)
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