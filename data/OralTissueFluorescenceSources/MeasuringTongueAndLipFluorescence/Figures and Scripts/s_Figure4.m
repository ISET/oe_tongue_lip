%  s_compareSubjects.m

% Description: To compare the spectral shape of tissue autofluorescence
% across 4 different subjects, we normalized the measurements by dividing
% by the radiance measured at K nm. (where K = 475 or 500)

cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));

ieInit;
waves = 380:5:750;

%% tongue 405
B_tongue_405 = ieReadSpectra('spd-2024-03-19-B_405nm_lip_980mA.mat',waves);
D_tongue_405 = ieReadSpectra('spd-2024-03-19-D_4050nm_tongue_980mA.mat',waves);
Z_tongue_405 = ieReadSpectra('spd-2024-03-14-Z-405nm_tongue_980mA.mat',waves); 
J_tongue_405 = ieReadSpectra('spd-2024-03-12-11-405nm-J-tongue-980mA.mat',waves); 

%% tongue 415
B_tongue_415 = ieReadSpectra('spd-2024-03-19-B_415nm_lip_910mA.mat',waves);
D_tongue_415 = ieReadSpectra('spd-2024-03-19-D_415nm_tongue_910mA.mat',waves); 
Z_tongue_415 = ieReadSpectra('spd-2024-03-14-Z-415nm_Tongue_910mA.mat',waves);
J_tongue_415 = ieReadSpectra('spd-2024-03-12-11-415nm-J-tongue-910mA.mat',waves); 

%% tongue 450
B_tongue_450 = ieReadSpectra('spd-2024-03-19-B_450nm_tongue_870mA.mat',waves);
D_tongue_450 = ieReadSpectra('spd-2024-03-19-D_450nm_tongue_870mA.mat',waves);
Z_tongue_450 = ieReadSpectra('spd-2024-03-14-Z-450nm_tongue_870mA.mat',waves);;
J_tongue_450 = ieReadSpectra('spd-2024-03-12-450nm-J-tongue-460mA-1.mat',waves);

%% lip 405
B_lip_405 = ieReadSpectra('spd-2024-03-19-B_405nm_lip_980mA.mat',waves);
D_lip_405 = ieReadSpectra('spd-2024-03-19-D_4050nm_lip_980mA.mat',waves);
Z_lip_405 = ieReadSpectra('spd-2024-03-14-Z-405nm_lip_980mA.mat',waves);
J_lip_405 = ieReadSpectra('spd-2024-03-12-11-405nm-J-lip-980mA.mat',waves);

%% lip 415
B_lip_415 = ieReadSpectra('spd-2024-03-19-B_415nm_lip_910mA.mat',waves);
D_lip_415 = ieReadSpectra('spd-2024-03-19-D_415nm_lip_910mA.mat',waves);
Z_lip_415 = ieReadSpectra('spd-2024-03-14-Z-415nm_lip_910mA.mat',waves);
J_lip_415 = ieReadSpectra('spd-2024-03-12-11-415nm-J-lip-910mA.mat',waves);

%% lip 450
B_lip_450 = ieReadSpectra('spd-2024-03-19-B_450nm_lip_870mA.mat',waves);
D_lip_450 = ieReadSpectra('spd-2024-03-19-D_450nm_lip_870mA.mat',waves);
Z_lip_450 = ieReadSpectra('spd-2024-03-14-Z-450nm_lip_870mA.mat',waves);
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

