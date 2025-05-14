%  s_Normalized_lip_tongue_3lights_maxIntensity_4subjects.m

% Purpose: Compare tongue and lip fluorescence 
% %         each plot compares measurements of 4 subjects 
%           measurements obtaine at max excitation light intensity and
%           normalized by dividing by amplitude at 475 nm
%           separate plots for 3 different excitation light for tongue and
%           lip

cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/;
addpath(genpath(pwd));
ieInit;
waves = 380:5:750;

%% TODO plot these and decide which data to use - for some subjects, measurements were made on multiple days
% for example, do I use the "before lunch" measurements for Joyce
% and then do a separate figure for before, after, lettuce and chlorophyll
% measurements?

%% tongue 405
%  Brian
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_tongue_405 = ieReadSpectra('spd-2024-03-19-B_405nm_lip_980mA.mat',waves);
%  Doug
D_tongue_405 = ieReadSpectra('spd-2024-03-19-D_4050nm_tongue_980mA.mat',waves);
% Zhenyi
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
%cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
Z_tongue_405 = ieReadSpectra('spd-2024-03-14-Z-405nm_tongue_980mA.mat',waves); 
%  Joyce
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements//2024-03-12';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_tongue_405 = ieReadSpectra('spd-2024-03-12-11-405nm-J-tongue-980mA.mat',waves); 

%% tongue 415
%  Brian    
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
 % cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_tongue_415 = ieReadSpectra('spd-2024-03-19-B_415nm_lip_910mA.mat',waves);
%  Doug
D_tongue_415 = ieReadSpectra('spd-2024-03-19-D_415nm_tongue_910mA.mat',waves); 
% Zhenyi
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
Z_tongue_415 = ieReadSpectra('spd-2024-03-14-Z-415nm_Tongue_910mA.mat',waves);
%  Joyce
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements//2024-03-12';
 cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_tongue_415 = ieReadSpectra('spd-2024-03-12-11-415nm-J-tongue-910mA.mat',waves); 

%% tongue 450
%  Brian    
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
 % cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_tongue_450 = ieReadSpectra('spd-2024-03-19-B_450nm_tongue_870mA.mat',waves);
%  Doug
D_tongue_450 = ieReadSpectra('spd-2024-03-19-D_450nm_tongue_870mA.mat',waves);
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
%cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
Z_tongue_450 = ieReadSpectra('spd-2024-03-14-Z-450nm_tongue_870mA.mat',waves);;
%  Joyce
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements//2024-03-12';
 cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_tongue_450 = ieReadSpectra('spd-2024-03-12-450nm-J-tongue-460mA-1.mat',waves);

%% lip 405
%  Brian    
 cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_lip_405 = ieReadSpectra('spd-2024-03-19-B_405nm_lip_980mA.mat',waves);
%  Doug
D_lip_405 = ieReadSpectra('spd-2024-03-19-D_4050nm_lip_980mA.mat',waves);
% Zhenyi
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
Z_lip_405 = ieReadSpectra('spd-2024-03-14-Z-405nm_lip_980mA.mat',waves);
%  Joyce
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_lip_405 = ieReadSpectra('spd-2024-03-12-11-405nm-J-lip-980mA.mat',waves);

%% lip 415
%  Brian    
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_lip_415 = ieReadSpectra('spd-2024-03-19-B_415nm_lip_910mA.mat',waves);
%  Doug
D_lip_415 = ieReadSpectra('spd-2024-03-19-D_415nm_lip_910mA.mat',waves);
% Zhenyi
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
%cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
Z_lip_415 = ieReadSpectra('spd-2024-03-14-Z-415nm_lip_910mA.mat',waves);
%  Joyce
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
%cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_lip_415 = ieReadSpectra('spd-2024-03-12-11-415nm-J-lip-910mA.mat',waves);

%% lip 450
%  Brian    
 cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
 % cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-19';
B_lip_450 = ieReadSpectra('spd-2024-03-19-B_450nm_lip_870mA.mat',waves);
%  Doug
D_lip_450 = ieReadSpectra('spd-2024-03-19-D_450nm_lip_870mA.mat',waves);
% Zhenyi
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
%cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-14';
Z_lip_450 = ieReadSpectra('spd-2024-03-14-Z-450nm_lip_870mA.mat',waves);
%  Joyce
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-12';
J_lip_450 = ieReadSpectra('spd-2024-03-12-11-450nm-J-lip-870mA.mat',waves);

