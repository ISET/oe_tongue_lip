function fluorophores = oeApplyBlood(fluorophores,fluorophoreNames,oxyblood)
% Apply the blood transmittance to collagen and elastin
%
% Synopsis
%
% Input
%
% Output
%
% Description
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
