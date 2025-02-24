% s_keratin.m


%% make sure these libraries are on your path
%{
cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));
%}

% Can emissions of fluorophores be modeled by a log-normal distribution
% with single peak? Read in the spectral emissions functions for different
% tissue fluorophores data in isetfluorescence repository

ieInit;
waves = 250:5:700;  % plot shorter wavelengths so that we can see the peak

%% Spectral basis functions 
% These EEMs are based on one-photon imaging

% The EEMs in the isetfluorescence/webfluor are from 
%   Ralph S. DaCosta, Helene Andersson, Brian C. Wilson 
%   "Molecular Fluorescence Excitation–Emission Matrices Relevant to Tissue Spectroscopy," 
%   Photochemistry and Photobiology, 78(4), 384-392, (1 October 2003)

% the EEM in isetfluorescence/Keratin/Keratin_WuandQue.mat are from
%   Wu Y, Qu JY. Autofluorescence spectroscopy of epithelial tissues. 
%   J Biomed Opt. 2006 Sep-Oct;11(5):054023. doi: 10.1117/1.2362741. PMID: 17092172.
% 143 citations

% notice that peak wavelength for emissions is at longer wavelength for
% keratin measured by Wu & Gu (2006)
%{
keratin = fiReadFluorophore('keratin.mat','wave',waves);
ieNewGraphWin; plot(waves, keratin.emission/max(keratin.emission(:)),'g','LineWidth',2);  hold on;
keratinWuQu = fiReadFluorophore('Keratin_WuandQu.mat','wave',waves);
plot(waves,keratinWuQu.emission/max(keratinWuQu.emission(:)),'g--','LineWidth',2); 
legend('DaCosta et al (2003)', 'Wu and Qu (2006)');
title('Keratin emissions');
%}
% Note that Pena Et Al 2005 have exactly same emission spectra as Wu&Qu2006
%   Why is that? One would not expect to be EXACTLY the same!
%   keratinPenaEtAl = ieReadSpectra('Keratin_Emission_PenaEtAl2005.mat',waves);
%   plot(waves,keratinPenaEtAl/max(keratinPenaEtAl(:)),'g*','LineWidth',2); hold on;
%   I think that the Keratin_WuandQu.mat data were taken from PenaEtAl2005 -
%   so redo this

% compare the different keratin and collagen curves
ieNewGraphWin;
keratin_emissions = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',waves);
plot(waves,keratin_emissions/max(keratin_emissions(:)),'g:','LineWidth',2); hold on;
keratinWuQu = fiReadFluorophore('Keratin_WuandQu.mat','wave',waves); 
plot(waves,keratinWuQu.emission/max(keratinWuQu.emission(:)),'g--','LineWidth',2); hold on;
keratin = fiReadFluorophore('keratin.mat','wave',waves);
plot(waves, keratin.emission/max(keratin.emission(:)),'g','LineWidth',2);  hold on;

collagen_emissions = ieReadSpectra('Collagen_Wu&Qu_emissions.mat',waves);
plot(waves,collagen_emissions/max(collagen_emissions(:)),'b:','LineWidth',2); hold on;
collagen = fiReadFluorophore('collagen1.mat','wave',waves); 
plot(waves, collagen.emission/max(collagen.emission(:)),'b','LineWidth',2); 
legend('keratin (Wu & Gu (2006)', 'keratin (Pena et al)', 'keratin (DaCosta et al 2003)','collagen (Wu & Gu (2006)', 'collagen (DaCosta et al 2003)');


FAD = fiReadFluorophore('FAD_webfluor.mat','wave',waves); 
plot(waves, FAD.emission/max(FAD.emission(:)),'r','LineWidth',2);  
elastin = fiReadFluorophore('elastin_webfluor.mat','wave',waves); 
plot(waves, elastin.emission/max(elastin.emission),'m','LineWidth',2);  
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',waves);
plot(waves, NADH.emission/max(NADH.emission),'k','LineWidth',2);
legend('keratin (Wu & Gu (2006)', 'keratin (Pena et al)','keratin (DaCosta et al 2003)',...
'collagen (Wu & Gu (2006)', 'collagen (DaCosta et al 2003)',...
'FAD (DaCosta et al 2003)','elastin (DaCosta et al 2003)','NADH (DaCosta et al 2003)');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');
title('Fluorophore Emissions')