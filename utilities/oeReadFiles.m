function [data, normalized] = oeReadFiles(filelist,varargin)
% Read the spectral data
%
% Inputs
%  filelist
%
% Optional key/val
%   waves
%   normalized wave
%
% Return
%   data 
%   normalized
%
% See also
%


%%
varargin = ieParamFormat(varargin);

p = inputParser;
p.addRequired('filelist',@isstring);
p.addParameter('waves',500:5:700,@isvector);
p.addParameter('normalizedwave',580,@isnumeric);
p.parse(filelist,varargin{:});
waves = p.Results.waves;
nwave = p.Results.normalizedwave;

%% Read and normalize the data

data = zeros(numel(waves),numel(filelist));
normalized = zeros(numel(filelist),1);
for ii=1:numel(filelist)
    data(:,ii) = ieReadSpectra(filelist(ii),waves);
    normalized(ii) = data(waves==nwave,ii);
    data(:,ii) = data(:,ii)/normalized(ii);
end

end

