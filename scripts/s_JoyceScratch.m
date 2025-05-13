% s_JoyceScratch.m

% This script fits a positively skewed normal distribution to each
% fluorophore.  We plot to get an sense of how well the fits are

%{
cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /Users/joyce/Github/isetfluorescence;
addpath(genpath(pwd));
cd /Users/joyce/Github/oraleye/;
addpath(genpath(pwd));
cd /Users/joyce/Github/oe_tongue_lip/;
addpath(genpath(pwd));
%}

%% Summary
% For keratin: 
%   Wu & Qu peak at 475
%   Palero peak at 475
%   Valdez peak at 500
%   note also that Palero reports similarity between keratin and NADH
%   emissions
% For collagen: Monici, DaCosta and Alfano are similar with peak ~400 nm
%   Wu & Qu has peak around 475 nm - so don't use Wu & Qu ??
%   Lin and Palero do not have good fits
% For FAD: 
%   DaCosta, Palero peaks at 525
%   Monici, Lin, Alfano peaks at 550
%   Valdez > 550

% For Keratin
%   try Palero and collagen1 (DaCosta)
% For collagen
%   try DaCosta, Monici and Alfano
% For FAD 
%   Try DaCosta and Lin or some variation


%%

wave = 350:5:700;
thisF = fiReadFluorophore('KeratinWuQu','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
KeratinWuQEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r-',...
wave,KeratinWuQEstimate,'bo-', 'LineWidth',2);
legend({'Keratin emission: Wu&Qu','estimate'});
grid on;
set(gca,'fontsize',16);

thisF = fiReadFluorophore('KeratinValdez','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
estimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r-',...
wave,estimate,'bo-', 'LineWidth',2);
legend({'Keratin emission: Valdez','estimate'});
grid on;
set(gca,'fontsize',16);

thisF = fiReadFluorophore('KeratinPena','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
estimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r-',...
wave,estimate,'bo-', 'LineWidth',2);
legend({'Keratin emission: Pena','estimate'});
grid on;
set(gca,'fontsize',16);

thisF = fiReadFluorophore('keratin_webfluor','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
estimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r-',...
wave,estimate,'bo-', 'LineWidth',2);
legend({'Keratin emission: DaCosta','estimate'});
grid on;
set(gca,'fontsize',16);

thisF = fiReadFluorophore('KeratinPalero','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
estimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r-',...
wave,estimate,'bo-', 'LineWidth',2);
legend({'Keratin emission: Palero','estimate'});
grid on;
set(gca,'fontsize',16);


thisF = fiReadFluorophore('NADPHPalero','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
estimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r-',...
wave,estimate,'bo-', 'LineWidth',2);
legend({'NADH emission: Palero','estimate'});
grid on;
set(gca,'fontsize',16);


