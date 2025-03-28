function fluorophores = oeApplyBlood(fluorophores,fluorophoreNames,oxyblood)
% Apply the blood transmittance to collagen and elastin
%
% Synopsis
%
% Input
%   fluorophores - Matrix with fluorophores in the columns
%   fluorophoreNames - collagen and elastin get the blood
%   oxyblood - medium type object defining blood
%
% Output
%   fluorophores - Matrix with modified fluorophores
%
% Description
%   We apply the bloody transmittance, defined by the od of the oxyblood
%   object, to the collagen and elastin columns of the fluorophore matrix.
%
%
% See also
%

transmittance = oxyblood.transmittance;


for ii = 1:numel(fluorophoreNames)
    if contains(lower(fluorophoreNames{ii}),'collagen') || ...
            contains(lower(fluorophoreNames{ii}),'elastin')
        fluorophores(:,ii) = fluorophores(:,ii).* transmittance(:);
    end
end

end
