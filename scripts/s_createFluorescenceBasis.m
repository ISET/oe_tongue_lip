% s_createFlourescenceBasis.m

% We assume 
% 1. cannot differentiate between collagen, elastin and NADH fluorescence betwen 500 and 600 nm
% 2. there is more blood at the stromal level where collagen resides so
% blood absorbs more collagen emissions
% we can experiment with density of blood at stromal (collagen) and
% epithelial (FAD) level


%% make sure these libraries are on your path
%{
cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));
%}

%% Possible basis
% when you plot between 500 and 600, you see that we cannot differentiate
% between collagen, keratin, NADH
% wave = 500:5:600;
wave = 500:5:705;
%{
ieNewGraphWin;
collagen = ieReadSpectra('Collagen_Wu&Qu_emissions',wave); 
plot(wave, collagen/max(collagen(:)),'b','LineWidth',2); hold on;
elastin = fiReadFluorophore('elastin_webfluor.mat','wave',wave);
plot(wave, elastin.emission/max(elastin.emission),'c','LineWidth',2);
keratin= ieReadSpectra('Keratin_Wu&Qu_emissions.mat',wave); % use this one
plot(wave, keratin/max(keratin(:)),'g','LineWidth',2);
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',wave); 
plot(wave, NADH.emission/max(NADH.emission(:)),'k','LineWidth',2);hold on; % use this one
FAD = ieReadSpectra('FAD_handbook.mat',wave);
plot(wave,FAD/max(FAD),'r','LineWidth',2);
porphyrins = fiReadFluorophore('protoporphyrin.mat','wave',wave);
plot(wave, porphyrins.emission/max(porphyrins.emission(:)),'m','LineWidth',2); 
legend('Collagen-Wu&Qu','elastin-DaCosta','Keratin-Wu&Qu','NADH-webfluor','FAD-webfluor','protoporphyrin');
set(gca,'fontsize',16);
%}

%% Modify collagen (and elastin) by attenuation by blood
k=1; % can scale transmittance)
d = 2; % density
oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);
    oxyblood.opticalDensity = d;
    transmittance = oxyblood.transmittance; 
    collagen = collagen .* (k*transmittance);
    elastin = elastin.emission .* (k*transmittance);

%% We use collagen, FAD, keratin and porphyrins as possible basis
% For lip, we only use collagen, elastin and FAD
% For tongue, we use collagen, elastin, FAD, keratins and porphyrins
%{
fBasis = ...
    [FAD.emission/max(FAD.emission(:)), ...
    collagen/max(collagen(:)), ...
    elastin/max(elastin(:)), ...
    keratin/max(keratin(:)), ...
    porphyrins.emission/max(porphyrins.emission(:))];
ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
legend('FAD','collagen','keratin','porphyrins');
%}

%{
fBasis = ...
    [FAD.emission/max(FAD.emission(:)), ...
    collagen/max(collagen(:)), ...
    keratin/max(keratin(:)), ...
    porphyrins.emission/max(porphyrins.emission(:))];
ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
legend('FAD','collagen','keratin','porphyrins');
%}

fBasis = ...
    [FAD/max(FAD), ...
    collagen/max(collagen(:)), ...
    porphyrins.emission/max(porphyrins.emission(:))];
ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
legend('FAD','collagen','porphyrins');

%% Load some raw fluorescence data 
%{
dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');
wavelength = 500:5:705;

ieNewGraphWin;
fname = 'spd-2024-03-12-11-405nm-J-lip-980mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-14-Z-405nm_lip_980mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-B_405nm_lip_980mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-D_4050nm_lip_980mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
 
ieNewGraphWin;
fname = 'spd-2024-03-12-11-415nm-J-lip-910mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-14-Z-415nm_lip_910mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-B_415nm_lip_910mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-D_415nm_lip_910mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;

ieNewGraphWin;
fname = 'spd-2024-03-12-11-450nm-J-lip-870mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-14-Z-450nm_lip_870mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-B_450nm_lip_870mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-D_450nm_lip_870mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
%}

dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');
fname = 'spd-2024-03-14-Z-405nm_lip_980mA.mat';
% fname = 'spd-2024-03-14-Z-415nm_lip_910mA.mat';
% fname = 'spd-2024-03-14-Z-450nm_lip_870mA.mat';
[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);
% ieNewGraphWin; plot(wave,data/max(data(:)));

%%
n=2; % for lip, just collagen and FAD
cols = 1:n;
data = data/max(data(:));
wgts = lsqnonneg(fBasis(:,cols),data)
% wgts = pinv(fBasis(:,1:n))*data;
% ieNewGraphWin; 
plot(wave,data,'g','LineWidth',2); hold on;
plot(wave,fBasis(:,cols)*wgts,'k-o','LineWidth',2); % predicted based on just two fluorophores
rmse(fBasis(:,cols)*wgts,data)
disp(fname)
wgts

%% tongue

%{
ieNewGraphWin;
fname = 'spd-2024-03-12-11-405nm-J-tongue-980mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-14-Z-405nm_tongue_980mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-B_405nm_tongue_980mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-D_4050nm_tongue_980mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;

ieNewGraphWin;
fname = 'spd-2024-03-12-11-415nm-J-tongue-910mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-B_415nm_tongue_910mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-14-Z-415nm_Tongue_910mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-D_415nm_tongue_910mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;

ieNewGraphWin;
fname = 'spd-2024-03-12-450nm-J-tongue-460mA-1.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-14-Z-450nm_tongue_870mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-B_450nm_tongue_870mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
fname = 'spd-2024-03-19-D_450nm_tongue_870mA.mat';
data = ieReadSpectra(fullfile(dataDir,fname),wavelength); plot(wavelength,data/max(data(:))); hold on;
%}

[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);
% ieNewGraphWin; plot(wave,data/max(data(:)));

%%
n=3;
cols = 1:n;
% data = data/max(data(:));
wgts = lsqnonneg(fBasis(:,cols),data)
% wgts = pinv(fBasis(:,1:n))*data;
% ieNewGraphWin; 
plot(wave,data,'g','LineWidth',2); hold on;
plot(wave,fBasis(:,cols)*wgts,'k-o','LineWidth',2); % predicted based on just two fluorophores
rmse(fBasis(:,cols)*wgts,data)
disp(fname)
wgts
