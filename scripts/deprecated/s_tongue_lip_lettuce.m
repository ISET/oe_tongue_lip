% s_tongue_lip_lettuce.m
% 
% Purpose: plot measurements taken before and after lunch to show effect of eating lettuce
% Here is the data plotted before and after lunch to show effect of
% lettuce

%% make sure these libraries are on your path
cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));

ieInit;
waves = 380:5:750;

%% 
% Before
%   note that the second measurement is less than the first measurement -
%   demonstrating decrease with time (quenching or bleaching)
joyceTongue910mA = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R01.mat',waves);	
% joyceTongue910mA_2 = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R02.mat',waves);  

% After
joyceTongue910mA_after = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R01.mat',waves);     
% joyceTongue910mA_2_after = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R02.mat',waves);   

figure; plot(waves,joyceTongue910mA,'k--','LineWidth',2); hold on;
plot(waves,joyceTongue910mA_after ,'k','LineWidth',2); 
title('Tongue fluorescence (JF)');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");
legend('Before lunch', 'After lunch');

%% Do the same plot for the lip to show that there is no effect of lunch
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

%% superimpose measurements of lettuce fluorescence and tongue fluorescence (after lunch) 
% and chlorophyll emissions 
% – normalized so that we can compare the spectral curves
ChlorophyllEmission = ieReadSpectra('ChlorophyllA_emission.mat',waves); 
% Measurements of lettuce
lettuce = ieReadSpectra('spd-2024-03-19-lettuce1-415nm-1A.mat',waves); 	
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