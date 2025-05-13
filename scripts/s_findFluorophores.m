%% Read in some tongue data
%
% We ask whether we can find three fluorophores defined as Skewed
% Gaussians, one of which has blood applied to it, that can fit the tongue
% data.  The answer is you betcha.
%
% See also
%

%%
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

%%
for ss = 1:numel(subjects)  % Which subject
    files405 = ieTableGet(T,'subject',subjects{ss},'substrate','tongue','e wave',405,'e level',980);
    files415 = ieTableGet(T,'subject',subjects{ss},'substrate','tongue','e wave',415,'e level',910);
    tongueFiles = cat(1,files405,files415);
    tongueData = oeReadFiles(tongueFiles,'normalized wave',normWave,'wave',wave);

    % plot(wave,oxyTransmittance);

    [global_params, wgtsNN, skewedG] = oeSolveFluorophoresSkewedGaussians(wave, tongueData, oxyTransmittance);
    disp('Optimized Gaussian Parameters:');
    disp(global_params);
    
    ieFigure;
    mx = max(skewedG);
    plot(wave,skewedG*diag(1./mx));
    title('Fluorophores: Blood');

    disp('Non-Negative Weights for each spectrum:');
    disp(wgtsNN);

    ieFigure;
    for ii=1:3
        estimate = ieSkewedGaussian(global_params(ii:3:end),wave);
        plot(wave,estimate/max(estimate)); hold on;
    end
    title('Fluorophores: No blood')

    ieFigure;
    plot(wave,tongueData,'k-',wave,skewedG*wgtsNN,'k:');
    grid on; title(sprintf('NN, Blood, %s',subjects{ss}));
    title(sprintf('Subject %s\n',subjects{ss}));

end

%% Fit all the subjects at once

files405 = ieTableGet(T,'substrate','tongue','e wave',405,'e level',980);
files415 = ieTableGet(T,'substrate','tongue','e wave',415,'e level',910);
tongueFiles = cat(1,files405,files415);
tongueData = oeReadFiles(tongueFiles,'normalized wave',normWave,'wave',wave);

% plot(wave,oxyTransmittance);

[global_params, wgtsNN, skewedG] = oeSolveFluorophoresSkewedGaussians(wave, tongueData, oxyTransmittance);
disp('Optimized Gaussian Parameters:');
disp(global_params);

disp('Non-Negative Weights for each spectrum:');
disp(wgtsNN);

ieFigure;
mx = max(skewedG);
plot(wave,skewedG*diag(1./mx));
title('Fluorophores: Blood');

hdl = ieFigure;
for ii=1:3
    estimate = ieSkewedGaussian(global_params(ii:3:end),wave);
    plot(wave,estimate/max(estimate)); hold on;
end
title('Fluorophores: No blood')

% This is the error.
% fitError = tongueData - Gaussians*weights;
% rmserror = norm(fitError(:),2);
% disp('RMSE');
% disp(rmserror);

ieFigure;
plot(wave,tongueData,'k-',wave,skewedG*wgtsNN,'k:');
grid on; title(sprintf('NN, Blood, %s',subjects{ss}));
title(sprintf('All subjects'));

%% Fit all the subjects at once for both tongue and lip

Tfiles405 = ieTableGet(T,'substrate','tongue','e wave',405,'e level',980);
Lfiles405 = ieTableGet(T,'substrate','lip','e wave',405,'e level',980);

Tfiles415 = ieTableGet(T,'substrate','tongue','e wave',415,'e level',910);
Lfiles415 = ieTableGet(T,'substrate','lip','e wave',415,'e level',910);

allFiles = cat(1,Tfiles405,Tfiles415,Lfiles405,Lfiles415);
allData = oeReadFiles(allFiles,'normalized wave',normWave,'wave',wave);

% plot(wave,oxyTransmittance);

[global_params, wgtsNN, skewedG] = oeSolveFluorophoresSkewedGaussians(wave, allData, oxyTransmittance);
disp('Optimized Gaussian Parameters:');
disp(global_params);

disp('Non-Negative Weights for each spectrum:');
disp(wgtsNN);

ieFigure;
mx = max(skewedG);
plot(wave,skewedG*diag(1./mx),'LineWidth',2);
title('Fluorophores: Blood');
lgn = legend({num2str(round(global_params(1))),num2str(round(global_params(2))),num2str(round(global_params(3)))});
grid on;

%{
hdl = ieFigure;
for ii=1:3
    estimate = ieSkewedGaussian(global_params(ii:3:end),wave);
    plot(wave,estimate/max(estimate)); hold on;
end
title('Fluorophores: No blood')
%}

% This is the error.
% fitError = tongueData - Gaussians*weights;
% rmserror = norm(fitError(:),2);
% disp('RMSE');
% disp(rmserror);

ieFigure([],'wide');
tiledlayout(1,2);
nexttile;
plot(wave,allData,'k-',wave,skewedG*wgtsNN,'k:');
grid on; title(sprintf('NN, Blood, %s',subjects{ss}));
title(sprintf('All subjects'));

tmp = skewedG*wgtsNN;
nexttile; 
scatter(allData(:),tmp(:),'b.');
identityLine;
grid on;
xlabel('Data'); ylabel('Predicted');

%%