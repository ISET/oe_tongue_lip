% s_nmfAnalysis.m

%   Purpose: derive non-negative principal components 

%% set paths

cd /Users/joyce/Github/isetcam;
addpath(genpath(pwd));
cd /Users/joyce/Github/isetfluorescence;
addpath(genpath(pwd));
cd /Users/joyce/Github/oraleye/;
addpath(genpath(pwd));

ieInit;


%% TO ANALYZE
% FOR EFFECT OF EXCITATION LIGHT (appears not to be an effect, but could
% analyze later)- see s_LipAFI4difLights.m
%   data for joyce Lip and tongue 405, 415, 450 2024-03-12 (collected by
%   Molly, no comments, but data indicate that the PR670 had a 475 nm
%   longpass filter

%   data for Zhenyi Lip and tongue 405, 415, 450 2024-03-12

% FOR PLOTTING PREDICTED REFLECTANCE
%   data for noise 
%   white target with 405, 415 and 450 nm lights and 
%   450 shortpass filter, measured with PR670 and 475 nm longpass filter

%%
% Transferred the data to local for convenience



% 415 nm light, different levels, tongue and lowerlip
% data for brian and zhenyi in Lab Measurements/2024-03-07 (415nm Tongue+lip measurements
% data for joyce and doug in Lab Measurements/2024-03-08 (415nm Tongue+lip measurements
datadir = fullfile(oreyeRootPath,'local','data','20240307'); 

allData = [];
wave = 500:5:705;

%%
zhenyiTongueFiles = dir(fullfile(datadir,'zhenyi/*Tongue*'));
thisData = zeros(numel(wave),numel(zhenyiTongueFiles));
for ii=1:numel(zhenyiTongueFiles)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'zhenyi',zhenyiTongueFiles(ii).name),wave);
end
zhenyiTongue = thisData;
allData = [allData,thisData];

%%
brianTongue = dir(fullfile(datadir,'brian/*tongue*'));
thisData = zeros(numel(wave),numel(brianTongue));
for ii=1:numel(brianTongue)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'brian',brianTongue(ii).name),wave);
end
brianTongue = thisData;
allData = [allData,thisData];

%%
joyceTongue = dir(fullfile(datadir,'joyce1/*tongue*'));
thisData = zeros(numel(wave),numel(joyceTongue));
for ii=1:numel(joyceTongue)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'joyce1',joyceTongue(ii).name),wave);
end
joyceTongue = thisData;
allData = [allData,thisData];

%%
dougTongue = dir(fullfile(datadir,'doug/*tongue*'));
thisData = zeros(numel(wave),numel(dougTongue));
for ii=1:numel(dougTongue)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'doug',dougTongue(ii).name),wave);
end
dougTongue = thisData;
allData = [allData,thisData];

%%
% Basis = nnmf(allData,k);
% H is a kxn matrix where n is the original number of columns in allData, and k is the number of factors;
%{
ieNewGraphWin;
plot(wave,allData,'k','LineWidth',2); hold on;
title('Tongue Fluorescence (N =4) ');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);
%}
[rows,cols] = size(allData);
for k = 1:3
    [Basis,H] = nnmf(allData,k);
    total_variance = sum(var(allData));
    approximation = Basis * H;
    explained_variance = sum(var(approximation));
    percent_variance = (explained_variance / total_variance) * 100;
    fprintf('k is %i',k);
    fprintf(' percent var acc for %.2f%%\n',percent_variance);
    figure;
    for jj = 1:cols
        plot(approximation(:,jj),allData(:,jj),'ko','LineWidth',2); hold on;
    end
    title(['Tongue  Nfactors =' num2str(k), '    var acc for ' num2str(percent_variance,4)]);

    fontsize(gca,16,"pixels");
    xlabel('wavelength (nm');
    ylabel('Radiance (energy)');
end

% plot the Factors (Basis)
Basis = ieScale(Basis,1);
ieNewGraphWin;
plot(wave,Basis(:,1),'LineWidth',2,'color','g');
hold on;
plot(wave,Basis(:,2),'LineWidth',2,'color','r');
grid on;
plot(wave,Basis(:,3),'LineWidth',2,'color','b');
grid on;
set(gca,'ylim',[0 1]);
set(gca,'xlim',[400 800]);
set(gca,'fontsize',16);
set(gca,'xtick',400:100:700);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

