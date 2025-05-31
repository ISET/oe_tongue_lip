% s_LipTongueReflectance2025_05_27
%%
cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/;
addpath(genpath(pwd));
ieInit;
wave = 380:5:750;

%% data collected on 2025-05-27

BwhiteRef = zeros(length(wave),3);
BwhiteRef(:,1) = ieReadSpectra('BrianLightCalibration-R01.mat', wave); 
BwhiteRef(:,2) = ieReadSpectra('BrianLightCalibration-R02.mat', wave); 
BwhiteRef(:,3) = ieReadSpectra('BrianLightCalibration-R03.mat', wave); 

B_tongue = zeros(length(wave),3);
B_tongue(:,1) = ieReadSpectra('BrianTongue1-R01.mat', wave); 
B_tongue(:,2) = ieReadSpectra('BrianTongue1-R02.mat', wave); 
B_tongue(:,3) = ieReadSpectra('BrianTongue1-R03.mat', wave); 
% ieFigure; plot(wave,B_tongue);
BW_tongueReflectance = mean(B_tongue,2) ./ mean(BwhiteRef,2);

B_lip = zeros(length(wave),4);
% use the last two measurements
B_lip(:,1) = ieReadSpectra('BrianLi21-R01-R01-R01.mat', wave); 
B_lip(:,2) = ieReadSpectra('BrianLi21-R01-R01-R02.mat', wave); 
B_lip(:,3) = ieReadSpectra('BrianLip1-R01-R01.mat', wave); 
B_lip(:,4) = ieReadSpectra('BrianLip1-R01-R02.mat', wave); 
% ieFigure; plot(wave,B_lip); hold on;
BW_lipReflectance = mean(B_lip,2) ./ mean(BwhiteRef,2);

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
JF_tongueReflectance = mean(J_tongue,2) ./ mean(JwhiteRef,2);

J_lip = zeros(length(wave),2);
J_lip(:,1) = ieReadSpectra('joyce-lip-1-R01.mat', wave); 
J_lip(:,2) = ieReadSpectra('joyce-lip-1-R02.mat', wave);
% ieFigure; plot(wave,J_lip);
JF_lipReflectance = mean(J_lip,2) ./ mean(JwhiteRef,2);

%% Compare the tongue data to data I collected in 2019
tongue = ieReadSpectra('tongue.mat',wave); 
ieFigure; plot(wave,tongue,'k'); hold on;
plot(wave,BW_tongueReflectance,'r','LineWidth',2);
plot(wave,JF_tongueReflectance,'g','LineWidth',2);
title('Tongue Reflectance Measurements')
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Reflectance');

%$ Compare with lip
ieFigure; plot(wave,tongue,'k'); hold on;
plot(wave,BW_tongueReflectance,'r','LineWidth',2); 
plot(wave,JF_tongueReflectance,'g','LineWidth',2);
plot(wave,BW_lipReflectance,'r--','LineWidth',2); 
plot(wave,JF_lipReflectance,'g--','LineWidth',2);



