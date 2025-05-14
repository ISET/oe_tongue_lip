
% s_JoyceTongueLipLunch.m

cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /Users/joyce/Github/isetfluorescence;
addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/;
addpath(genpath(pwd));

waves = 350:5:800;

%% Directory for where the data are
% Note that these pathes are different depending on the computer I am on -

cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';

%% Joyce 

% Before lunch - some variability
 J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-80mA-R01.mat',waves); figure; plot(waves,J_tongue,'b','LineWidth',2); hold on;
% J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-80mA-R02.mat',waves);    plot(waves,J_tongue,'b','LineWidth',2); J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-170mA-R01.mat',waves);   plot(waves,J_tongue,'g','LineWidth',2);
J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-170mA-R02.mat',waves);   plot(waves,J_tongue,'g','LineWidth',2);
J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-460mA-R02.mat',waves);   plot(waves,J_tongue,'r','LineWidth',2);
% J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-460mA-R01.mat',waves);   plot(waves,J_tongue,'r','LineWidth',2);	
J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R01.mat',waves);   plot(waves,J_tongue,'k','LineWidth',2);
% J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R02.mat',waves);   plot(waves,J_tongue,'k','LineWidth',2);

J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-80mA-R01.mat',waves);   figure; plot(waves,J_lip,'b','LineWidth',2); hold on;
% J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-80mA-R02.mat',waves);   plot(waves,J_lip,'b','LineWidth',2);
J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-170mA-R01.mat',waves);	plot(waves,J_lip,'g','LineWidth',2);
% J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-170mA-R02.mat',waves);  plot(waves,J_lip,'g','LineWidth',2);	
J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-460mA-R01.mat',waves);  plot(waves,J_lip,'r','LineWidth',2);	
% J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-460mA-R02.mat',waves);  plot(waves,J_lip,'r','LineWidth',2);	
J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-910mA-R01.mat',waves);  plot(waves,J_lip,'k','LineWidth',2);
% J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-910mA-R02.mat',waves);  plot(waves,J_lip,'k','LineWidth',2);

% title('Joyce');
% fontsize(gca,16,"pixels");
% xlabel('wavelength (nm');
% ylabel('Radiance (energy)');	
% xlim([400 800]);

% After lunch
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_80mA-R01.mat',waves); figure; plot(waves,J_tongue,'b','LineWidth',2); hold on;
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_80mA-R02.mat',waves);    plot(waves,J_tongue,'b','LineWidth',2);
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_170mA-R01.mat',waves);    plot(waves,J_tongue,'g','LineWidth',2);	
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_170mA-R02.mat',waves);    plot(waves,J_tongue,'g','LineWidth',2);	
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_460mA-R01.mat',waves);    plot(waves,J_tongue,'r','LineWidth',2);	
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_460mA-R02.mat',waves);    plot(waves,J_tongue,'r','LineWidth',2);	
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R01.mat',waves);    plot(waves,J_tongue,'k','LineWidth',2);
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R02.mat',waves);    plot(waves,J_tongue,'k','LineWidth',2);

J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_80mA-R01.mat',waves);   figure; plot(waves,J_lip,'b','LineWidth',2); hold on;
% J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_80mA-R02.mat',waves);   plot(waves,J_lip,'b','LineWidth',2);
J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_170mA-R02.mat',waves);   plot(waves,J_lip,'g','LineWidth',2);	
% J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_170mA-R01.mat',waves);   plot(waves,J_lip,'g','LineWidth',2);	
J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_460mA-R02.mat',waves);   plot(waves,J_lip,'r','LineWidth',2);	
%J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_460mA-R01.mat',waves);   plot(waves,J_lip,'r','LineWidth',2);	
J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_910mA-R01.mat',waves);   plot(waves,J_lip,'k','LineWidth',2);
% J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_910mA-R02.mat',waves);   plot(waves,J_lip,'k','LineWidth',2);

% title('Joyce');
% fontsize(gca,16,"pixels");
% xlabel('wavelength (nm');
% ylabel('Radiance (energy)');	
% xlim([400 800]);