%{
figure; plot(wave,allData,'k','LineWidth',2)
title('Tongue Fluorescence (N =4;');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);
%}

% All subjects, except joyce after lunch
%% Add in Joyce after lunch
joyceTongue2 = dir(fullfile(datadir,'joyce2/*tongue*'));
thisData = zeros(numel(wave),numel(joyceTongue2));
for ii=1:numel(joyceTongue2)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'joyce2',joyceTongue2(ii).name),wave);
end
joyceTongue2 = thisData;
allData = [allData,thisData];

Basis = nnmf(allData,3);
Basis = ieScale(Basis,1);
ieNewGraphWin;
plot(wave,Basis(:,1),'g','LineWidth',2); hold on;
plot(wave,Basis(:,2),'r','LineWidth',2); hold on;
plot(wave,Basis(:,3),'b','LineWidth',2); hold on;
grid on;
set(gca,'ylim',[0 1]);
set(gca,'xlim',[400 800]);
set(gca,'fontsize',24);
set(gca,'xtick',400:100:700);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

%{
figure; plot(wave,allData,'k','LineWidth',2)
title('Tongue Fluorescence (N =4;');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);
%}

%% Now for the lip

allData = [];

zhenyiLip = dir(fullfile(datadir,'zhenyi/*lip*'));
thisData = zeros(numel(wave),numel(zhenyiLip));
for ii=1:numel(zhenyiLip)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'zhenyi',zhenyiLip(ii).name),wave);
end
zhenyiLip = thisData;
allData = [allData,thisData];

%%
brianLip = dir(fullfile(datadir,'brian/*lip*'));
thisData = zeros(numel(wave),numel(brianLip));
for ii=1:numel(brianLip)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'brian',brianLip(ii).name),wave);
end
brianLip = thisData;
allData = [allData,thisData];

%%
joyceLip = dir(fullfile(datadir,'joyce1/*lip*'));
thisData = zeros(numel(wave),numel(joyceLip));
for ii=1:numel(joyceLip)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'joyce1',joyceLip(ii).name),wave);
end
joyceLip = thisData;
allData = [allData,thisData];

%%
dougLip = dir(fullfile(datadir,'doug/*lip*'));
thisData = zeros(numel(wave),numel(dougLip));
for ii=1:numel(dougLip)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'doug',dougLip(ii).name),wave);
end
dougLip = thisData;
allData = [allData,thisData];

%%
Basis = nnmf(allData,2);
Basis = ieScale(Basis,1);
ieNewGraphWin;
plot(wave,Basis(:,1),'LineWidth',2,'color','g');
hold on;
plot(wave,Basis(:,2),'LineWidth',2,'color','r');
grid on;
set(gca,'ylim',[0 1]);
set(gca,'xlim',[400 800]);
set(gca,'fontsize',16);
set(gca,'xtick',400:100:700);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');

%{
figure; plot(wave,allData,'k','LineWidth',2)
title('Lip Fluorescence (N =4;');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);
%}

% All subjects, except joyce after lunch
%% Add in Joyce after lunch
joyceLip2 = dir(fullfile(datadir,'joyce2/*lip*'));
thisData = zeros(numel(wave),numel(joyceLip2));
for ii=1:numel(joyceLip2)
    thisData(:,ii) = ieReadSpectra(fullfile(datadir,'joyce2',joyceLip2(ii).name),wave);
end
joyceLip2 = thisData;
allData = [allData,thisData];

% only two basis for lip

Basis = nnmf(allData,2);
Basis = ieScale(Basis,1);
ieNewGraphWin;
plot(wave,Basis(:,1),'g','LineWidth',2); hold on;
plot(wave,Basis(:,2),'r','LineWidth',2); hold on;
grid on;
set(gca,'ylim',[0 1]);
set(gca,'xlim',[400 800]);
set(gca,'fontsize',24);
set(gca,'xtick',400:100:700);
xlabel('Wavelength (nm)');
ylabel('Normalized radiance');


%%
%{
figure; plot(wave,allData,'k','LineWidth',2)
title('Lip Fluorescence after lunch(N =4;');
fontsize(gca,16,"pixels");
xlabel('wavelength (nm');
ylabel('Radiance (energy)');	
xlim([400 800]);
%}