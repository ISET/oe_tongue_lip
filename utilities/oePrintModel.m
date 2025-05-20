function oePrintModel(fluorophoreNames,od,weights,NperSubject)
% Print log10(od), fluorophore weights and N samples for each subject
%
% Synopsis
%   oePrintModel(fluorophoreNames, od, weights, NperSubject)
%
% Input
%   fluorophoreNames - A string, like ["name1","name2", ...];  If it is a
%                      cell array I will convert it to a string array.
%   od       - Optical density for each subject
%   weights  - cell array of the matrices of weights.  Each row is a tissue
%              type and each column is a weight corresponding to each of
%              the fluorophores
%   NperSubject - number of measurements for each subject
%
% Return
%   N/A
%
% Description
%    The printout includes mean weights and standard deviation.
%
% See also
%   oeFigure5_ModelFits

if iscell(fluorophoreNames), fluorophoreNames = string(fluorophoreNames); end

nSubjects = numel(weights);
meanWeights = cell(nSubjects,1);
stdWeights = cell(nSubjects,1);

for ii=1:nSubjects
    meanWeights{ii} = mean(weights{ii},2);
    stdWeights{ii} = std(weights{ii},0,2);
end

% Print them out
% fluorophoreNames = ["Collagen", "FAD", "Keratin", "Porphyrin", "Chlorophyll-a"];
for ii = 1:nSubjects
    fprintf('Subject %d (N=%d):\n', ii,NperSubject(ii));
    fprintf('Blood log10(od) %0.2f  ',log10(od(ii)));
    for jj = 1:size(meanWeights{ii}, 1)
        fprintf('%s: %.2f %c %.2f ', fluorophoreNames(jj), meanWeights{ii}(jj), char(177), stdWeights{ii}(jj));
    end
    fprintf('\n\n'); % Add extra newline for separation between matrices
end

end