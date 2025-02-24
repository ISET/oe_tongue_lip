% s_plotExcitationLights

cd /Users/joyce/Github/isetcam; addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/; addpath(genpath(pwd));
cd /users/joyce/Github/isetfluorescence/; addpath(genpath(pwd));
cd /users/joyce/Github/oe_tongue_lip/; addpath(genpath(pwd));

ieInit;
waves = 380:5:750;
% Question: we have data that we measured on tongue and lip for 415 170mA
% but we do not have measurements for light spd and the noise passing
% through the 475 nm longpass filter

% select the data we want to include in the report
%% 
% These were not the intensities we used in the tongue_lip measurements.  
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (4 lights cali+verify)';
ieNewGraphWin;
data = ieReadSpectra('spd-2024-03-07-Calib-405nm450SPF-50mA.mat',waves); % not used in the intensity experiments, so don't plot?
plot(waves,data); hold on;
data = ieReadSpectra('spd-2024-03-07-Calib-405nm450SPF-100mA.mat',waves);plot(waves,data);
data = ieReadSpectra('spd-2024-03-07-Calib-405nm450SPF-450mA.mat',waves);plot(waves,data);
data = ieReadSpectra('spd-2024-03-07-Calib-405nm450SPF-500mA.mat',waves);plot(waves,data);
data = ieReadSpectra('spd-2024-03-07-Calib-405nm450SPF-680mA.mat',waves);plot(waves,data);
data = ieReadSpectra('spd-2024-03-07-Calib-405nm450SPF-950mA.mat',waves);plot(waves,data);
data = ieReadSpectra('spd-2024-03-07-Calib-405nm450SPF-1000mA.mat',waves);plot(waves,data);
%{
spd-2024-03-07-calib-415nm450SPF-50mA.mat
spd-2024-03-07-calib-415nm450SPF-70mA.mat
spd-2024-03-07-calib-415nm450SPF-100mA.mat
spd-2024-03-07-calib-415nm450SPF-320mA.mat
spd-2024-03-07-calib-415nm450SPF-470mA.mat
spd-2024-03-07-calib-415nm450SPF-500mA.mat
spd-2024-03-07-calib-415nm450SPF-570mA.mat
spd-2024-03-07-calib-415nm450SPF-1000mA.mat

spd-2024-03-07-calib-425nm450SPF-50mA.mat
spd-2024-03-07-calib-425nm450SPF-100mA.mat
spd-2024-03-07-calib-425nm450SPF-360mA.mat
spd-2024-03-07-calib-425nm450SPF-500mA.mat
spd-2024-03-07-calib-425nm450SPF-510mA.mat
spd-2024-03-07-calib-425nm450SPF-730mA.mat
spd-2024-03-07-calib-425nm450SPF-1500mA.mat

spd-2024-03-07-Calib-450nm450SPF-50mA.mat
spd-2024-03-07-Calib-450nm450SPF-100mA.mat
spd-2024-03-07-Calib-450nm450SPF-120mA.mat
spd-2024-03-07-Calib-450nm450SPF-500mA.mat
spd-2024-03-07-Calib-450nm450SPF-530mA.mat
spd-2024-03-07-Calib-450nm450SPF-1000mA.mat
spd-2024-03-07-Calib-450nm450SPF-1300mA.mat

spd-2024-03-07-noisecheck-405nm450SPF-50mA.mat
spd-2024-03-07-noisecheck-405nm450SPF-1000mA.mat
spd-2024-03-07-noisecheck-415nm450SPF-50mA.mat
spd-2024-03-07-noisecheck-415nm450SPF-1000mA.mat
spd-2024-03-07-noisecheck-425nm450SPF-50mA-1deg.mat
spd-2024-03-07-noisecheck-425nm450SPF-1500mA-1deg.mat
spd-2024-03-07-noisecheck-425nm450SPF-1500mA.mat
spd-2024-03-07-Noisecheck-450nm450SPF-50mA.mat
spd-2024-03-07-Noisecheck-450nm450SPF-1300mA.mat
%}

%% Figure plotting the spectral intensity of the 405, 415 and 450 nm lights at max
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (4 lights cali+verify)';
% 405 405nm_980mA.mat
ieNewGraphWin;
data = ieReadSpectra('spd-2024-03-07-Calib-405nm450SPF-1000mA.mat',waves);  plot(waves,data,'b','LineWidth',2); hold on
% 415 415nm_910mA.mat
data = ieReadSpectra('spd-2024-03-07-calib-415nm450SPF-1000mA.mat',waves);  plot(waves,data,'g','LineWidth',2);
% 450 450nm_870mA.mat
data = ieReadSpectra('spd-2024-03-07-Calib-450nm450SPF-1000mA.mat',waves); plot(waves,data,'r','LineWidth',2);
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([350 500]);
legend('405 nm', '415 nm', '450 nm');
% title('Spectral energy in the excitation lights with 450 nm shortpass filter')
%% This is the amount of light that passed through the longpass filter
% due to the fact that an led has small but measurable energy in the longer wavelengths, and
% the 475 nm longpass filter placed on the spectrophotometer does not block 100% of the light
% all lights had a 450 nm SPF, even 450?
%Measurements were made with 475 nm LPF
% It is expected that more of the 450 nm light passed through the 475 nm LPF
% but interesting that 405 nm light that passed through had more energy 700
% nm 
ieNewGraphWin;
data = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_90mA.mat',waves); plot(waves,data,'b'); hold on;
data = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_560mA.mat',waves); plot(waves,data,'b');
data = ieReadSpectra('spd-2024-03-17-NoiseCheck-405nm_980mA.mat',waves); plot(waves,data,'b');

data = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_80mA.mat',waves); plot(waves,data,'g');
data = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_460mA.mat',waves); plot(waves,data,'g'); 
data = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_910mA.mat',waves); plot(waves,data,'g');


data = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_90mA.mat',waves); plot(waves,data,'r');
data = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_480mA.mat',waves); plot(waves,data,'r');
data = ieReadSpectra('spd-2024-03-17-NoiseCheck-450nm_870mA.mat',waves); plot(waves,data,'r');
data = ieReadSpectra('spd-2024-03-17-NoiseCheck-completeblack.mat',waves); plot(waves,data,'k');  

%%
noise415_80mA = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_80mA.mat',waves); plot(waves,light415_80mA); hold on; 
noise415_460mA = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_460mA.mat',waves); 
noise415_910mA = ieReadSpectra('spd-2024-03-17-NoiseCheck-415nm_910mA.mat',waves); 
%% to show the radiance of light used in tongue intensity measurements
% we only did this for one subject and 415 nm light
% 415 nm light had a 450 nm shortpass filter on it
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (4 lights cali+verify)/verify';
ieNewGraphWin;
light415_80mA = ieReadSpectra('spd-2024-03-07-verif-415nm450SPF-80mA.mat',waves); plot(waves,light415_80mA); hold on;
light415_460mA = ieReadSpectra('spd-2024-03-07-verif-415nm450SPF-460mA.mat',waves); plot(waves,light415_460mA); 
light415__910mA = ieReadSpectra('spd-2024-03-07-verif-415nm450SPF-910mA.mat',waves); plot(waves,light415__910mA); 







%% to show the radiance of lights used in tongue_lip measurements


