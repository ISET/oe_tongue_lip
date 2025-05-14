%% make sure these libraries are on your path
%{
cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));
%}


%% Basis

ieNewGraphWin;
collagen = ieReadSpectra('Collagen_Wu&Qu_emissions',wave); 
plot(wave, collagen/max(collagen(:)),'b','LineWidth',2); hold on;
elastin = fiReadFluorophore('elastin_webfluor.mat','wave',wave);
plot(wave, elastin.emission/max(elastin.emission),'c','LineWidth',2);
keratin= ieReadSpectra('Keratin_Wu&Qu_emissions.mat',wave); % use this one
plot(wave, keratinWuAndQu/max(keratinWuAndQu(:)),'g','LineWidth',2);
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',wave); 
plot(wave, NADH.emission/max(NADH.emission(:)),'k','LineWidth',2);hold on; % use this one
FAD = fiReadFluorophore('FAD_webfluor.mat','wave',wave); 
plot(wave, FAD.emission/max(FAD.emission(:)),'r','LineWidth',2); hold on; % use this one
porphyrins = fiReadFluorophore('protoporphyrin.mat','wave',wave);
plot(wave, porphyrins.emission/max(porphyrins.emission(:)),'m','LineWidth',2); 
legend('Collagen-Wu&Qu-emissions','Keratin-Wu&Qu-emissions','NADH-webfluor','FAD-webfluor','protoporphyrin');
set(gca,'fontsize',16);

% 5 spectral basis

fBasis = ...
    [collagen/max(collagen(:)), ...
     FAD.emission/max(FAD.emission(:)), ...
    elastin.emission/max(elastin.emission(:)), ...
    keratin/max(keratin(:)), ...
    porphyrins.emission/max(porphyrins.emission(:))];
ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
legend('collagen','elastin','FAD','keratin','porphyrins');

fBasis = ...
    [collagen/max(collagen(:)), ...
     FAD.emission/max(FAD.emission(:)), ...
    keratin/max(keratin(:)), ...
    porphyrins.emission/max(porphyrins.emission(:))];
ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
legend('collagen','FAD','keratin','porphyrins');

% An example
dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');
fname = 'spd-2024-03-14-Z-415nm_lip_910mA.mat';
wave = 500:5:600;
[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);
ieNewGraphWin; plot(wave,data);

% fBasis = [FAD.emission/max(FAD.emission(:)), collagenWuAndQu/max(collagenWuAndQu(:))];
% ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); legend('FAD','collagen'); set(gca,'fontsize',16);
% Find the weights from fluorophores to the full data
% data = fBasis*wgts, but the weights must be non-negative
n=3;
cols = 1:n;
% wgts = lsqnonneg(fBasis(:,cols),data)
% wgts = pinv(fBasis(:,1:n))*data;
ieNewGraphWin; plot(wave,data,'g','LineWidth',2); hold on;
plot(wave,fBasis(:,cols)*wgts,'k-o','LineWidth',2); % predicted based on just two fluorophores
rmse(fBasis(:,cols)*wgts,data)
disp(fname)
wgts

%% Predicted Radiance assuming fluorophore emissions transmitted through blood
% The measured radiance cannot be explained by fluorophore emissions (FE) alone
% Can we multiply FE with blood tranmittance and, if so, what is the optical density
FE = fBasis(:,cols)*wgts;

oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);
%{
ieNewGraphWin;
plot(wave,data/max(data(:)),'g-');
hold on;
oxyblood.plot('transmittance','new figure',false,'line','r-');
%}

%% Here are examples of the blood at different densities
%{
ieNewGraphWin;
od = logspace(-1,1.5,10);
for ii = 1:numel(od)
    oxyblood.opticalDensity = od(ii);
    oxyblood.plot('transmittance','line','r-','new figure',false);
    hold on;
end
%}
%% 
% od = 0.0:0.3:2;
% ieNewGraphWin;
% for ii=1:numel(od)
%     oxyblood.opticalDensity = od(ii);
%     transmittance = oxyblood.transmittance;
%     k = 1;
%     est = data ./ (k*transmittance);
%     plot(wave,est,'k-',wave,data,'g--'); hold on;
%     % oxyblood.plot('transmittance','new figure',false,'line','r-');
% end

