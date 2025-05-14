s_compareTongueLipSpectralShape.m


% Purpose; Compare the shape of the spectral emissions measured from
% tongue and inner lip?
% The idea being that the tongue should have a higher concentration of
% keratin?
% If we normalize the data by dividing by the amplitude at 500 nm, then we
% can compare the shape of the spectral emissions for tongue and lip. After
% normalization, the amplitude of tissue fluoresence for tongue was higher
% than the amplitude of tissue fluorescence for oral mucosal tissue on inner lip area, 
% perhaps due to keratin? 
% Also, for some subjects, porphyrin and chlorophyll on tongue, but not on
% oral mucosal tissue on inner lip area

cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/;
addpath(genpath(pwd));
ieInit;

waves = 350:5:800;

%% 
% only compare the emissions measured at highest excitation light intensity
% and normalize by dividing by mas

%% Directory for where the data are
% Note that these paths are different depending on the computer I am on -
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (415nm Tongue+lip measurements';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (415nm Tongue+lip measurements';

% Zhenyi (415)
% tongue
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-910mA-R01.mat',waves);  figure;  plot(waves,Z_tongue/Z_tongue(31),'r','LineWidth',2); hold on; 
Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-910mA-R01.mat',waves);   plot(waves,Z_lip/Z_lip(31),'g','LineWidth',2); 
title('ZL 415 nm light (2024-03-07)'); legend('tongue','lip');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat',waves); figure;  plot(waves,B_tongue/B_tongue(31),'r','LineWidth',2); hold on;
B_lip= ieReadSpectra('spd-2024-03-07-B-lip-415nm450SPF-910mA-R01.mat',waves);  plot(waves,B_lip/B_lip(31),'g','LineWidth',2); 
title('BW 415 nm light (2024-03-07)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';

D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_910mA-R01.mat',waves); figure;  plot(waves,D_tongue/D_tongue(31),'r','LineWidth',2); hold on;
D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_910mA-R01.mat',waves);  plot(waves,D_lip/D_lip(31),'g','LineWidth',2); 
title('DF 415 nm ligth (2024-03-08)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R01.mat',waves); figure;  plot(waves,J_tongue/J_tongue(31),'r','LineWidth',2); hold on;
J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-910mA-R01.mat',waves);   plot(waves,J_lip/J_lip(31),'g','LineWidth',2); 
title('JF 415 nm light (2024-03-08)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);


cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% B and D

D_tongue_405 = ieReadSpectra('spd-2024-03-19-D_4050nm_tongue_980mA.mat',waves); figure;  plot(waves,D_tongue_405/D_tongue_405(31),'r','LineWidth',2); hold on;
D_lip_405 = ieReadSpectra('spd-2024-03-19-D_4050nm_lip_980mA.mat',waves); plot(waves,D_lip_405/D_lip_405(31),'g','LineWidth',2); 
title('DF 405 nm light (2024-03-19)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

D_tongue_415 = ieReadSpectra('spd-2024-03-19-D_415nm_tongue_910mA.mat',waves); figure; plot(waves,D_tongue_415/D_tongue_415(31),'r','LineWidth',2); hold on;
D_lip_415 = ieReadSpectra('spd-2024-03-19-D_415nm_lip_910mA.mat',waves);plot(waves,D_lip_415/D_lip_415(31),'g','LineWidth',2); 
title('DF 415 nm light (2024-03-19)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

D_tongue_450 = ieReadSpectra('spd-2024-03-19-D_450nm_tongue_870mA.mat',waves);figure; plot(waves,D_tongue_450/D_tongue_450(31),'r','LineWidth',2); hold on;
D_lip_450 = ieReadSpectra('spd-2024-03-19-D_450nm_lip_870mA.mat',waves);plot(waves,D_lip_450/D_lip_450(31),'g','LineWidth',2); 
title('DF 450 nm light (2024-03-19)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

% BRIAN

B_tongue_405 = ieReadSpectra('spd-2024-03-19-B_405nm_tongue_90mA.mat',waves); 	figure;  plot(waves,B_tongue_405/B_tongue_405(31),'r','LineWidth',2); hold on;
B_lip_405 = ieReadSpectra('spd-2024-03-19-B_405nm_lip_980mA.mat',waves); plot(waves,B_lip_405/B_lip_405(31),'g','LineWidth',2); 
title('BW 405 nm light (2024-03-19)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

B_tongue_415 = ieReadSpectra('spd-2024-03-19-B_415nm_tongue_910mA.mat',waves); figure;  plot(waves,B_tongue_415/B_tongue_415(31),'r','LineWidth',2); hold on; 
B_lip_415 = ieReadSpectra('spd-2024-03-19-B_415nm_lip_910mA.mat',waves); plot(waves,B_lip_415/B_lip_415(31),'g','LineWidth',2);
title('BW 415 nm light (2024-03-19)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

B_tongue_450 = ieReadSpectra('spd-2024-03-19-B_450nm_tongue_870mA.mat',waves);  figure;  plot(waves,B_tongue_450/B_tongue_450(31),'r','LineWidth',2); hold on;
B_lip_450 = ieReadSpectra('spd-2024-03-19-B_450nm_lip_870mA.mat',waves);  plot(waves,B_lip_450/B_lip_450(31),'g','LineWidth',2); 
title('BW 450 nm light (2024-03-19)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';

Z_tongue_405 = ieReadSpectra('spd-2024-03-14-Z-405nm_tongue_980mA.mat',waves); figure;  plot(waves,Z_tongue_405/Z_tongue_405(31),'r','LineWidth',2); hold on; 
Z_lip_405 = ieReadSpectra('spd-2024-03-14-Z-405nm_lip_980mA.mat',waves);  plot(waves,Z_lip_405/Z_lip_405(31),'g','LineWidth',2); 
title('ZL 405 nm light (2024--03-14)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

Z_tongue_415 = ieReadSpectra('spd-2024-03-14-Z-415nm_Tongue_910mA.mat',waves);  figure;  plot(waves,Z_tongue_415/Z_tongue_415(31),'r','LineWidth',2); hold on; 
Z_lip_415 = ieReadSpectra('spd-2024-03-14-Z-415nm_lip_910mA.mat',waves);  plot(waves,Z_lip_415/Z_lip_415(31),'g','LineWidth',2); 
title('ZL 415 nm light (2024--03-14)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

Z_tongue_450 = ieReadSpectra('spd-2024-03-14-Z-450nm_tongue_870mA.mat',waves); figure;  plot(waves,Z_tongue_450/Z_tongue_450(31),'r','LineWidth',2); hold on; 
Z_lip_450= ieReadSpectra('spd-2024-03-14-Z-450nm_lip_870mA.mat',waves); plot(waves,Z_lip_450/Z_lip_450(31),'g','LineWidth',2); 
title('ZL 450 nm light (2024--03-14)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

%cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-02-20 (Lip and Tongue fluorescence with 4 lights)';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-02-20 (Lip and Tongue fluorescence with 4 lights)';

J_tongue_405 = ieReadSpectra('spd-2024-02-20-405nm-tongue-950mA.mat',waves); figure;  plot(waves,J_tongue_405/J_tongue_405(31),'r','LineWidth',2); hold on;
J_lip_405 = ieReadSpectra('spd-2024-02-20-405nm-lip-950mA.mat',waves); plot(waves,J_lip_405/J_lip_405(31),'g','LineWidth',2); 
title('JF 405 nm light (2024-02-20)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

J_tongue_415 = ieReadSpectra('spd-2024-02-20-415nm-tongue-730mA.mat',waves); figure;  plot(waves,J_tongue_415/J_tongue_415(31),'r','LineWidth',2); hold on;
J_lip_415 = ieReadSpectra('spd-2024-02-20-415nm-lip-730mA.mat',waves); plot(waves,J_lip_415/J_lip_415(31),'g','LineWidth',2); 
title('JF 415 nm light (2024-02-20)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

J_tongue_450 = ieReadSpectra('spd-2024-02-20-450nm-tongue-1250mA.mat',waves); figure;  plot(waves,J_tongue_450/J_tongue_450(31),'r','LineWidth',2); hold on;
J_lip_450 = ieReadSpectra('spd-2024-02-20-450nm-lip-1250mA.mat',waves); plot(waves,J_lip_450/J_lip_450(31),'g','LineWidth',2); 
title('JF 450 nm light (2024-02-20)'); legend('tongue','lip');
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);


cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% measurements of lettuce

cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% 415 excitation light, 450 nm shortpass filter on light
% Measurements made Before and after eating lunch at different intensities
% of excitation light
% also meausurements of D 415 nm excitation at different intensities

