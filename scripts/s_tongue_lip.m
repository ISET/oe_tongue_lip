% s_tongue_lowerlip.m
%
% Purpose: 
% Build a forward model that can predict measurements of tongue and lower lip autofluorescence
% by a combination of
%   1) positively weighted bulk tissue fluorescence (NADH, collagen, elastin, keratin, FAD)
%   2) positively weighted porphyrin fluorescence
%   3) divide light absorbance by oxy and deoxy hemoglobin
%
% Demonstrate the multicollinearity of the tissue fluorophores contributing
% to the bulk tissue fluorescence spectral function
% emissions signals of many fluorophores overlap, since the absorption and emission bandwidths of these molecules can be broad

% Multicollinearity or collinearity is when there are multiple linear combinations of 
% different fluorophore concentrations can equally predict the observed fluorescence
% This occurs because 
%   1) the concentrations of the different tissue fluorophores are unknown, and
%   2) the emission spectra of tissue fluorophores have similar shape
%       can be described as skew normal functions 
%       with peak emission at wavelength that is less than the peak wavelength of the excitation light
%       or with peak emission at wavelength that is less than the cutoff
%       frequency of the longpass filter in front of the spectrophotometer
%   3) fluorescence emissions are linear with the intensity of the excitation light
% Consequently, the emissions from each tissue fluorophore can be scaled by
% a factor that is due its concentration and the effectiveness of the
% excitation light (determined by peak wavelength and amplitude)
%

% Demonstrate that it is possible to separate the effect of FAD when
% excitation light is 450 nm


%% make sure these libraries are on your path
cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));

ieInit;
waves = 380:5:750;

%% Spectral basis functions 
% Can emissions of fluorophores be modeled by a log-normal distribution with single peak?
% Read in the spectral emissions functions for different tissue fluorophores
% data in isetfluorescence repository
keratin = fiReadFluorophore('keratin.mat','wave',waves);
ieNewGraphWin; plot(waves, keratin.emission/max(keratin.emission(:)),'g','LineWidth',2);  hold on;
FAD = fiReadFluorophore('FAD_webfluor.mat','wave',waves); 
plot(waves, FAD.emission/max(FAD.emission(:)),'r','LineWidth',2);  
collagen = fiReadFluorophore('collagen1.mat','wave',waves); 
plot(waves, collagen.emission/max(collagen.emission(:)),'b','LineWidth',2);  hold on;
elastin = fiReadFluorophore('elastin_webfluor.mat','wave',waves); 
plot(waves, elastin.emission/max(elastin.emission),'m','LineWidth',2);  
NADH = fiReadFluorophore('NADH_webfluor.mat','wave',waves);
plot(waves, NADH.emission/max(NADH.emission),'k','LineWidth',2);  
% porphyrins= fiReadFluorophore('Porphyrins.mat','wave',waves); % from Monici
porphyrins= fiReadFluorophore('protoporphyrin.mat','wave',waves); % from DaCosta % cannot be modeled as log-normal with single peak
plot(waves, porphyrins.emission/max(porphyrins.emission(:)),'r--','LineWidth',2);  
% From ? (chlorophyll)
% in isetfluorescence/data but make into a fluorophore struct
chlorophyllA= ieReadSpectra('ChlorophyllA_emission.mat', waves);
plot(waves, chlorophyllA/max(chlorophyllA),'g--','LineWidth',2);
legend('keratin', 'FAD', 'collagen', 'elastin', 'NADH','porphyrins','chlorophyll');
% set(gca,'ylim',[0 1]);
% set(gca,'xlim',[400 800]);
set(gca,'fontsize',16);
% set(gca,'xtick',400:100:700);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');
title('Fluorophore Emissions')

