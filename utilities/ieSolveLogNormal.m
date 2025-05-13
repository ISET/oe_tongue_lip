function [mu, sigma] = ieSolveLogNormal(wavelengths, S)
    % ieSolveLogNormal Fits a log-normal distribution to a given function S(wavelength).
    %
    % Inputs:
    %   wavelengths - A vector of wavelength values.
    %   S - A vector of function values corresponding to the wavelengths.
    %
    % Outputs:
    %   mu - Mean of the fitted normal distribution in log-space.
    %   sigma - Standard deviation of the fitted normal distribution in log-space.
    %
    % Ensure inputs are column vectors

    %{
      wave = 350:5:700;
      collagen = fiReadFluorophore('collagen1','wave',wave);
      emission = fluorophoreGet(collagen,'emission');
      ieFigure; plot(wave,emission);
      [mu,sigma] = ieSolveLogNormal(wave,emission);

      fitted_S = lognpdf(wave, mu, sigma);
    
      % Normalize the fitted curve to match the scale of S
      fitted_S = fitted_S * max(emission) / max(fitted_S);

    % Plot original data and log-normal fit
      ieFigure;
      plot(wave, emission, 'bo-', 'LineWidth', 1.5, 'DisplayName', 'Original Data');
      hold on;
      plot(wave, fitted_S, 'r-', 'LineWidth', 2, 'DisplayName', 'Log-Normal Fit');
      hold off;

    % Labels and legend
      xlabel('Wavelength');
      ylabel('E(\lambda)');
      title('Log-Normal Fit to S(\lambda)');
      legend;
      grid on;
    %}
    wavelengths = wavelengths(:);
    S = S(:);
    
    % Normalize S to form a probability density function (PDF)
    S = S / trapz(wavelengths, S);  % Normalize so that it integrates to 1
    
    % Convert wavelengths to log-space
    log_wavelengths = log(wavelengths);
    
    % Compute mean and standard deviation in log-space
    mu = trapz(wavelengths, log_wavelengths .* S);
    sigma = sqrt(trapz(wavelengths, ((log_wavelengths - mu).^2) .* S));
end

%{
function plotLogNormalFit(wavelengths, S)
    % PLOTLOGNORMALFIT Fits a log-normal distribution to S(wavelength)
    % and plots the fitted curve along with the original data.
    %
    % Inputs:
    %   wavelengths - A vector of wavelength values.
    %   S - A vector of function values corresponding to the wavelengths.

    % Fit log-normal distribution
    [mu, sigma] = fitLogNormal(wavelengths, S);

    % Generate log-normal fit
    fitted_S = lognpdf(wavelengths, mu, sigma);
    
    % Normalize the fitted curve to match the scale of S
    fitted_S = fitted_S * max(S) / max(fitted_S);

    % Plot original data and log-normal fit
    figure;
    plot(wavelengths, S, 'bo-', 'LineWidth', 1.5, 'DisplayName', 'Original Data');
    hold on;
    plot(wavelengths, fitted_S, 'r-', 'LineWidth', 2, 'DisplayName', 'Log-Normal Fit');
    hold off;

    % Labels and legend
    xlabel('Wavelength');
    ylabel('S(\lambda)');
    title('Log-Normal Fit to S(\lambda)');
    legend;
    grid on;
end
%}