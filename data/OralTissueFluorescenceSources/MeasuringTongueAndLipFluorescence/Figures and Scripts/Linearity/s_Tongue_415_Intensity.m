
% s_Tongue415Intensity.m

%   Demonstrate that we are measuring fluorescence in two ways
%   1. compare with light reflected from white surface * tongue reflectance
%   2. show that fluorescence increases with light intensity - 


% ALERT: we do not have the measurement of reflected light for the 170 mA
% case. Do we measure the lights again in order to get this data or just
% not plot the 170 mA radiance measurements?
% or perhaps plot the predicted Radiance for the most light 
% noting that predicted reflectance increases with intensity of the
% light, but we only plot the case for the most intensity light in this
% graph



%%
cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /Users/joyce/Github/isetfluorescence;
addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/;
addpath(genpath(pwd));

waves = 350:5:800;

%% Predicted Reflectance
% add that to every plot
% mean tongue reflectance
tongue = ieReadSpectra('tongue.mat',waves); 
figure; plot(waves,tongue,'k'); hold on;
meanTongueReflectance = mean(tongue,2);
plot(waves,meanTongueReflectance,'r','LineWidth',2);
title('Tongue Reflectance Measurements')
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Reflectance');	
% predicted tongue reflectance at different intensity levels
% for 415 nm at different intensities
%cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-17 (4 lights noisecheck with tongue test light levels';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-17 (4 lights noisecheck with tongue test light levels';
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_80mA.mat',waves); 
predictedTongueReflectance_415nm_80mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_460mA.mat',waves); 
predictedTongueReflectance_415nm_460mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_910mA.mat',waves); 
predictedTongueReflectance_415nm_910mA = whiteSurface .* meanTongueReflectance;

%% Tongue radiance at 4 levels: 80, 170, 460, 910 mA
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (415nm Tongue+lip measurements';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (415nm Tongue+lip measurements';
% Zhenyi 
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-80mA-R01.mat',waves); figure; plot(waves,Z_tongue,'k:','LineWidth',2); hold on;
% Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-80mA-R02.mat',waves);     plot(waves,Z_tongue,'b','LineWidth',2); hold on;
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-170mA-R01.mat',waves);	plot(waves,Z_tongue,'k-.','LineWidth',2); hold on;
% Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-170mA-R02.mat',waves);	plot(waves,Z_tongue,'g','LineWidth',2); hold on;
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-460mA-R01.mat',waves);	plot(waves,Z_tongue,'k--','LineWidth',2); hold on;
% Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-460mA-R02.mat',waves);	plot(waves,Z_tongue,'r','LineWidth',2); hold on;
% two successive measurements are very different
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-910mA-R01.mat',waves);    plot(waves,Z_tongue,'k','LineWidth',2); hold on; 
% Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-910mA-R02.mat',waves);    plot(waves,Z_tongue,'k','LineWidth',2); hold on;
% plot predicted Reflectance at 4 different levels (we are missing 170 mA)
% plot(waves,predictedTongueReflectance_415nm_80mA,'b--','LineWidth',2); 
% plot(waves,predictedTongueReflectance_415nm_460mA ,'g--','LineWidth',2); 
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title ('ZL');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

% Brian  
 %tongue  pretty good agreement on successive measurements
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-80mA-R01.mat',waves);figure; plot(waves,B_tongue,'k:','LineWidth',2); hold on;
% B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-80mA-R02.mat',waves);     plot(waves,B_tongue,'b','LineWidth',2); hold on;
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-170mA-R01.mat',waves);    plot(waves,B_tongue,'k-.','LineWidth',2); hold on;	
% B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-170mA-R02.mat',waves);    plot(waves,B_tongue,'g','LineWidth',2); hold on;	
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-460mA-R02.mat',waves);    plot(waves,B_tongue','k--','LineWidth',2); hold on;
% B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-460mA-R01.mat',waves);    plot(waves,B_tongue,'r','LineWidth',2); hold on;	
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat',waves);    plot(waves,B_tongue,'k','LineWidth',2); hold on;
% B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-910mA-R02.mat',waves);    plot(waves,B_tongue,'k','LineWidth',2); hold on;
% plot predicted Reflectance at 4 different levels (we are missing 170 mA)
% plot(waves,predictedTongueReflectance_415nm_80mA,'b--','LineWidth',2); 
% plot(waves,predictedTongueReflectance_415nm_460mA ,'g--','LineWidth',2); 
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title ('ZL');
title('BW');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

% Doug 
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_80mA-R01.mat',waves); figure; plot(waves,D_tongue,'k:','LineWidth',2); hold on;
% D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_80mA-R02.mat',waves); plot(waves,D_tongue,'b','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_170mA-R01.mat',waves); plot(waves,D_tongue,'k-.','LineWidth',2); hold on;
% D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_170mA-R02.mat',waves); plot(waves,D_tongue,'g','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_460mA-R02.mat',waves); plot(waves,D_tongue,'k--','LineWidth',2); hold on;
% D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_460mA-R01.mat',waves); plot(waves,D_tongue,'r','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_910mA-R01.mat',waves); plot(waves,D_tongue,'k','LineWidth',2); hold on;
% D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_910mA-R02.mat',waves); plot(waves,D_tongue,'k','LineWidth',2); hold on;
% plot predicted Reflectance at 4 different levels (we are missing 170 mA)
% plot(waves,predictedTongueReflectance_415nm_80mA,'b--','LineWidth',2); 
% plot(waves,predictedTongueReflectance_415nm_460mA ,'g--','LineWidth',2); 
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title ('ZL');
title('DW');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

%% Joyce 

% After lunch
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_80mA-R01.mat',waves); figure; plot(waves,J_tongue,'k:','LineWidth',2); hold on;
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_80mA-R02.mat',waves);    plot(waves,J_tongue,'b','LineWidth',2);
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_170mA-R01.mat',waves);    plot(waves,J_tongue,'k-.','LineWidth',2); hold on;	
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_170mA-R02.mat',waves);    plot(waves,J_tongue,'g','LineWidth',2);	
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_460mA-R01.mat',waves);    plot(waves,J_tongue,'k--','LineWidth',2); hold on;	
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_460mA-R02.mat',waves);    plot(waves,J_tongue,'r','LineWidth',2);	
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R01.mat',waves);    plot(waves,J_tongue,'k','LineWidth',2);
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R02.mat',waves);    plot(waves,J_tongue,'k','LineWidth',2);
% % plot predicted Reflectance at 4 different levels (we are missing 170 mA)
% plot(waves,predictedTongueReflectance_415nm_80mA,'b--','LineWidth',2); 
% plot(waves,predictedTongueReflectance_415nm_460mA ,'g--','LineWidth',2); 
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title ('ZL');
title('JF');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);


