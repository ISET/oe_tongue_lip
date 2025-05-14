
% s_TongueLip415Intensity.m

% 415 nm excitation light with 450 nm shortpass filter

cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /Users/joyce/Github/isetfluorescence;
addpath(genpath(pwd));
cd /users/joyce/Github/oraleye/;
addpath(genpath(pwd));

waves = 350:5:800;

%% Directory for where the data are
% Note that these pathes are different depending on the computer I am on -
% need to change this to be a more generic location (Flywheel?)
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (415nm Tongue+lip measurements';
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-07 (415nm Tongue+lip measurements';

%% Zhenyi 
% tongue
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-80mA-R01.mat',waves); figure; plot(waves,Z_tongue,'b','LineWidth',2); hold on;
% Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-80mA-R02.mat',waves);     plot(waves,Z_tongue,'b','LineWidth',2); hold on;
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-170mA-R01.mat',waves);	plot(waves,Z_tongue,'g','LineWidth',2); hold on;
% Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-170mA-R02.mat',waves);	plot(waves,Z_tongue,'g','LineWidth',2); hold on;
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-460mA-R01.mat',waves);	plot(waves,Z_tongue,'r','LineWidth',2); hold on;
% Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-460mA-R02.mat',waves);	plot(waves,Z_tongue,'r','LineWidth',2); hold on;
% two successive measurements are very different
Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-910mA-R01.mat',waves);    plot(waves,Z_tongue,'k','LineWidth',2); hold on; 
% Z_tongue = ieReadSpectra('spd-2024-03-07-Z-Tongue-415nm450SPF-910mA-R02.mat',waves);    plot(waves,Z_tongue,'k','LineWidth',2); hold on;

% lip - pretty good agreement
Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-80mA-R01.mat',waves);    figure; plot(waves,Z_lip,'b','LineWidth',2); hold on;
% Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-80mA-R02.mat',waves);    plot(waves,Z_lip,'b','LineWidth',2); hold on;
Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-170mA-R01.mat',waves);   plot(waves,Z_lip,'g','LineWidth',2); hold on;
% Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-170mA-R02.mat',waves);   plot(waves,Z_lip,'g','LineWidth',2); hold on;
Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-460mA-R01.mat',waves);   plot(waves,Z_lip,'r','LineWidth',2); hold on;
% Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-460mA-R02.mat',waves);   plot(waves,Z_lip,'r','LineWidth',2); hold on;
Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-910mA-R01.mat',waves);   plot(waves,Z_lip,'k','LineWidth',2); hold on;
% Z_lip= ieReadSpectra('spd-2024-03-07-Z-lip-415nm450SPF-910mA-R02.mat',waves);   plot(waves,Z_lip,'k','LineWidth',2); hold on;

title('Zhenyi');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

%% Brian  
 %tongue  pretty good agreement on successive measurements
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-80mA-R01.mat',waves);figure; plot(waves,B_tongue,'b','LineWidth',2); hold on;
% B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-80mA-R02.mat',waves);     plot(waves,B_tongue,'b','LineWidth',2); hold on;
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-170mA-R01.mat',waves);    plot(waves,B_tongue,'g','LineWidth',2); hold on;	
% B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-170mA-R02.mat',waves);    plot(waves,B_tongue,'g','LineWidth',2); hold on;	
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-460mA-R02.mat',waves);    plot(waves,B_tongue,'r','LineWidth',2); hold on;	
% B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-460mA-R01.mat',waves);    plot(waves,B_tongue,'r','LineWidth',2); hold on;	
B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat',waves);    plot(waves,B_tongue,'k','LineWidth',2); hold on;
% B_tongue = ieReadSpectra('spd-2024-03-07-B-tongue-415nm450SPF-910mA-R02.mat',waves);    plot(waves,B_tongue,'k','LineWidth',2); hold on;

%lip - pretty good agreement
B_lip= ieReadSpectra('spd-2024-03-07-B-lip-415nm450SPF-80mA-R01.mat',waves);   figure;  plot(waves,B_lip,'b','LineWidth',2); hold on;
B_lip= ieReadSpectra('spd-2024-03-07-B-lip-415nm450SPF-170mA-R01.mat',waves);   plot(waves,B_lip,'g','LineWidth',2); hold on;
% B_lip= ieReadSpectra('spd-2024-03-07-B-lip-415nm450SPF-170mA-R02.mat',waves);	plot(waves,B_lip,'g','LineWidth',2); hold on;
B_lip= ieReadSpectra('spd-2024-03-07-B-lip-415nm450SPF-460mA-R01.mat',waves);	plot(waves,B_lip,'r','LineWidth',2); hold on;
% B_lip= ieReadSpectra('spd-2024-03-07-B-lip-415nm450SPF-460mA-R02.mat',waves);	plot(waves,B_lip,'r','LineWidth',2); hold on;
B_lip= ieReadSpectra('spd-2024-03-07-B-lip-415nm450SPF-910mA-R01.mat',waves);	plot(waves,B_lip,'k','LineWidth',2); hold on;
% B_lip= ieReadSpectra('spd-2024-03-07-B-lip-415nm450SPF-910mA-R02.mat',waves);	plot(waves,B_lip,'k','LineWidth',2); hold on;

title('Brian');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

%% Doug 
cd '/Users/joyce/Library/CloudStorage/GoogleDrive-jefarrel@stanford.edu/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';
% cd '/Volumes/GoogleDrive/My Drive/Projects/Oral Cancer Screening/Spectral Data/Lab Measurements/2024-03-08 (415nm tongue+lip)';

D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_80mA-R01.mat',waves); figure; plot(waves,D_tongue,'b','LineWidth',2); hold on;
% D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_80mA-R02.mat',waves); plot(waves,D_tongue,'b','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_170mA-R01.mat',waves); plot(waves,D_tongue,'g','LineWidth',2); hold on;
% D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_170mA-R02.mat',waves); plot(waves,D_tongue,'g','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_460mA-R02.mat',waves); plot(waves,D_tongue,'r','LineWidth',2); hold on;
% D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_460mA-R01.mat',waves); plot(waves,D_tongue,'r','LineWidth',2); hold on;
D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_910mA-R01.mat',waves); plot(waves,D_tongue,'k','LineWidth',2); hold on;
% D_tongue = ieReadSpectra('spd-2024-03-08-D-tongue-415nm450spf_910mA-R02.mat',waves); plot(waves,D_tongue,'k','LineWidth',2); hold on;

D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_80mA-R02.mat',waves); figure; plot(waves,D_lip,'b','LineWidth',2); hold on;
% D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_80mA-R01.mat',waves); plot(waves,D_lip,'b','LineWidth',2); hold on;
D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_170mA-R01.mat',waves); plot(waves,D_lip,'g','LineWidth',2); hold on;
% D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_170mA-R02.mat',waves); plot(waves,D_lip,'g','LineWidth',2); hold on;
D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_460mA-R02.mat',waves); plot(waves,D_lip,'r','LineWidth',2); hold on; 
% D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_460mA-R01.mat',waves); plot(waves,D_lip,'r','LineWidth',2); hold on;
D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_910mA-R01.mat',waves); plot(waves,D_lip,'k','LineWidth',2); hold on;
% D_lip = ieReadSpectra('spd-2024-03-08-D-lip-415nm450spf_910mA-R02.mat',waves); plot(waves,D_lip,'k','LineWidth',2); hold on;

title('Doug');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

%% Joyce 

% Before lunch - some variability
 J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-80mA-R01.mat',waves); figure; plot(waves,J_tongue,'b','LineWidth',2); hold on;
% J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-80mA-R02.mat',waves);    plot(waves,J_tongue,'b','LineWidth',2); J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-170mA-R01.mat',waves);   plot(waves,J_tongue,'g','LineWidth',2);
J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-170mA-R02.mat',waves);   plot(waves,J_tongue,'g','LineWidth',2);
J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-460mA-R02.mat',waves);   plot(waves,J_tongue,'r','LineWidth',2);
% J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-460mA-R01.mat',waves);   plot(waves,J_tongue,'r','LineWidth',2);	
J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R01.mat',waves);   plot(waves,J_tongue,'k','LineWidth',2);
% J_tongue = ieReadSpectra('spd-2024-03-08-J-415nm450spf-910mA-R02.mat',waves);   plot(waves,J_tongue,'k','LineWidth',2);

J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-80mA-R01.mat',waves);   figure; plot(waves,J_lip,'b','LineWidth',2); hold on;
% J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-80mA-R02.mat',waves);   plot(waves,J_lip,'b','LineWidth',2);
J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-170mA-R01.mat',waves);	plot(waves,J_lip,'g','LineWidth',2);
% J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-170mA-R02.mat',waves);  plot(waves,J_lip,'g','LineWidth',2);	
J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-460mA-R01.mat',waves);  plot(waves,J_lip,'r','LineWidth',2);	
% J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-460mA-R02.mat',waves);  plot(waves,J_lip,'r','LineWidth',2);	
J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-910mA-R01.mat',waves);  plot(waves,J_lip,'k','LineWidth',2);
% J_lip = ieReadSpectra('spd-2024-03-08-J-lip-415nm450spf-910mA-R02.mat',waves);  plot(waves,J_lip,'k','LineWidth',2);

title('Joyce');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);

