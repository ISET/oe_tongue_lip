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


% Load some raw fluorescence data
[data,wave] = ieReadSpectra(fullfile(oeTongueLipRootPath,'data','RawTongueLip','spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat'));
oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);

%{
ieNewGraphWin;
plot(wave,data/max(data(:)),'g-');
hold on;
oxyblood.plot('transmittance','new figure',false,'line','r-');
%}

%% Here are examples of the blood at different densities
od = logspace(-1,1.5,10);
for ii = 1:numel(od)
    oxyblood.opticalDensity = od(ii);
    if ii == od(1)
        
        oxyblood.plot('transmittance','line','r-');
        hold on;
    else
        oxyblood.plot('transmittance','new figure',false,'line','r-')
    end
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
[data,wave] = ieReadSpectra(fullfile(oeTongueLipRootPath,'data','RawTongueLip','spd-2024-03-14-Z-415nm_lip_910mA.mat'));

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
dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');
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