%% fitting a log-normal to emissions
% need the Statistics and Machine Learning Toolbox
% [pHat, pCI] = lognfit(x)
%       pHat contains the parameter estimates (mean and standard deviation of logarithmic values)
%       pCI provides the 95% confidence intervals for these estimates.
% pd = fitdist(x, 'Lognormal') % matlab function for fitting an unbiased lognormal 
% params = mle(x, 'Distribution', 'Lognormal') % matlab function for fitting a maximum likelihood lognormal 
% The log-normal distribution is only defined for strictly positive values (greater than zero). 
% Zero values are not allowed because the natural logarithm of zero is undefined.
x= keratin.emission; X = x(x >  0.0001); [pHat, pCI] = lognfit(X)
x= elastin.emission; X = x(x >  0.0001); [pHat, pCI] = lognfit(X)
x= NADH.emission; X = x(x >  0.0001); [pHat, pCI] = lognfit(X)
x= collagen.emission; X = x(x >  0.0001); [pHat, pCI] = lognfit(X)
x= FAD.emission, X = x(x >  0.0001); [pHat, pCI] = lognfit(X)
%% Read in the functions for light absorbance by oxy and deoxy hemoglobin
oxy = ieReadSpectra('OxyHemoglobinAbsorption.mat',waves); % currently in cholesteotoma repository
deoxy = ieReadSpectra('DeoxyHemoglobinAbsorption.mat',waves); 
ieNewGraphWin; plot(waves, oxy/max(oxy(:)),'g','LineWidth',2);  hold on;
plot(waves, deoxy/max(deoxy(:)),'b','LineWidth',2);  hold on;

%% Data : Tongue autofluorescence with estimated reflectance

% mean tongue reflectance
% Figure to compare tongue fluorescence measurements to predicted
% reflectance
tongue = ieReadSpectra('tongue.mat',waves); 
figure; plot(waves,tongue,'k'); hold on;
meanTongueReflectance = mean(tongue,2);
plot(waves,meanTongueReflectance,'r','LineWidth',2);
title('Tongue Reflectance Measurements')
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Reflectance');	

% predicted tongue reflectance for 405 nm light at different intensity levels
% 405 nm light with 980mA current
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_980mA.mat',waves);
predictedTongueReflectance_405nm_980mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_560mA.mat',waves);
predictedTongueReflectance_405nm_560mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_90mA.mat',waves);
predictedTongueReflectance_405nm_90mA = whiteSurface .* meanTongueReflectance;

whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_910mA.mat',waves); 
predictedTongueReflectance_415nm_910mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_460mA.mat',waves); 
predictedTongueReflectance_415nm_460mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_80mA.mat',waves); 
predictedTongueReflectance_415nm_80mA = whiteSurface .* meanTongueReflectance;

whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_870mA.mat',waves); 
predictedTongueReflectance_450nm_870mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_480mA.mat',waves); 
predictedTongueReflectance_450nm_480mA = whiteSurface .* meanTongueReflectance;
whiteSurface = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_90mA.mat',waves); 
predictedTongueReflectance_450nm_90mA = whiteSurface .* meanTongueReflectance;

% Tongue: for each light, plot radiance measured at max intensity (N subjects), along with predicted reflectance
% This will be 3 figures, one for each light, tongue data only since we
% only have reflectance data for tongues
% to plot the data measured with different intensities see
% s_TongueFluorescencewithReflectance.m
% 405 nm light
Z_tongue = ieReadSpectra('spd-2024-03-14-Z-405nm_tongue_980mA.mat',waves); 
J_tongue = ieReadSpectra('spd-2024-03-12-11-405nm-J-tongue-980mA.mat',waves); 
B_tongue = ieReadSpectra('spd-2024-03-19-B_405nm_tongue_980mA.mat',waves); 
D_tongue = ieReadSpectra('spd-2024-03-19-D_4050nm_tongue_980mA.mat',waves); 
figure; plot(waves,predictedTongueReflectance_405nm_980mA,'k--','LineWidth',2); hold on;
plot(waves,Z_tongue ,'k','LineWidth',2);
plot(waves,J_tongue ,'k','LineWidth',2);
plot(waves,B_tongue ,'k','LineWidth',2);
plot(waves,D_tongue ,'k','LineWidth',2);
title('Tongue fluorescence (N=4) with 405 nm light');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");