wave = 350:5:700;
thisF = fiReadFluorophore('KeratinWuQu','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
KeratinWuQEstimate = ieSkewedGaussian(params,wave);
thisF = fiReadFluorophore('KeratinValdez','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
KeratinValdezEstimate = ieSkewedGaussian(params,wave);
thisF = fiReadFluorophore('KeratinPalero','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
KeratinPaleroEstimate = ieSkewedGaussian(params,wave);
thisF = fiReadFluorophore('NADPHPalero','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
NADPHPaleroEstimate = ieSkewedGaussian(params,wave);

ieFigure;
plot(wave, KeratinWuQEstimate,'r','LineWidth',2); hold on;
plot(wave, KeratinValdezEstimate,'g','LineWidth',2); hold on;
plot(wave, KeratinPaleroEstimate,'b','LineWidth',2); hold on;
plot(wave, NADPHPaleroEstimate,'b--','LineWidth',2); hold on;
legend({'KeratinWuQEstimate','KeratinValdezEstimate', 'KeratinPaleroEstimate','NADPHPaleroEstimate'});
grid on;
set(gca,'fontsize',16);

%% Collagen

thisF = fiReadFluorophore('collagen1','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
CollagenDaCostaEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,CollagenDaCostaEstimate,'r--','LineWidth',2); title('Collagen: DaCosta');

thisF = fiReadFluorophore('CollagenLin','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
CollagenLinEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,CollagenLinEstimate,'r--','LineWidth',2); title('Collagen: Lin');

thisF = fiReadFluorophore('CollagenAlfano','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
CollagenAlfanoEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,CollagenAlfanoEstimate,'r--','LineWidth',2); title('Collagen: Alfano');

thisF = fiReadFluorophore('CollagenWuQu','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
CollagenWuQuEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,CollagenWuQuEstimate,'r--','LineWidth',2); title('Collagen: WuQu');

thisF = fiReadFluorophore('CollagenPalero','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
CollagenPaleroEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,CollagenPaleroEstimate,'r--','LineWidth',2); title('Collagen: Palero');

thisF = fiReadFluorophore('CollagenMonici','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
CollagenMoniciEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,CollagenMoniciEstimate,'r--','LineWidth',2); title('Collagen: Monici');

ieFigure;
plot(wave, CollagenLinEstimate,'r','LineWidth',2); hold on;
plot(wave, CollagenAlfanoEstimate,'g','LineWidth',2); hold on;
plot(wave, CollagenWuQuEstimate,'b','LineWidth',2); hold on;
plot(wave, CollagenPaleroEstimate,'k','LineWidth',2); hold on;
plot(wave, CollagenMoniciEstimate,'k--','LineWidth',2); hold on;
legend({'Lin','Alfano', 'WuQu','Palero','Monici'});
grid on;
set(gca,'fontsize',16);
title('Collagen Positively Skewed Gaussian Fits');


ieFigure;
plot(wave, CollagenLinEstimate/max(CollagenLinEstimate(:)),'r','LineWidth',2); hold on;
plot(wave, CollagenAlfanoEstimate/max(CollagenAlfanoEstimate(:)),'g','LineWidth',2); hold on;
plot(wave, CollagenWuQuEstimate/max(CollagenWuQuEstimate(:)),'b','LineWidth',2); hold on;
plot(wave, CollagenPaleroEstimate/max(CollagenPaleroEstimate(:)),'k','LineWidth',2); hold on;
plot(wave, CollagenMoniciEstimate/max(CollagenMoniciEstimate(:)),'k--','LineWidth',2); hold on;
legend({'Lin','Alfano', 'WuQu','Palero','Monici'});
grid on;
set(gca,'fontsize',16);
title('Collagen Positively Skewed Gaussian Fits');

%% FAD
thisF = fiReadFluorophore('FADValdez','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
FADValdezEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,FADValdezEstimate,'r--','LineWidth',2); title('FAD: Valdez');

thisF = fiReadFluorophore('FAD_webfluor','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
FAD_webfluorEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,FAD_webfluorEstimate,'r--','LineWidth',2); title('FAD: DaCosta');

thisF = fiReadFluorophore('FADLin','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
FADLinEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,FADLinEstimate,'r--','LineWidth',2); title('FAD: Lin');

thisF = fiReadFluorophore('FADAlfano','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
FADAlfanoEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,FADAlfanoEstimate,'r--','LineWidth',2); title('FAD: Alfano');

thisF = fiReadFluorophore('FADPalero','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
FADPaleroEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,FADPaleroEstimate,'r--','LineWidth',2); title('FAD: Palero');

thisF = fiReadFluorophore('FADMonici','wave',wave);
emission = fluorophoreGet(thisF,'emission');
params = oeSolveSkewedGaussianCGPT(wave,emission);
FADMoniciEstimate = ieSkewedGaussian(params,wave);
ieFigure; plot(wave,emission,'r','LineWidth',2); hold on;
plot(wave,FADMoniciEstimate,'r--','LineWidth',2); title('FAD: Monici');

ieFigure;
plot(wave, FADValdezEstimate/max(FADValdezEstimate(:)),'r','LineWidth',2); hold on;
plot(wave, FAD_webfluorEstimate/max(FAD_webfluorEstimate(:)),'g','LineWidth',2); hold on;
plot(wave, FADLinEstimate/max(FADLinEstimate(:)),'b','LineWidth',2); hold on;
plot(wave, FADAlfanoEstimate/max(FADAlfanoEstimate(:)),'c','LineWidth',2); hold on;
plot(wave, FADPaleroEstimate/max(FADPaleroEstimate(:)),'k','LineWidth',2); hold on;
plot(wave, FADMoniciEstimate/max(FADMoniciEstimate(:)) ,'k--','LineWidth',2); hold on;
legend({'Valdez','DaCosta', 'Lin', ...
    'Alfano','Palero','Monici'});
title('FAD Positively Skewed Gaussian Fits');
grid on;
set(gca,'fontsize',16);