% After lunch
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_80mA-R01.mat',waves); figure; plot(waves,J_tongue,'b','LineWidth',2); hold on;
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_80mA-R02.mat',waves);    plot(waves,J_tongue,'b','LineWidth',2);
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_170mA-R01.mat',waves);    plot(waves,J_tongue,'g','LineWidth',2);	
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_170mA-R02.mat',waves);    plot(waves,J_tongue,'g','LineWidth',2);	
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_460mA-R01.mat',waves);    plot(waves,J_tongue,'r','LineWidth',2);	
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_460mA-R02.mat',waves);    plot(waves,J_tongue,'r','LineWidth',2);	
J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R01.mat',waves);    plot(waves,J_tongue,'k','LineWidth',2);
% J_tongue = ieReadSpectra('spd-2024-03-08-Jafter-tongue-415nm450spf_910mA-R02.mat',waves);    plot(waves,J_tongue,'k','LineWidth',2);

J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_80mA-R01.mat',waves);   figure; plot(waves,J_lip,'b','LineWidth',2); hold on;
% J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_80mA-R02.mat',waves);   plot(waves,J_lip,'b','LineWidth',2);
J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_170mA-R02.mat',waves);   plot(waves,J_lip,'g','LineWidth',2);	
% J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_170mA-R01.mat',waves);   plot(waves,J_lip,'g','LineWidth',2);	
J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_460mA-R02.mat',waves);   plot(waves,J_lip,'r','LineWidth',2);	
%J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_460mA-R01.mat',waves);   plot(waves,J_lip,'r','LineWidth',2);	
J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_910mA-R01.mat',waves);   plot(waves,J_lip,'k','LineWidth',2);
% J_lip = ieReadSpectra('spd-2024-03-08-Jafter-lip-415nm450spf_910mA-R02.mat',waves);   plot(waves,J_lip,'k','LineWidth',2);

title('Joyce');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);


