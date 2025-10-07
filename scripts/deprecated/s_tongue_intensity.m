% s_tongue_intensity.m

%   Demonstrate that we are measuring fluorescence in two ways
%   1. compare with light reflected from white surface * tongue reflectance
%   2. show that fluorescence increases with light intensity - 


% ALERT: we do not have the measurement of reflected light for the 170 mA case. 
% Do we measure the lights again in order to get this data or just not plot the 170 mA radiance measurements?

%%
cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));

ieInit;
waves = 380:5:750;


%% Predicted Reflectance
% We measured how much of the LED light passed through the 475 nm placed on
% the spectrophotometer and then multiplied it with tongue reflectance
tongue = ieReadSpectra('tongue.mat',waves); 
figure; plot(waves,tongue,'k'); hold on;
meanTongueReflectance = mean(tongue,2);
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_80mA.mat',waves); 
predictedTongueReflectance_415nm_80mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_460mA.mat',waves); 
predictedTongueReflectance_415nm_460mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_910mA.mat',waves); 
predictedTongueReflectance_415nm_910mA = whiteSurface .* meanTongueReflectance;

%% Tongue radiance at 4 levels: 80, 170, 460, 910 mA
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-80mA-R01.mat',waves);     figure; plot(waves,Z_tongue,'k:','LineWidth',2); hold on;
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-170mA-R01.mat',waves);	plot(waves,Z_tongue,'k-.','LineWidth',2); hold on;
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-460mA-R01.mat',waves);	plot(waves,Z_tongue,'k--','LineWidth',2); hold on;
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-910mA-R01.mat',waves);    plot(waves,Z_tongue,'k','LineWidth',2); hold on;  
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title ('ZL');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

% Brian  
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-80mA-R01.mat',waves);figure; plot(waves,B_tongue,'k:','LineWidth',2); hold on;
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-170mA-R01.mat',waves);    plot(waves,B_tongue,'k-.','LineWidth',2); hold on;	
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-460mA-R02.mat',waves);    plot(waves,B_tongue','k--','LineWidth',2); hold on;
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat',waves);    plot(waves,B_tongue,'k','LineWidth',2); hold on;
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title('BW');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

% Doug 
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_80mA-R01.mat',waves); figure; plot(waves,D_tongue,'k:','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_170mA-R01.mat',waves); plot(waves,D_tongue,'k-.','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_460mA-R02.mat',waves); plot(waves,D_tongue,'k--','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_910mA-R01.mat',waves); plot(waves,D_tongue,'k','LineWidth',2); hold on; 
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title('DW');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

%% Joyce 
% Before lunch (tongue 415 at different intensities)
J_tongue = ieReadSpectra('spd-2024-03-08-J-tongue-415nm450spf-80mA-R01.mat',waves); figure; plot(waves,J_tongue,'k:','LineWidth',2); hold on;
J_tongue = ieReadSpectra('spd-2024-03-08-J-tongue-415nm450spf-170mA-R01.mat',waves);    plot(waves,J_tongue,'k-.','LineWidth',2); hold on;	
J_tongue = ieReadSpectra('spd-2024-03-08-J-tongue-415nm450spf-460mA-R01.mat',waves);    plot(waves,J_tongue,'k--','LineWidth',2); hold on;		
J_tongue = ieReadSpectra('spd-2024-03-08-J-tongue-415nm450spf-910mA-R01.mat',waves);    plot(waves,J_tongue,'k','LineWidth',2);
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title('JF');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

