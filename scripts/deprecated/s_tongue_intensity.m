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
plot(waves,meanTongueReflectance,'r','LineWidth',2); 
whiteSurface1 = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_80mA.mat',waves);
predictedTongueReflectance_415nm_80mA = whiteSurface1 .* meanTongueReflectance;
whiteSurface2 = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_460mA.mat',waves); 
predictedTongueReflectance_415nm_460mA = whiteSurface2 .* meanTongueReflectance;
whiteSurface3 = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_910mA.mat',waves); 
predictedTongueReflectance_415nm_910mA = whiteSurface3 .* meanTongueReflectance;
ieFigure; plot(waves,whiteSurface1); hold on;
plot(waves,whiteSurface2);
plot(waves,whiteSurface3);
%

%% Tongue radiance at 4 levels: 80, 170, 460, 910 mA
Z_tongue1 = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-80mA-R01.mat',waves);     figure; plot(waves,Z_tongue1,'k:','LineWidth',2); hold on;
Z_tongue2 = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-170mA-R01.mat',waves);	plot(waves,Z_tongue2,'k-.','LineWidth',2); hold on;
Z_tongue3 = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-460mA-R01.mat',waves);	plot(waves,Z_tongue3,'k--','LineWidth',2); hold on;
Z_tongue4 = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-910mA-R01.mat',waves);    plot(waves,Z_tongue4,'k','LineWidth',2); hold on;  
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title ('ZL');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

% Brian  
B_tongue1 = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-80mA-R01.mat',waves);figure; plot(waves,B_tongue1,'k:','LineWidth',2); hold on;
B_tongue2 = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-170mA-R01.mat',waves);    plot(waves,B_tongue2,'k-.','LineWidth',2); hold on;	
B_tongue3 = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-460mA-R02.mat',waves);    plot(waves,B_tongue3','k--','LineWidth',2); hold on;
B_tongue4 = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat',waves);    plot(waves,B_tongue4,'k','LineWidth',2); hold on;
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title('BW');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

% Doug 
D_tongue1 = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_80mA-R01.mat',waves); figure; plot(waves,D_tongue1,'k:','LineWidth',2); hold on;
D_tongue2 = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_170mA-R01.mat',waves); plot(waves,D_tongue2,'k-.','LineWidth',2); hold on;
D_tongue3 = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_460mA-R02.mat',waves); plot(waves,D_tongue3,'k--','LineWidth',2); hold on;
D_tongue4 = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_910mA-R01.mat',waves); plot(waves,D_tongue4,'k','LineWidth',2); hold on; 
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title('DW');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

%% Joyce 
% Before lunch (tongue 415 at different intensities)
J_tongue1 = ieReadSpectra('spd-2024-03-08-J-tongue-415nm450spf-80mA-R01.mat',waves); figure; plot(waves,J_tongue1,'k:','LineWidth',2); hold on;
J_tongue2 = ieReadSpectra('spd-2024-03-08-J-tongue-415nm450spf-170mA-R01.mat',waves);    plot(waves,J_tongue2,'k-.','LineWidth',2); hold on;	
J_tongue3 = ieReadSpectra('spd-2024-03-08-J-tongue-415nm450spf-460mA-R01.mat',waves);    plot(waves,J_tongue3,'k--','LineWidth',2); hold on;		
J_tongue4 = ieReadSpectra('spd-2024-03-08-J-tongue-415nm450spf-910mA-R01.mat',waves);    plot(waves,J_tongue4,'k','LineWidth',2);
plot(waves,predictedTongueReflectance_415nm_910mA,'k-o','LineWidth',2); 
title('JF');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

%% 
% Now calculate the scale factor that brings each of the curves at
% different intensities into correspondence with the max intensity
% And then plot the scale factor as a function of each intensity
% Suppose your curves are y1, y2, y3 (to be scaled) and y4 (reference)
% All curves are evaluated at the same x locations

% For example, scale y1 to match y4
%s1 = (y1(:)' * y4(:)) / (y1(:)' * y1(:)); % Optimal scale factor for y1
y1 = Z_tongue1;
y2 = Z_tongue2;
y3 = Z_tongue3;
y4 = Z_tongue4;
s1 = (y1(:)' * y4(:)) / (y1(:)' * y1(:))
% s2 = (y2(:)' * y4(:)) / (y2(:)' * y2(:))
s3 = (y3(:)' * y4(:)) / (y3(:)' * y3(:))
% intensity = [80,170,460,910];
intensity = [80,460,910];
% scale = [1/s1, 1/s2, 1/s3, 1];
scale = [1/s1 1/s3, 1];
ieFigure; plot(intensity,scale,'k-o','LineWidth',2); hold on;

y1 = B_tongue1;
y2 = B_tongue2;
y3 = B_tongue3;
y4 = B_tongue4;
s1 = (y1(:)' * y4(:)) / (y1(:)' * y1(:))
% s2 = (y2(:)' * y4(:)) / (y2(:)' * y2(:))
s3 = (y3(:)' * y4(:)) / (y3(:)' * y3(:))
intensity = [80,170,460,910];
scale = [1/s1, 1/s2, 1/s3, 1]; plot(intensity,scale,'r-o','LineWidth',2);

y1 = D_tongue1;
y2 = D_tongue2;
y3 = D_tongue3;
y4 = D_tongue4;
s1 = (y1(:)' * y4(:)) / (y1(:)' * y1(:))
% s2 = (y2(:)' * y4(:)) / (y2(:)' * y2(:))
s3 = (y3(:)' * y4(:)) / (y3(:)' * y3(:))
intensity = [80,170,460,910];
scale = [1/s1, 1/s2, 1/s3, 1]; plot(intensity,scale,'g-o','LineWidth',2);

y1 = J_tongue1;
y2 = J_tongue2;
y3 = J_tongue3;
y4 = J_tongue4;
s1 = (y1(:)' * y4(:)) / (y1(:)' * y1(:))
% s2 = (y2(:)' * y4(:)) / (y2(:)' * y2(:))
s3 = (y3(:)' * y4(:)) / (y3(:)' * y3(:))
intensity = [80,170,460,910];
scale = [1/s1, 1/s2, 1/s3, 1]; plot(intensity,scale,'b-o','LineWidth',2);

legend('ZL', 'BW', 'DW', 'JF');
title('Linearity');
fontsize(gca,16,"pixels");
xlabel('current level');
ylabel('scale factor');