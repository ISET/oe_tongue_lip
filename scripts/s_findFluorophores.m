%% Read in some tongue data
ieInit;
wave = 500:600;
normWave = 520;
yscale = 'linear';
odLevels = 1:1:40;
[T,dataDir] = oeDatabaseCreate;
subjects = {'Z','B','D','J'};

oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);
oxyblood.opticalDensity = 15;
oxyTransmittance = oxyblood.transmittance;

ii = 3;  % Which subject
files405 = ieTableGet(T,'subject',subjects{ii},'substrate','tongue','e wave',405,'e level',980);
files415 = ieTableGet(T,'subject',subjects{ii},'substrate','tongue','e wave',415,'e level',910);
tongueFiles = cat(1,files405,files415);
tongueData = oeReadFiles(tongueFiles,'normalized wave',normWave,'wave',wave);

% plot(wave,oxyTransmittance);

[global_params, wgtsNN, Gaussians] = oeSolveFluorophoresSkewedGaussians(wave, tongueData, oxyTransmittance);
ieFigure; 
for ii=1:3
    estimate = ieSkewedGaussian(global_params(ii:3:end),350:700);
    plot(350:700,estimate/max(estimate)); hold on;
end

disp('Optimized Gaussian Parameters:');
disp(global_params);

disp('Non-Negative Weights for each spectrum:');
disp(wgtsNN);

% This is the error. 
% fitError = tongueData - Gaussians*weights;
% rmserror = norm(fitError(:),2);
% disp('RMSE');
% disp(rmserror);

ieFigure; plot(wave,Gaussians);

ieFigure;
plot(wave,tongueData,'k-',wave,Gaussians*wgtsNN,'k:');
grid on; title(sprintf('NN, Blood, %s',subjects{ii}));
fprintf('Subject %s\n',subjects{ii}); disp(wgtsNN);
