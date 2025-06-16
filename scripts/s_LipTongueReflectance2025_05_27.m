%% s_LipTongueReflectance2025_05_27
%
% Calculate the tongue and lip reflectances from the raw data.
% data collected on 2025-05-27
%
% Missing ZL data.  When he comes up here we can ask for a measurement.

%%
ieInit;
wave = 380:5:750;
subjects = oeSubjects;

%% S2:  data collected on 2025-05-27

S2WhiteRef = zeros(length(wave),3);
S2WhiteRef(:,1) = ieReadSpectra('S2LightCalibration-R01.mat', wave); 
S2WhiteRef(:,2) = ieReadSpectra('S2LightCalibration-R02.mat', wave); 
S2WhiteRef(:,3) = ieReadSpectra('S2LightCalibration-R03.mat', wave); 

S2_tongue = zeros(length(wave),3);
S2_tongue(:,1) = ieReadSpectra('S2Tongue1-R01.mat', wave); 
S2_tongue(:,2) = ieReadSpectra('S2Tongue1-R02.mat', wave); 
S2_tongue(:,3) = ieReadSpectra('S2Tongue1-R03.mat', wave); 
S2_tongueReflectance = mean(S2_tongue,2) ./ mean(S2WhiteRef,2);
% ieFigure; plot(wave,B_tongue);
% plotReflectance(wave,S2_tongueReflectance);

S2_lip = zeros(length(wave),4);
% use the last two measurements
S2_lip(:,1) = ieReadSpectra('S2Li21-R01-R01-R01.mat', wave); 
S2_lip(:,2) = ieReadSpectra('S2Li21-R01-R01-R02.mat', wave); 
S2_lip(:,3) = ieReadSpectra('S2Lip1-R01-R01.mat', wave); 
S2_lip(:,4) = ieReadSpectra('S2Lip1-R01-R02.mat', wave); 
S2_lipReflectance = mean(S2_lip,2) ./ mean(S2WhiteRef,2);
% ieFigure; plot(wave,S2_lip); hold on;
% plotReflectance(wave,S2_lipReflectance);

%% S4:  data collected on 2025-05-27

S4WhiteRef = zeros(length(wave),3);
S4WhiteRef(:,1) = ieReadSpectra('S4-light-calibration-R01.mat', wave); 	
S4WhiteRef(:,2) = ieReadSpectra('S4-light-calibration-R02.mat', wave); 
S4WhiteRef(:,3) = ieReadSpectra('S4-light-calibration-R03.mat', wave); 

S4_tongue = zeros(length(wave),2);	
% We moved the light, so only consider the last 2 measurements
% J_tongue(:,1) = ieReadSpectra('S4-tongue-1-R01.mat', wave); 
%   ieFigure; plot(wave,J_tongue);hold on;
%    J_tongue(:,2) = ieReadSpectra('S4-tongue-1-R02.mat', wave);plot(wave,J_tongue);
%   J_tongue(:,1) = ieReadSpectra('S4-tongue-2-R01.mat', wave); 	plot(wave,J_tongue);
%   J_tongue(:,2) = ieReadSpectra('S4-tongue-2-R02.mat', wave);plot(wave,J_tongue);
S4_tongue(:,1) = ieReadSpectra('S4-tongue-2-R01-R01.mat', wave); plot(wave,S4_tongue,'k');
S4_tongue(:,2) = ieReadSpectra('S4-tongue-2-R01-R02.mat', wave); plot(wave,S4_tongue,'k');
% ieFigure; plot(wave,S4_tongue);
S4_tongueReflectance = mean(S4_tongue,2) ./ mean(S4WhiteRef,2);

S4_lip = zeros(length(wave),2);
S4_lip(:,1) = ieReadSpectra('S4-lip-1-R01.mat', wave); 
S4_lip(:,2) = ieReadSpectra('S4-lip-1-R02.mat', wave);
% ieFigure; plot(wave,S4_lip);
S4_lipReflectance = mean(S4_lip,2) ./ mean(S4WhiteRef,2);

%% S3:  data collected on 2025-06-03

S3WhiteRef = zeros(length(wave),3);
S3WhiteRef(:,1) = ieReadSpectra('spd-2025-06-03-LightCalibrationS3-R01', wave); 	
S3WhiteRef(:,2) = ieReadSpectra('spd-2025-06-03-LightCalibrationS3-R02', wave); 
S3WhiteRef(:,3) = ieReadSpectra('spd-2025-06-03-LightCalibrationS3-R03', wave); 

S3_tongue = zeros(length(wave),2);	
S3_tongue(:,1) = ieReadSpectra('spd-2025-06-03-TongueS3-R01', wave);
S3_tongue(:,2) = ieReadSpectra('spd-2025-06-03-TongueS3-R02', wave);
S3_tongue(:,3) = ieReadSpectra('spd-2025-06-03-TongueS3-R03', wave);

S3_tongueReflectance = mean(S3_tongue,2) ./ mean(S3WhiteRef,2);

S3_lip = zeros(length(wave),2);
S3_lip(:,1) = ieReadSpectra('spd-2025-06-03-LipS3-R01', wave); 
S3_lip(:,2) = ieReadSpectra('spd-2025-06-03-LipS3-R02', wave);
S3_lip(:,4) = ieReadSpectra('spd-2025-06-03-LipS3-R03', wave);

S3_lipReflectance = mean(S3_lip,2) ./ mean(S3WhiteRef,2);

%% Plot the tongue lip reflectances
ieFigure;
plot(wave,S2_tongueReflectance,'k-'); hold on;
plot(wave,S3_tongueReflectance,'k-');
plot(wave,S4_tongueReflectance,'k-');

plot(wave,S2_lipReflectance,'k--'); hold on;
plot(wave,S3_lipReflectance,'k--');
plot(wave,S4_lipReflectance,'k--');
grid on; xlabel('Wavelength (nm)'); ylabel('Reflectance');
set(gca,'ylim',[0 1]);

%% Compare the tongue data to data I collected in 2019
tongue = ieReadSpectra('tongue.mat',wave);
plot(wave,tongue,'r-');

%% To save, run this code

%{
%% Tongue
comment = 'mean tongue reflectance calculated from data measured on 2025-05-27 and 2025-06-03';

fname = fullfile(oeTongueLipRootPath,'data','Reflectance','S4','tongueReflectance.mat');
ieSaveSpectralFile(wave,S4_tongueReflectance,comment,fname)

fname = fullfile(oeTongueLipRootPath,'data','Reflectance','S3','tongueReflectance.mat');
ieSaveSpectralFile(wave,S3_tongueReflectance,comment,fname);

fname = fullfile(oeTongueLipRootPath,'data','Reflectance','S2','tongueReflectance.mat');
ieSaveSpectralFile(wave,S2_tongueReflectance,comment,fname);

%% Lip
comment = 'mean lip reflectance calculated from data measured on 2025-05-27 and 2025-06-03';

fname = fullfile(oeTongueLipRootPath,'data','Reflectance','S4','lipReflectance.mat');
ieSaveSpectralFile(wave,S4_lipReflectance,comment,fname);

fname = fullfile(oeTongueLipRootPath,'data','Reflectance','S3','lipReflectance.mat');
ieSaveSpectralFile(wave,S3_lipReflectance,comment,fname);

fname = fullfile(oeTongueLipRootPath,'data','Reflectance','S2','lipReflectance.mat');
ieSaveSpectralFile(wave,S2_lipReflectance,comment,fname);

%}