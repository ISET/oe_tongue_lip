% s_FluorophoreBasis.m

%% make sure these libraries are on your path
%{
wave = 
%}

% We are showing examples of weighted sums of collagen, elastin, keratin
% and FAD.  For the lip, keratin would be zero.
%
dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');

% Let's fit this one, but only for wavelengths above 480 nm
ieNewGraphWin;
wave = 400:5:700;
% First compare the fluorophores and then select
% For these fluorophores, the columns of the excitation-emission matrix are
% all pretty much the same, apart from a scale factor. So the excitation is
% just a vector.
%
% Can emissions of fluorophores be modeled by a log-normal distribution
% with single peak? Read in the spectral emissions functions for different
% tissue fluorophores data in isetfluorescence repository

% Collagen_Wu&Qu_emissions.mat
% Keratin_Wu&Qu_emissions.mat
% elastinPaleroEtAl2007.mat
% keratinPaleroEtAl2007.mat

ieNewGraphWin;
collagen = fiReadFluorophore('collagen1.mat','wave',wave); 
plot(wave, collagen.emission/max(collagen.emission(:)),'b','LineWidth',2); hold on;
collagenWuAndQu = ieReadSpectra('Collagen_Wu&Qu_emissions',wave); % use this one
plot(wave, collagenWuAndQu/max(collagenWuAndQu(:)),'b--','LineWidth',2);

ieNewGraphWin;
keratin = fiReadFluorophore('keratin.mat','wave',wave);
plot(wave, keratin.emission/max(keratin.emission(:)),'g','LineWidth',2);  hold on;
keratinWuAndQu = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',wave); % use this one
plot(wave, keratinWuAndQu/max(keratinWuAndQu(:)),'g--','LineWidth',2);
keratinPalero = ieReadSpectra('keratinPaleroEtAl2007.mat',wave); 
plot(wave, keratinPalero/max(keratinPalero(:)),'g:','LineWidth',2);
legend('DaCosta et al 2003', 'Wu & Qu 2006', 'Palero Et Al 2007');
title('Keratin Emissions');

ieNewGraphWin;
FAD = fiReadFluorophore('FAD_webfluor.mat','wave',wave); 
plot(wave, FAD.emission/max(FAD.emission(:)),'r','LineWidth',2); hold on; % use this one
FADAlfano = ieReadSpectra('FAD_emissions_Alfano.mat',wave);
plot(wave, FADAlfano/max(FADAlfano(:)),'r--','LineWidth',2);

ieNewGraphWin;
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',wave); 
plot(wave, NADH.emission/max(NADH.emission(:)),'k','LineWidth',2);hold on; % use this one
NADHAlfano = ieReadSpectra('NADH_emissions_Alfano.mat',wave);
plot(wave, NADHAlfano/max(NADHAlfano(:)),'k--','LineWidth',2);

%% use these for the basis
ieNewGraphWin;
collagenWuAndQu = ieReadSpectra('Collagen_Wu&Qu_emissions',wave); 
plot(wave, collagenWuAndQu/max(collagenWuAndQu(:)),'b','LineWidth',2); hold on;
keratinWuAndQu = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',wave); % use this one
plot(wave, keratinWuAndQu/max(keratinWuAndQu(:)),'g','LineWidth',2);
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',wave); 
plot(wave, NADH.emission/max(NADH.emission(:)),'k','LineWidth',2);hold on; % use this one
FAD = fiReadFluorophore('FAD_webfluor.mat','wave',wave); 
plot(wave, FAD.emission/max(FAD.emission(:)),'r','LineWidth',2); hold on; % use this one
porphyrins = fiReadFluorophore('protoporphyrin.mat','wave',wave);
plot(wave, porphyrins.emission/max(porphyrins.emission(:)),'m','LineWidth',2); 

%% Notice that between 500 and 600 nm, we cannot differentiate between NADH, collagen, keratin 
% there are effectively only two basis functions
wave = 500:5:600;
ieNewGraphWin;
collagenWuAndQu = ieReadSpectra('Collagen_Wu&Qu_emissions',wave); 
plot(wave, collagenWuAndQu/max(collagenWuAndQu(:)),'b','LineWidth',2); hold on;
keratinWuAndQu = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',wave); % use this one
plot(wave, keratinWuAndQu/max(keratinWuAndQu(:)),'g','LineWidth',2);
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',wave); 
plot(wave, NADH.emission/max(NADH.emission(:)),'k','LineWidth',2);hold on; % use this one
FAD = fiReadFluorophore('FAD_webfluor.mat','wave',wave); 
plot(wave, FAD.emission/max(FAD.emission(:)),'r','LineWidth',2); hold on; % use this one
legend('collagen','keratin', 'NADH', 'FAD');
% we won't use porphyrins for lip
%{
% Holding these out for testing later.
 elastin = fiReadFluorophore('elastin_webfluor.mat','wave',waves); 
 plot(waves, elastin.emission/max(elastin.emission),'m','LineWidth',2);  
 from DaCosta % cannot be modeled as log-normal with single peak
 NADH = fiReadFluorophore('NADH_webfluor.mat','wave',waves);
 plot(waves, NADH.emission/max(NADH.emission),'k','LineWidth',2);
%}


%% Have a look at the EEMs for the flourophores
%
% Notice that a couple of them are relatively weak above 450/475 where we
% have the measurements.  But those may be the ones we are seeing.
%{
fluorophorePlot(keratin,'eem');
fluorophorePlot(FAD,'eem');
fluorophorePlot(collagen,'eem');
fluorophorePlot(porphyrins,'eem');
%}
%%
fBasis = ...
    [keratin.emission/max(keratin.emission(:)), ...
    FAD.emission/max(FAD.emission(:)), ...
    collagen.emission/max(collagen.emission(:)), ...
    porphyrins.emission/max(porphyrins.emission(:))];
% ieNewGraphWin; plot(wave,fBasis);
% Find the weights from fluorophores to the full data
% data = fBasis*wgts, but the weights must be non-negative
cols = 1:3;
wgts = lsqnonneg(fBasis(:,cols),data);
% wgts = pinv(fBasis(:,1:3))*data;

%% for lip, only two basis functions?

fname = 'spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat';
wave = 500:5:600;
[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);

fBasis = [FAD.emission/max(FAD.emission(:)), collagenWuAndQu/max(collagenWuAndQu(:))];
% ieNewGraphWin; plot(wave,fBasis); legend('FAD','collagen');
% Find the weights from fluorophores to the full data
% data = fBasis*wgts, but the weights must be non-negative
cols = 1:2;
wgts = lsqnonneg(fBasis(:,cols),data);
% wgts = pinv(fBasis(:,1:3))*data;

ieNewGraphWin;
plot(wave,data,'g-',wave,fBasis(:,cols)*wgts,'k:')

% Choose the OD to minimize this?
rmse(fBasis(:,cols)*wgts,data)
disp(fname)
disp(wgts)