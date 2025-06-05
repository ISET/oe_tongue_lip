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

%% BW:  data collected on 2025-05-27

BwhiteRef = zeros(length(wave),3);
BwhiteRef(:,1) = ieReadSpectra('BrianLightCalibration-R01.mat', wave); 
BwhiteRef(:,2) = ieReadSpectra('BrianLightCalibration-R02.mat', wave); 
BwhiteRef(:,3) = ieReadSpectra('BrianLightCalibration-R03.mat', wave); 

B_tongue = zeros(length(wave),3);
B_tongue(:,1) = ieReadSpectra('BrianTongue1-R01.mat', wave); 
B_tongue(:,2) = ieReadSpectra('BrianTongue1-R02.mat', wave); 
B_tongue(:,3) = ieReadSpectra('BrianTongue1-R03.mat', wave); 
S2_tongueReflectance = mean(B_tongue,2) ./ mean(BwhiteRef,2);
% ieFigure; plot(wave,B_tongue);
% plotReflectance(wave,S3_tongueReflectance);

B_lip = zeros(length(wave),4);
% use the last two measurements
B_lip(:,1) = ieReadSpectra('BrianLi21-R01-R01-R01.mat', wave); 
B_lip(:,2) = ieReadSpectra('BrianLi21-R01-R01-R02.mat', wave); 
B_lip(:,3) = ieReadSpectra('BrianLip1-R01-R01.mat', wave); 
B_lip(:,4) = ieReadSpectra('BrianLip1-R01-R02.mat', wave); 
S2_lipReflectance = mean(B_lip,2) ./ mean(BwhiteRef,2);
% ieFigure; plot(wave,B_lip); hold on;
% plotReflectance(wave,S3_lipReflectance);

%% JF:  data collected on 2025-05-27

JwhiteRef = zeros(length(wave),3);
JwhiteRef(:,1) = ieReadSpectra('joyce-light-calibration-R01.mat', wave); 	
JwhiteRef(:,2) = ieReadSpectra('joyce-light-calibration-R02.mat', wave); 
JwhiteRef(:,3) = ieReadSpectra('joyce-light-calibration-R03.mat', wave); 

J_tongue = zeros(length(wave),2);	
% We moved the light, so only consider the last 2 measurements
% J_tongue(:,1) = ieReadSpectra('joyce-tongue-1-R01.mat', wave); 
%   ieFigure; plot(wave,J_tongue);hold on;
%    J_tongue(:,2) = ieReadSpectra('joyce-tongue-1-R02.mat', wave);plot(wave,J_tongue);
%   J_tongue(:,1) = ieReadSpectra('joyce-tongue-2-R01.mat', wave); 	plot(wave,J_tongue);
%   J_tongue(:,2) = ieReadSpectra('joyce-tongue-2-R02.mat', wave);plot(wave,J_tongue);
J_tongue(:,1) = ieReadSpectra('joyce-tongue-2-R01-R01.mat', wave); 	plot(wave,J_tongue,'k');
J_tongue(:,2) = ieReadSpectra('joyce-tongue-2-R01-R02.mat', wave);plot(wave,J_tongue,'k');
% ieFigure; plot(wave,J_tongue );
S4_tongueReflectance = mean(J_tongue,2) ./ mean(JwhiteRef,2);

J_lip = zeros(length(wave),2);
J_lip(:,1) = ieReadSpectra('joyce-lip-1-R01.mat', wave); 
J_lip(:,2) = ieReadSpectra('joyce-lip-1-R02.mat', wave);
% ieFigure; plot(wave,J_lip);
S4_lipReflectance = mean(J_lip,2) ./ mean(JwhiteRef,2);

%% DW:  data collected on 2025-06-03

D_Ref = zeros(length(wave),3);
D_Ref(:,1) = ieReadSpectra('spd-2025-06-03-LightCalibrationDW-R01', wave); 	
D_Ref(:,2) = ieReadSpectra('spd-2025-06-03-LightCalibrationDW-R02', wave); 
D_Ref(:,3) = ieReadSpectra('spd-2025-06-03-LightCalibrationDW-R03', wave); 

D_tongue = zeros(length(wave),2);	
D_tongue(:,1) = ieReadSpectra('spd-2025-06-03-TongueDW-R01', wave);
D_tongue(:,2) = ieReadSpectra('spd-2025-06-03-TongueDW-R02', wave);
D_tongue(:,3) = ieReadSpectra('spd-2025-06-03-TongueDW-R03', wave);

S3_tongueReflectance = mean(D_tongue,2) ./ mean(D_Ref,2);

D_lip = zeros(length(wave),2);
D_lip(:,1) = ieReadSpectra('spd-2025-06-03-LipDW-R01', wave); 
D_lip(:,2) = ieReadSpectra('spd-2025-06-03-LipDW-R02', wave);
D_lip(:,4) = ieReadSpectra('spd-2025-06-03-LipDW-R03', wave);

S3_lipReflectance = mean(D_lip,2) ./ mean(D_Ref,2);

%% Plot the tongue lip reflectances
ieFigure;
plot(wave,S2_tongueReflectance,'k-');
hold on;
plot(wave,S3_tongueReflectance,'k-');
plot(wave,S4_tongueReflectance,'k-');

plot(wave,S2_lipReflectance,'k--');
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