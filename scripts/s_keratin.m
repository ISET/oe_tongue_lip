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
% compare the different keratin and collagen curves
% data from Figures 4 (collagen) and 7 (keratin) excited by 355, the peak is determined by the long pass filter:  
% 'A series of long-pass filters were used to attenuate the reflected excitation light 
% from the sample to a level comparable to the intensity of the fluorescence signal."
ieNewGraphWin;
keratin_emissions = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',waves); 
plot(waves,keratin_emissions/max(keratin_emissions(:)),'r','LineWidth',2); hold on;
collagen_emissions = ieReadSpectra('Collagen_Wu&Qu_emissions.mat',waves); % use this one 
plot(waves,collagen_emissions/max(collagen_emissions(:)),'g','LineWidth',2); hold on;
title('data from Wu & Gu 2006, Figs 4 and 7')
legend('keratin', 'collagen');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

% notice that peak wavelength for emissions is at longer wavelength for
% keratin measured by Wu & Gu (2006)
%{
ieNewGraphWin;
keratin_emissions = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',waves); % Wu & Qu 2006
plot(waves,keratin_emissions/max(keratin_emissions(:)),'r','LineWidth',2); hold on;
keratin = fiReadFluorophore('keratin.mat','wave',waves);                % DaCosta et al 2003
plot(waves, keratin.emission/max(keratin.emission(:)),'r--','LineWidth',2); 
legend( 'Wu and Qu (2006)', 'DaCosta et al (2003)');
title('Keratin emission spectra');
%}

%{
ieNewGraphWin;
collagen_emissions = ieReadSpectra('Collagen_Wu&Qu_emissions.mat',waves); %  Wu & Qu 2006
plot(waves,collagen_emissions/max(collagen_emissions(:)),'g','LineWidth',2); hold on;
collagen = fiReadFluorophore('collagen1.mat','wave',waves); % DaCosta et al 2003
plot(waves, collagen.emission/max(collagen.emission(:)),'g--','LineWidth',2); 
legend( 'Wu and Qu (2006)', 'DaCosta et al (2003)');
title('Collagen emission spectra');
%}

% Note that Pena Et Al 2005 have exactly same emission spectra as Wu&Qu2006
%   Why is that? One would not expect to be EXACTLY the same!
%   keratinPenaEtAl = ieReadSpectra('Keratin_Emission_PenaEtAl2005.mat',waves);
%   plot(waves,keratinPenaEtAl/max(keratinPenaEtAl(:)),'g*','LineWidth',2); hold on;
%   I think that the Keratin_WuandQu.mat data were taken from PenaEtAl2005 -
%   so rename Keratin_WuandQu.mat to be KeratinPenaEtAl2005.mat
%{ 
ieNewGraphWin;
keratin_emissions = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',waves); % Wu & Qu 2006
plot(waves,keratin_emissions/max(keratin_emissions(:)),'r','LineWidth',2); hold on;
keratinWuQu = fiReadFluorophore('Keratin_WuandQu.mat','wave',waves); % mislabeled
plot(waves,keratinWuQu.emission/max(keratinWuQu.emission(:)),'r--','LineWidth',2); hold on;
keratin_emissions_Pena = ieReadSpectra('Keratin_Emission_PenaEtAl2005',waves); 
plot(waves,keratin_emissions_Pena/max(keratin_emissions_Pena(:)),'r:','LineWidth',2); hold on;
legend('Keratin-Wu&Qu_emissions.mat','Keratin-WuandQu.mat','Keratin-Emission-PenaEtAl2005');
%}

%% use these as spectral basis functions
ieNewGraphWin;
collagen_emissions = ieReadSpectra('Collagen_Wu&Qu_emissions.mat',waves); 
plot(waves,collagen_emissions/max(collagen_emissions(:)),'g','LineWidth',2); hold on;
keratin_emissions = ieReadSpectra('Keratin_Wu&Qu_emissions.mat',waves); 
plot(waves,keratin_emissions/max(keratin_emissions(:)),'r','LineWidth',2); hold on;
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',waves);
plot(waves, NADH.emission/max(NADH.emission),'k','LineWidth',2);
FAD = fiReadFluorophore('FAD_webfluor.mat','wave',waves); 
plot(waves, FAD.emission/max(FAD.emission(:)),'b','LineWidth',2);  
legend('collagen (Wu&Qu2006)', 'keratin (Wu&Qu2006)', 'NADH (DaCosta et al 2003)', 'FAD (DaCosta et al 2003)');
% not sure about elastin
% elastin = fiReadFluorophore('elastin_webfluor.mat','wave',waves); % not
% plot(waves, elastin.emission/max(elastin.emission),'m','LineWidth',2); 
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');
title('Fluorophore Emissions')