%% Plotting the normalized data
% all should have ymin of 0 and ymax of 3.5 so we can compare scale?

figure; plot(waves,B_tongue_405/B_tongue_405(20),'k--x','LineWidth',1); hold on;
plot(waves,D_tongue_405/D_tongue_405(20),'k--*','LineWidth',1);
plot(waves,Z_tongue_405/Z_tongue_405(20),'k--^','LineWidth',1);
plot(waves,J_tongue_405/J_tongue_405(20),'k--o','LineWidth',1);
title("Dorsal tongue: 405 nm")
ylim([0 3.5]);
xlabel('Wavelength (nm)')
ylabel('Normalized Radiance'); % do we put arbitrary units?
fontsize(gca,14,"pixels");

figure; plot(waves,B_tongue_415/B_tongue_415(20),'k--x','LineWidth',1); hold on;
plot(waves,D_tongue_415/D_tongue_415(20),'k--*','LineWidth',1);
plot(waves,Z_tongue_415/Z_tongue_415(20),'k--^','LineWidth',1);
plot(waves,J_tongue_415/J_tongue_415(20),'k--o','LineWidth',1);
title("Dorsal tongue: 415 nm")
ylim([0 3.5]);
xlabel('Wavelength (nm)')
ylabel('Normalized Radiance'); % do we put arbitrary units?
fontsize(gca,14,"pixels");

figure; plot(waves,B_tongue_450/B_tongue_450(20),'k--x','LineWidth',1); hold on;
plot(waves,D_tongue_450/D_tongue_450(20),'k--*','LineWidth',1);
plot(waves,Z_tongue_450/Z_tongue_450(20),'k--^','LineWidth',1);
plot(waves,J_tongue_450/J_tongue_450(20),'k--o','LineWidth',1);
title("Dorsal tongue: 450 nm")
ylim([0 3.5]);
xlabel('Wavelength (nm)')
ylabel('Normalized Radiance'); % do we put arbitrary units?
fontsize(gca,14,"pixels");

figure; plot(waves,B_lip_405/B_lip_405(20),'k--x','LineWidth',1); hold on;
plot(waves,D_lip_405/D_lip_405(20),'k--*','LineWidth',1);
plot(waves,Z_lip_405/Z_lip_405(20),'k--^','LineWidth',1);
plot(waves,J_lip_405/J_lip_405(20),'k--o','LineWidth',1);
title("Inner lower lip: 405 nm")
ylim([0 3.5]);
xlabel('Wavelength (nm)')
ylabel('Normalized Radiance'); % do we put arbitrary units?
fontsize(gca,14,"pixels");

figure; plot(waves,B_lip_415/B_lip_415(20),'k--x','LineWidth',1); hold on;
plot(waves,D_lip_415/D_lip_415(20),'k--*','LineWidth',1);
plot(waves,Z_lip_415/Z_lip_415(20),'k--^','LineWidth',1);
plot(waves,J_lip_415/J_lip_415(20),'k--o','LineWidth',1);;
title("Inner lower lip: 415 nm")
ylim([0 3.5]);
xlabel('Wavelength (nm)')
ylabel('Normalized Radiance'); % do we put arbitrary units?
fontsize(gca,14,"pixels");

figure; plot(waves,B_lip_450/B_lip_450(20),'k--x','LineWidth',1);; hold on;
plot(waves,D_lip_450/D_lip_450(20),'k--*','LineWidth',1);
plot(waves,Z_lip_450/Z_lip_450(20),'k--^','LineWidth',1);
plot(waves,J_lip_450/J_lip_450(20),'k--o','LineWidth',1);
title("Inner lower lip: 450 nm")
ylim([0 3.5]);
xlabel('Wavelength (nm)')
ylabel('Normalized Radiance'); % do we put arbitrary units?
fontsize(gca,14,"pixels");

%%

% should have made these measurements at 405

 cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% note that the second measurement is less than the first measurement -
% demonstrating decrease with time (quenching or bleaching)
J_tongue_415 = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R01.mat',waves);	
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