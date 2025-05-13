s_selectingData.m 
%% make sure these libraries are on your path
%{
cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));
%}

% We are showing examples of weighted sums of collagen, elastin, keratin
% and FAD.  For the lip, keratin would be zero.
%
dataDir = fullfile(oeTongueLipRootPath,'data','RawTongueLip');

ieNewGraphWin;
wave = 490:5:720;
% normalize by dividing by amplitude at 490 nm


%% Data collected on same days (3/07 and 3/08) for 415 nm excitation light, Tongue and lip

% lip
ieNewGraphWin;
fname = 'spd-2024-03-07-B-lip-415nm450SPF-910mA-R01.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2); hold on;
fname = 'spd-2024-03-07-Z-lip-415nm450SPF-910mA-R01.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-08-D-lip-415nm450spf_910mA-R01.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-08-J-lip-415nm450spf-910mA-R01.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
legend('B','Z','D','J');
title('Lip with 415 nm excitation (3-07, 3-08');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

% tongue
ieNewGraphWin;
fname = 'spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2); hold on;
fname = 'spd-2024-03-07-Z-Tongue-415nm450SPF-910mA-R01.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-08-D-tongue-415nm450spf_910mA-R01.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-08-J-415nm450spf-910mA-R01.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
title('Tongue with 415 nm excitation (3-07, 3-08)');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');
%% Data collected on different days

% lip 405
ieNewGraphWin;
fname = 'spd-2024-03-19-B_405nm_lip_980mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2); hold on;
fname = 'spd-2024-03-19-D_4050nm_lip_980mA.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);;plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-14-Z-405nm_lip_980mA.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-12-11-405nm-J-lip-980mA.mat';[data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
legend('B','D','Z','J');
title('Lip with 405 nm excitation (3-19, 3-14, 3-12)');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

% tongue 405
ieNewGraphWin;
fname = 'spd-2024-03-19-B_405nm_tongue_980mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2); hold on;
fname = 'spd-2024-03-19-D_4050nm_tongue_980mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-14-Z-405nm_tongue_980mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-12-11-405nm-J-tongue-980mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
legend('B','D','Z','J');
title('Tongue with 405 nm excitation (3-19, 3-14, 3-12)');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

% lip 415
ieNewGraphWin;
fname = 'spd-2024-03-19-B_415nm_lip_910mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2); hold on;
fname = 'spd-2024-03-19-D_415nm_lip_910mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-14-Z-415nm_lip_910mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-12-11-415nm-J-lip-910mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
legend('B','D','Z','J');
title('Lip with 415 nm excitation (3-19, 3-14, 3-12)');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

% tongue 415
ieNewGraphWin;
fname = 'spd-2024-03-19-B_415nm_tongue_910mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2); hold on;
fname = 'spd-2024-03-19-D_415nm_tongue_910mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-14-Z-415nm_Tongue_910mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-12-11-415nm-J-tongue-910mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
title('Tongue with 415 nm excitation (3-19, 3-14, 3-12)');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

% lip 450
ieNewGraphWin;
fname = 'spd-2024-03-19-B_450nm_lip_870mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2); hold on;
fname = 'spd-2024-03-19-D_450nm_lip_870mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-14-Z-450nm_lip_870mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-12-11-450nm-J-lip-870mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
legend('B','D','Z','J');
title('Lip with 450 nm excitation (3-19, 3-14, 3-12)');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

% tongue 450
ieNewGraphWin;
fname = 'spd-2024-03-19-B_450nm_tongue_870mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2); hold on;
fname = 'spd-2024-03-19-D_450nm_tongue_870mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-14-Z-450nm_tongue_870mA.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);
fname = 'spd-2024-03-12-450nm-J-tongue-460mA-1.mat'; [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);plot(wave,data/data(1),'LineWidth',2);  % no data for 870 
legend('B','D','Z','J (460 mA');
title('Tongue with 450 nm excitation (3-19, 3-14, 3-12)');
set(gca,'fontsize',16);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');