% 415 light
Z_tongue = ieReadSpectra('spd-2024-03-14-Z-415nm_Tongue_910mA.mat',waves); 
J_tongue = ieReadSpectra('spd-2024-03-12-11-415nm-J-tongue-910mA.mat',waves); 
B_tongue = ieReadSpectra('spd-2024-03-19-B_415nm_tongue_910mA.mat',waves); 
D_tongue = ieReadSpectra('spd-2024-03-19-D_415nm_tongue_910mA.mat',waves); 
figure; plot(waves,predictedTongueReflectance_415nm_910mA,'k--','LineWidth',2); hold on;
plot(waves,Z_tongue ,'k','LineWidth',2);
plot(waves,J_tongue ,'k','LineWidth',2);
plot(waves,B_tongue ,'k','LineWidth',2);
plot(waves,D_tongue ,'k','LineWidth',2);
title('Tongue fluorescence (N=4) with 415 nm light');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");

% 450 light
Z_tongue = ieReadSpectra('spd-2024-03-14-Z-450nm_tongue_870mA.mat',waves);
J_tongue = ieReadSpectra('spd-2024-03-12-450nm-J-tongue-460mA-1.mat',waves);
B_tongue = ieReadSpectra('spd-2024-03-19-B_450nm_tongue_870mA.mat',waves); 
D_tongue = ieReadSpectra('spd-2024-03-19-D_450nm_tongue_870mA.mat',waves); 
figure; plot(waves,predictedTongueReflectance_450nm_870mA,'k--','LineWidth',2); hold on;
plot(waves,Z_tongue ,'k','LineWidth',2);
plot(waves,J_tongue ,'k','LineWidth',2);
plot(waves,B_tongue ,'k','LineWidth',2);
plot(waves,D_tongue ,'k','LineWidth',2);
title('Tongue fluorescence (N=4) with 450 nm light');
xlabel('Wavelength (nm)')
ylabel('Radiance (watts/sr/nm/m^2)');
fontsize(gca,14,"pixels");


%% Data: Lower Lip
% 405
% B_lip_405 = ieReadSpectra('spd-2024-03-19-B_405nm_lip_980mA.mat',waves);
D_lip_405 = ieReadSpectra('spd-2024-03-19-D_4050nm_lip_980mA.mat',waves);
Z_lip_405 = ieReadSpectra('spd-2024-03-14-Z-405nm_lip_980mA.mat',waves);
J_lip_405 = ieReadSpectra('spd-2024-03-12-11-405nm-J-lip-980mA.mat',waves);
% 415
B_lip_415 = ieReadSpectra('spd-2024-03-19-B_415nm_lip_910mA.mat',waves);
D_lip_415 = ieReadSpectra('spd-2024-03-19-D_415nm_lip_910mA.mat',waves);
Z_lip_415 = ieReadSpectra('spd-2024-03-14-Z-415nm_lip_910mA.mat',waves);
J_lip_415 = ieReadSpectra('spd-2024-03-12-11-415nm-J-lip-910mA.mat',waves);

% 450
B_lip_450 = ieReadSpectra('spd-2024-03-19-B_450nm_lip_870mA.mat',waves);
D_lip_450 = ieReadSpectra('spd-2024-03-19-D_450nm_lip_870mA.mat',waves);
Z_lip_450 = ieReadSpectra('spd-2024-03-14-Z-450nm_lip_870mA.mat',waves);
J_lip_450 = ieReadSpectra('spd-2024-03-12-11-450nm-J-lip-870mA.mat',waves);

%% Data : lettuce
% Move the data to /local?
% Here is the data plotted before and after lunch to show effect of
% lettuce
% Purpose: show difference between before and after, as well as effect of
% excitation light intensity, and reduction in fluorescence in multiple measurements
% Before

% After
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

% superimpose measurements of lettuce fluorescence and tongue fluorescence (after lunch) 
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