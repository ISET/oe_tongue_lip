
%  s_Figure5.m

% Description: To compare spectral measurements of tongue and lip
% autofluorescence before and after lunch 
% We also use the measurements made with max current (910mA)
% We see that there are no porphyrins measured on lower lip
% In Figure 4 we normalized so that we can compare across different
% subjects
% we do not normlize these data, but it is important to point out that the
% we should ignore intensity differences at each wavelength and only
% compare shape because we did not select the same location on the tongue
% and lip before and after lunch

% Questions: 
% 1. For the paper, should we repeat these measurements at 405 since this is best excitation
% wavelength? We made these at 415 nm because that is the light we are
% using in the prototype

%% Initialize
cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/;
addpath(genpath(pwd));
ieInit;
waves = 380:5:750;

%%
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

