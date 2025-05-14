
% s_TongueLipFluorescenceAtMaxIntensity.m

% Purpose:
%   Figures to accompany the Google Doc titled "Digital Twin Part One:
%   Modeling the Stimulus"


%% make sure these libraries are on your path
cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/;
addpath(genpath(pwd));
ieInit;
waves = 380:5:750;

%% mean tongue reflectance
% Figure to compare tongue fluorescence measurements to predicted
% reflectance
tongue = ieReadSpectra('tongue.mat',waves); 
figure; plot(waves,tongue,'k'); hold on;
meanTongueReflectance = mean(tongue,2);
plot(waves,meanTongueReflectance,'r','LineWidth',2);
title('Tongue Reflectance Measurements')
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Reflectance');	

%% predicted tongue reflectance for 405 nm light at different intensity levels
% 405 nm light with 980mA current
%cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-17 (4 lights noisecheck with tongue test light levels';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-17 (4 lights noisecheck with tongue test light levels';
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_980mA.mat',waves);
predictedTongueReflectance_405nm_980mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_560mA.mat',waves);
predictedTongueReflectance_405nm_560mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_90mA.mat',waves);
predictedTongueReflectance_405nm_90mA = whiteSurface .* meanTongueReflectance;

whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_910mA.mat',waves); 
predictedTongueReflectance_415nm_910mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_460mA.mat',waves); 
predictedTongueReflectance_415nm_460mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_80mA.mat',waves); 
predictedTongueReflectance_415nm_80mA = whiteSurface .* meanTongueReflectance;

whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_870mA.mat',waves); 
predictedTongueReflectance_450nm_870mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_480mA.mat',waves); 
predictedTongueReflectance_450nm_480mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_90mA.mat',waves); 
predictedTongueReflectance_450nm_90mA = whiteSurface .* meanTongueReflectance;


%% Tongue: for each light, plot radiance measured at max intensity (N subjects), along with predicted reflectance
% This will be 3 figures, one for each light, tongue data only since we
% only have reflectance data for tongues
% to plot the data measured with different intensities see
% s_TongueFluorescencewithReflectance.m

% 405 nm light
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
Z_tongue = ieReadSpectra('spd-2024-03-14-Z-405nm_tongue_980mA.mat',waves); 
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements//2024-03-12';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_tongue = ieReadSpectra('spd-2024-03-12-11-405nm-J-tongue-980mA.mat',waves); 
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_tongue = ieReadSpectra('spd-2024-03-19-B_405nm_tongue_980mA.mat',waves); 
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
D_tongue = ieReadSpectra('spd-2024-03-19-D_4050nm_tongue_980mA.mat',waves); 
figure; plot(waves,predictedTongueReflectance_405nm_980mA,'k--','LineWidth',2); hold on;
plot(waves,Z_tongue ,'k','LineWidth',2);
plot(waves,J_tongue ,'k','LineWidth',2);
plot(waves,B_tongue ,'k','LineWidth',2);
plot(waves,D_tongue ,'k','LineWidth',2);
title('Tongue fluorescence (N=4) with 405 nm light');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");

% 415 light
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements//2024-03-14';
Z_tongue = ieReadSpectra('spd-2024-03-14-Z-415nm_Tongue_910mA.mat',waves); 
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements//2024-03-12';
 cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_tongue = ieReadSpectra('spd-2024-03-12-11-415nm-J-tongue-910mA.mat',waves); 
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_tongue = ieReadSpectra('spd-2024-03-19-B_415nm_tongue_910mA.mat',waves); 
D_tongue = ieReadSpectra('spd-2024-03-19-D_415nm_tongue_910mA.mat',waves); 
figure; plot(waves,predictedTongueReflectance_415nm_910mA,'k--','LineWidth',2); hold on;
plot(waves,Z_tongue ,'k','LineWidth',2);
plot(waves,J_tongue ,'k','LineWidth',2);
plot(waves,B_tongue ,'k','LineWidth',2);
plot(waves,D_tongue ,'k','LineWidth',2);
title('Tongue fluorescence (N=4) with 415 nm light');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");

% 450 light
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
Z_tongue = ieReadSpectra('spd-2024-03-14-Z-450nm_tongue_870mA.mat',waves);
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements//2024-03-12';
 cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_tongue = ieReadSpectra('spd-2024-03-12-450nm-J-tongue-460mA-1.mat',waves);
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_tongue = ieReadSpectra('spd-2024-03-19-B_450nm_tongue_870mA.mat',waves); 
D_tongue = ieReadSpectra('spd-2024-03-19-D_450nm_tongue_870mA.mat',waves); 
figure; plot(waves,predictedTongueReflectance_450nm_870mA,'k--','LineWidth',2); hold on;
plot(waves,Z_tongue ,'k','LineWidth',2);
plot(waves,J_tongue ,'k','LineWidth',2);
plot(waves,B_tongue ,'k','LineWidth',2);
plot(waves,D_tongue ,'k','LineWidth',2);
title('Tongue fluorescence (N=4) with 450 nm light');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");

%% Lip  - need to plot same for lip data

%% see s_JoyceTongueLipLunch.m - this replaces below?
% Figure 2 – measurements of tongue/lower lip radiance in one subject before and after lunch
% This will be 2 figures, superimpose the before and after in one plot
% 2 figures because there is tongue and lip

% Purpose: show difference between before and after, as well as effect of
% excitation light intensity, and reduction in fluorescence in multiple
% measurements
 cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% note that the second measurement is less than the first measurement -
% demonstrating decrease with time (quenching or bleaching)
joyceTongue910mA = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R01.mat',waves);	
% joyceTongue910mA_2 = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R02.mat',waves); 
joyceTongue910mA_after = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R01.mat',waves);     
% joyceTongue910mA_2_after = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R02.mat',waves);   
figure; plot(waves,joyceTongue910mA,'k--','LineWidth',2); hold on;
plot(waves,joyceTongue910mA_after ,'k','LineWidth',2); 
title('Tongue fluorescence (JF)');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");
legend('Before lunch', 'After lunch');

% Do the same plot for the lip to show that there is no effect of lunch
joyceLip910mA = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-910mA-R01.mat',waves);      
% joyceLip910mA_2 = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-910mA-R02.mat',waves);    
joyceLip910mA_after = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_910mA-R02.mat',waves);      	
% joyceLip910mA_2_after = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_910mA-R01.mat',waves);       	
figure; plot(waves,joyceLip910mA,'k--','LineWidth',2); hold on;
plot(waves,joyceLip910mA_after ,'k','LineWidth',2); 
title('Lower lip fluorescence (JF)');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");
legend('Before lunch', 'After lunch');

%% Figure 3 
% superimpose measurements of lettuce fluorescence and tongue fluorescence (after lunch) 
% and chlorophyll emissions 
% – normalized so that we can compare the spectral curves
ChlorophyllEmission = ieReadSpectra('ChlorophyllA_emission.mat',waves); 
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% Measurements of lettuce
lettuce = ieReadSpectra('spd-2024-03-19-lettuce1-415nm-1A.mat',waves); 	
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% joyceTongue910mA = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R01.mat',waves);	
% joyceTongue910mA_2 = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R02.mat',waves); 
joyceTongue910mA_after = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R01.mat',waves);     
% joyceTongue910mA_2_after = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R02.mat',waves); 
figure; plot(waves,ChlorophyllEmission,'k--','LineWidth',2); hold on;
plot(waves,lettuce/max(lettuce),'k:','LineWidth',2); hold on; 
plot(waves,joyceTongue910mA_after/max(joyceTongue910mA_after),'k','LineWidth',2);
title('Chlorophyll compared to lettuce and tongue measurements');
xlabel('Wavelength (nm)')
ylabel('Normalized Radiance');
fontsize(gca,14,"pixels");
legend('Chlorophyll', 'Lettuce', 'Tongue after lunch');


