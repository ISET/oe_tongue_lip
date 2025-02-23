%% s_bloodEstimate
%
% The model is that the excitation light is short wave.  The amount that
% gets through controls the overall level.
%
% The spectrum that we measure is the emitted fluorescence.  That light,
% too, passes through the blood.  The blood acts as a filter, thus the
% fluorescence is multiplied by the blood transmittance.  There is more
% oxygenated blood than deoxygenated, and thus we first try with just
% oxygenated.
%
% To remove the effect of the oxygenated blood, we need to estimate its
% transmittance and divide the fluorescence by the transmittance.
%
% Starting with the raw measurement, we divide by different amounts of
% blood transmittance and define some feature of the result that we use as
% establishing the correct blood absorbance.
% 

%% An example
dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');
fname = 'spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat';

% Load some raw fluorescence data
[data,wave] = ieReadSpectra(fullfile(dataDir,fname));
oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);

%{
ieNewGraphWin;
plot(wave,data/max(data(:)),'g-');
hold on;
oxyblood.plot('transmittance','new figure',false,'line','r-');
%}

%% Here are examples of the blood at different densities

ieNewGraphWin;
od = logspace(-1,1.5,10);
for ii = 1:numel(od)
    oxyblood.opticalDensity = od(ii);
    oxyblood.plot('transmittance','line','r-','new figure',false);
    hold on;
end

%%
od = 0.0:0.3:3;
ieNewGraphWin;
for ii=1:numel(od)
    oxyblood.opticalDensity = od(ii);
    transmittance = oxyblood.transmittance;
    k = 1;
    est = data ./ (k*transmittance);
    plot(wave,est,'k-',wave,data,'g--'); hold on;
    % oxyblood.plot('transmittance','new figure',false,'line','r-');
end

%% Lip

% Load some raw fluorescence data
fname = 'spd-2024-03-14-Z-415nm_lip_910mA.mat';
[data,wave] = ieReadSpectra(fullfile(dataDir,fname));

od = 0.0:0.3:3;
ieNewGraphWin;
for ii=1:numel(od)
    oxyblood.opticalDensity = od(ii);
    transmittance = oxyblood.transmittance;
    k = 1;
    est = data ./ (k*transmittance);
    plot(wave,est,'k-',wave,data,'g--'); hold on;
    % oxyblood.plot('transmittance','new figure',false,'line','r-');
end

%% Different excitation, also Z
fname = 'spd-2024-03-14-Z-405nm_lip_980mA.mat';
[data,wave] = ieReadSpectra(fullfile(dataDir,fname));
od = 0.0:0.3:3;
ieNewGraphWin;
for ii=1:numel(od)
    oxyblood.opticalDensity = od(ii);
    transmittance = oxyblood.transmittance;
    k = 1;
    est = data ./ (k*transmittance);
    plot(wave,est,'k-',wave,data,'g--'); hold on;
    % oxyblood.plot('transmittance','new figure',false,'line','r-');
    title(fname);
end

%%  Here are the expected fluorescence signals without blood
%
% We are showing examples of weighted sums of collagen, elastin, keratin
% and FAD.  For the lip, keratin would be zero.
%

% Let's fit this one, but only for wavelengths above 480 nm
fname = 'spd-2024-03-14-Z-415nm_lip_910mA.mat';
wave = 480:5:600;
[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);

% For these fluorophores, the columns of the excitation-emission matrix are
% all pretty much the same, apart from a scale factor. So the excitation is
% just a vector.
%
% Can emissions of fluorophores be modeled by a log-normal distribution
% with single peak? Read in the spectral emissions functions for different
% tissue fluorophores data in isetfluorescence repository

ieNewGraphWin;
keratin = fiReadFluorophore('keratin.mat','wave',wave);
plot(wave, keratin.emission/max(keratin.emission(:)),'g','LineWidth',2);  hold on;

FAD = fiReadFluorophore('FAD_webfluor.mat','wave',wave); 
plot(wave, FAD.emission/max(FAD.emission(:)),'r','LineWidth',2);

collagen = fiReadFluorophore('collagen1.mat','wave',wave); 
plot(wave, collagen.emission/max(collagen.emission(:)),'b','LineWidth',2);
%{
% Holding these out for testing later.
 elastin = fiReadFluorophore('elastin_webfluor.mat','wave',waves); 
 plot(waves, elastin.emission/max(elastin.emission),'m','LineWidth',2);  
 from DaCosta % cannot be modeled as log-normal with single peak
 NADH = fiReadFluorophore('NADH_webfluor.mat','wave',waves);
 plot(waves, NADH.emission/max(NADH.emission),'k','LineWidth',2);
%}

% Only on the tongue for some subjects
porphyrins = fiReadFluorophore('protoporphyrin.mat','wave',wave);
plot(wave, porphyrins.emission/max(porphyrins.emission(:)),'r--','LineWidth',2);  

%% Have a look at the EEMs for the flourophores
%
% Notice that a couple of them are relatively weak above 450/475 where we
% have the measurements.  But those may be the ones we are seeing.
fluorophorePlot(keratin,'eem');
fluorophorePlot(FAD,'eem');
fluorophorePlot(collagen,'eem');
fluorophorePlot(porphyrins,'eem');

fBasis = ...
    [keratin.emission/max(keratin.emission(:)), ...
    FAD.emission/max(FAD.emission(:)), ...
    collagen.emission/max(collagen.emission(:)), ...
    porphyrins.emission/max(porphyrins.emission(:))];
ieNewGraphWin; plot(wave,fBasis);


%% Find the weights from fluorophores to the full data

% data = fBasis*wgts, but the weights must be non-negative
cols = 1:4;
wgts = lsqnonneg(fBasis(:,cols),data);
% wgts = pinv(fBasis(:,1:3))*data;

ieNewGraphWin;
plot(wave,data,'g-',wave,fBasis(:,cols)*wgts,'k:')

% Choose the OD to minimize this?
rmse(fBasis*wgts,data)

