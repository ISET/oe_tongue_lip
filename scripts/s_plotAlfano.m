%s_plotAlfano.m
%
% The fluorophore emissions taken from Figue 1 in Alfano, R. R. (2012). 
% Advances in ultrafast time resolved fluorescence physics for cancer detection in optical biopsy. AIP Advances, 2(1).
% These are pretty different from the others
% With the exception of NADH and FAD, we do not really know the peak
% wavelength based on single photon imaging
% two photon imaging has challenges, but perhaps we use that for the peak
% wavelengths?
%% make sure these libraries are on your path
%{
cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));
%}
%
ieInit;
waves = 250:5:700;

%%

ieNewGraphWin;
collagen = ieReadSpectra('collagen_emissions_Alfano.mat',waves);
plot(waves, collagen/max(collagen(:)),'g--','LineWidth',2); hold on;
elastin = ieReadSpectra('elastin_emissions_Alfano.mat',waves);
plot(waves, elastin/max(elastin(:)),'r--','LineWidth',2); hold on; 
NADH = ieReadSpectra('NADH_emissions_Alfano.mat',waves);
plot(waves, NADH/max(NADH(:)),'b--','LineWidth',2); hold on; 
FAD = ieReadSpectra('FAD_emissions_Alfano.mat',waves);
plot(waves, FAD/max(FAD(:)),'k--','LineWidth',2); hold on; 
collagen_emissions = ieReadSpectra('Collagen_Wu&Qu_emissions.mat',waves); 
plot(waves,collagen_emissions/max(collagen_emissions(:)),'g','LineWidth',2); hold on;
elastin = fiReadFluorophore('elastin_webfluor.mat','wave',waves); % not
plot(waves, elastin.emission/max(elastin.emission),'r','LineWidth',2); 
% keratin_emissions = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',waves); 
% plot(waves,keratin_emissions/max(keratin_emissions(:)),'r','LineWidth',2); hold on;
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',waves);
plot(waves, NADH.emission/max(NADH.emission),'b','LineWidth',2);
FAD = fiReadFluorophore('FAD_webfluor.mat','wave',waves); 
plot(waves, FAD.emission/max(FAD.emission(:)),'k','LineWidth',2);  
legend('collagen (Alfano)','elastin (Alfano)','NADH (Alfano)','FAD (Alfano)', 'collagen (Wu&Qu)', 'elastin (DaCosta)', 'NADH (DaCosta)', 'FAD (DaCosta');
% not sure about elastin

set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');
title('Fluorophore Emissions')