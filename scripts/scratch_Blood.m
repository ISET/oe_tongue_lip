% Scratch blood

%%
oxyHemoglobin = medium('oxyHemoglobin.mat','wave',400:700);
oxyHemoglobin.comment
ieNewGraphWin;
odValues = logspace(-2,0,10);
for od = odValues
    oxyHemoglobin.opticalDensity = od;
    oxyHemoglobin.plot('absorptance');
    hold on;
end
legend(cellstr(num2str(odValues')));

%%
tst = ieReadSpectra('OxyHemoglobinAbsorption',400:700);
hold on; plot(400:700,tst/max(tst(:)),'k-');