%% when od=0, then there is no blood
% of course, subtracting no blood will give us the data
% but 
od = 0.0:0.3:2;
ieNewGraphWin;
for ii=1:numel(od)
    oxyblood.opticalDensity = od(ii);
    transmittance = oxyblood.transmittance;
    k = 1;
    est = data ./ (k*transmittance);
    plot(wave,est,'k-',wave,data,'g--'); hold on;
    % oxyblood.plot('transmittance','new figure',false,'line','r-');
end

%% 
od = 0.0:2:4;
ieNewGraphWin;
for ii=1:numel(od)
    oxyblood.opticalDensity = od(ii);
    transmittance = oxyblood.transmittance;
    ieNewGraphWin;
    for jj = 1.5:0.5: 3;
    est = (expectedF) .* (jj*transmittance);
    semilogy(wave,data,'g','lineWidth',2); hold on;
    semilogy(wave,est,'k-o'); 
    % oxyblood.plot('transmittance','new figure',false,'line','r-');
    end
end
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Radiance (watts/sr/nm/m^2)');
legend('Measured Radiance', 'Two Fluorophores', 'transmitted fluorescence');
title(fname);

%% What if I only attenuate collagen fluorescence with blood
% also add keratin for tongue 
% collagen and keratin, use data from Wu & Qu
% collagen attenuated by blood, but not FAD or keratin

ieNewGraphWin; plot(wave,collagen,'b','LineWidth',2);

od = 0.0:2:4;
ieNewGraphWin;
for ii=1:numel(od)
    oxyblood.opticalDensity = od(ii);
    transmittance = oxyblood.transmittance;
    ieNewGraphWin;
    for jj = 1.5:0.5: 3;
    est = collagen.* (jj*transmittance);
    semilogy(wave,data,'g','lineWidth',2); hold on;
    semilogy(wave,est,'k-o'); 
    % oxyblood.plot('transmittance','new figure',false,'line','r-');
    end
end
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Radiance (watts/sr/nm/m^2)');
legend('Measured Radiance', 'Two Fluorophores', 'transmitted fluorescence');
title(fname);



od = 0.0:2:8;
ieNewGraphWin;
for ii=1:numel(od)
    oxyblood.opticalDensity = od(ii);
    transmittance = oxyblood.transmittance; 
    k=1;
    est = collagen.* (k*transmittance);
    semilogy(wave,data,'g','lineWidth',2); hold on;
    semilogy(wave,est,'k-o'); 
    % oxyblood.plot('transmittance','new figure',false,'line','r-');
end

%%

collagen = ieReadSpectra('Collagen_Wu&Qu_emissions',wave); 
elastin = fiReadFluorophore('elastin_webfluor.mat','wave',wave);



    oxyblood.opticalDensity = 3;
    transmittance = oxyblood.transmittance; 
    collagen = collagen .* (k*transmittance);
    elastin = elastin.emission .* (k*transmittance);

%     fBasis = ...
%     [collagen/max(collagen(:)) ...
%      FAD.emission/max(FAD.emission(:)), ...
%     keratin/max(keratin(:)), ...
%     porphyrins.emission/max(porphyrins.emission(:))];
%     ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
% legend('collagen','FAD','keratin','porphyrins');
% ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
% legend('collagen','FAD','keratin','porphyrins');


fBasis = ...
    [FAD.emission/max(FAD.emission(:)), ...
    collagen/max(collagen(:)), ...
    elastin/max(elastin(:)), ...
    keratin/max(keratin(:)), ...
    porphyrins.emission/max(porphyrins.emission(:))];
ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
legend('collagen','elastin','FAD','keratin','porphyrins');



n=3;
cols = 1:n;
wgts = lsqnonneg(fBasis(:,cols),data)
% wgts = pinv(fBasis(:,1:n))*data;
ieNewGraphWin; plot(wave,data,'g','LineWidth',2); hold on;
plot(wave,fBasis(:,cols)*wgts,'k-o','LineWidth',2); % predicted based on just two fluorophores
rmse(fBasis(:,cols)*wgts,data)
disp(fname)
wgts


