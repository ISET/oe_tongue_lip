% s_FluorophoreBasis.m
%
% Load the key fluorophores.  Check them.  Notice the very different curves
% from the literature if we summarize them just by the reported emissions.s
% 
% We will save a matrix whose columns are the normalized emission spectra
% of a large number fluorophores read from the literature.
%

%%
ieInit;

%%  These are current fluorophores from the literature
fluorophoreNames = {...
    'ElastinAlfano','elastin_webfluor','ElastinMonici','ElastinPalero',...
    'CollagenAlfano', 'CollagenMonici','CollagenPalero','CollagenWuQu',...
    'KeratinPalero','KeratinPena','KeratinWuQu','keratin_webfluor',...
    'FAD_webfluor','FADAlfano','FADBecker','FADMonici',...
    'NADH_webfluor','NADHAlfano','NADHMonici'};

% Not sure what to do with this.
% 'NADPHPalero',...

for ff = 1:numel(fluorophoreNames)    
    if ~exist([fluorophoreNames{ff},'.mat'],'file')
        fprintf('Missing %s\n',fluorophoreNames{ff})
    end
end

%% Let's fit this one, but only for wavelengths above 480 nm
wave = 400:705;

%% Elastin
figHdl = ieNewGraphWin;
for ff = 1:4
    thisF = fiReadFluorophore(fluorophoreNames{ff},'wave',wave);
    fluorophorePlot(thisF,'emission','fighdl',figHdl); hold on;
end
legend(fluorophoreNames{1:4});

%% Collagen
figHdl = ieNewGraphWin;
for ff = 5:8
    thisF = fiReadFluorophore(fluorophoreNames{ff},'wave',wave);
    fluorophorePlot(thisF,'emission','fighdl',figHdl); hold on;
end
legend(fluorophoreNames{5:8});

%% Keratin
figHdl = ieNewGraphWin;
for ff = 9:12
    thisF = fiReadFluorophore(fluorophoreNames{ff},'wave',wave);
    fluorophorePlot(thisF,'emission','fighdl',figHdl); hold on;
end
legend(fluorophoreNames{9:12});

%% FAD
figHdl = ieNewGraphWin;
for ff = 13:16
    thisF = fiReadFluorophore(fluorophoreNames{ff},'wave',wave);
    fluorophorePlot(thisF,'emission','fighdl',figHdl); hold on;
end
legend(fluorophoreNames{12:15});

%% NADH
figHdl = ieNewGraphWin;
for ff = 17:19
    thisF = fiReadFluorophore(fluorophoreNames{ff},'wave',wave);
    fluorophorePlot(thisF,'emission','fighdl',figHdl); hold on;
end
legend(fluorophoreNames{16:18});

%%  See how to make a matrix in s_oeBloodFluorophoreBasis.mlxs


%% Have a look at the EEMs for the flourophores
%
% Notice that a couple of them are relatively weak above 450/475 where we
% have the measurements.  But those may be the ones we are seeing.
%{
fluorophorePlot(keratin,'eem');
fluorophorePlot(FAD,'eem');
fluorophorePlot(collagen,'eem');
fluorophorePlot(porphyrins,'eem');
%}
% %%
% fBasis = ...
%     [keratin.emission/max(keratin.emission(:)), ...
%     FAD.emission/max(FAD.emission(:)), ...
%     collagen.emission/max(collagen.emission(:)), ...
%     porphyrins.emission/max(porphyrins.emission(:))];
% % ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); set(gca,'fontsize',16);
% % Find the weights from fluorophores to the full data
% % data = fBasis*wgts, but the weights must be non-negative
% cols = 1:3;
% wgts = lsqnonneg(fBasis(:,cols),data);
% % wgts = pinv(fBasis(:,1:3))*data;
% 
% %% for lip, only two basis functions?
% 
% fname = 'spd-2024-03-07-B-tongue-415nm450SPF-910mA-R01.mat';
% wave = 500:5:600;
% [data,wave] = ieReadSpectra(fullfile(dataDir,fname),wave);
% 
% fBasis = [FAD.emission/max(FAD.emission(:)), collagenWuAndQu/max(collagenWuAndQu(:))];
% % ieNewGraphWin; plot(wave,fBasis,'LineWidth',2); legend('FAD','collagen'); set(gca,'fontsize',16);
% % Find the weights from fluorophores to the full data
% % data = fBasis*wgts, but the weights must be non-negative
% cols = 1:2;
% wgts = lsqnonneg(fBasis(:,cols),data);
% % wgts = pinv(fBasis(:,1:3))*data;
% 
% ieNewGraphWin;
% plot(wave,data,'g-',wave,fBasis(:,cols)*wgts,'k:')
% 
% % Choose the OD to minimize this?
% rmse(fBasis(:,cols)*wgts,data)
% disp(fname)
% disp(wgts)