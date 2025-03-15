function [data, normalized] = oeReadFiles(filelist,varargin)
% Read the spectral data
%
% Inputs
%  filelist
%
% Optional key/val
%   waves  - Wavelength samples (nm)
%   normalized wave - If empty, no normalization.  Otherwise normalize by
%                     the value at this wavelength (Default: empty)
%
% Return
%   data -     - Data in the columns.  Units are energy (watts/sr/nm/m2)
%   normalized - Normalization value at nwave
%
% See also
%   oeFigure1_compareSubjects


%%
varargin = ieParamFormat(varargin);

p = inputParser;
p.addRequired('filelist',@isstring);
p.addParameter('waves',400:5:700,@isvector);
p.addParameter('normalizedwave',[],@isnumeric);
p.parse(filelist,varargin{:});
waves = p.Results.waves;
nwave = p.Results.normalizedwave;

%% Read and normalize the data

data = zeros(numel(waves),numel(filelist));
normalized = zeros(numel(filelist),1);
for ii=1:numel(filelist)
    data(:,ii) = ieReadSpectra(filelist(ii),waves);
    if ~isempty(nwave)
        normalized(ii) = data(waves==nwave,ii);
        data(:,ii) = data(:,ii)/normalized(ii);
    end
end

end

