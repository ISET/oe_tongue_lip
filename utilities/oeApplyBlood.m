function [fluorophores, fluorophoreNames] = oeApplyBlood(fluorophores,fluorophoreNames,oxyblood,varargin)
% Apply the blood transmittance to collagen and elastin
%
% Synopsis
%   [fluorophores, fluorophoreNames] = oeApplyBlood(fluorophores,fluorophoreNames,oxyblood,varargin)
%
% Input
%   fluorophores - Matrix with fluorophores in the columns
%   fluorophoreNames - collagen and elastin get the blood
%   oxyblood - medium type object defining blood
%
% Output
%   fluorophores - Matrix with modified fluorophores
%   fluorophoreNames - Names with any appended deoxy
%
% Description
%   We apply the bloody transmittance, defined by the od of the oxyblood
%   object, to the collagen and elastin columns of the fluorophore matrix.
%   Typically, we just change the fluorophore by applying oxy blood
%   transmittance.  But if the user sends in a deoxy parameter, then we
%   also create an additional column with the deoxy transmittance applied.
%
% See also
%

% Example:
%{
  oeApplyBlood(FMatrix,FNames,oxyblood,'deoxy',deoxyblood);
%}

p = inputParser;
p.addRequired('fluorophores',@ismatrix);
p.addRequired('fluorophoreNames',@iscell);
p.addRequired('oxyblood',@(x)(isa(x,'medium')));
p.addParameter('deoxy',[],@(x)(isa(x,'medium')));

p.parse(fluorophores,fluorophoreNames,oxyblood,varargin{:});
deoxyblood = p.Results.deoxy;

oxyTransmittance = oxyblood.transmittance;

for ii = 1:numel(fluorophoreNames)
    if contains(lower(fluorophoreNames{ii}),'collagen') || ...
            contains(lower(fluorophoreNames{ii}),'elastin')
        % Change the existing column with the oxyTransmittance
        fluorophores(:,ii) = fluorophores(:,ii).* oxyTransmittance(:);
        fluorophoreNames{ii} = [fluorophoreNames{ii},'-oxy'];
        if ~isempty(deoxyblood)
            % We add a new column with the deoxy version and append it to
            % the fluorophores matrix.  We add the name, as well.
            fluorophores = cat(2,fluorophores,...
                fluorophores(:,ii).*deoxyblood.transmittance);
            fluorophoreNames{end+1} = [fluorophoreNames{ii}(1:(end-4)),'-deoxy']; %#ok<AGROW>
        end
    end
end
end
