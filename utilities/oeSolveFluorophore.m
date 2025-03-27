function [Foxy, wgtsNN, oxyblood] = oeSolveFluorophore(F, FNames, inData, wave)
% Solve for oxy blood optical density and weights to fit fluorescent inData
%
% Synopsis
%   [Foxy, wgtsNN, oxyblood] = oeSolveFluorophore(F, FNames, inData)
%
% Brief description:
%   We start with a matrix of fluorophore excitations, F, and the names of
%   each column, FNames.  We search for the blood optical density such that
%   applying the blood to F, yielding FOxy
%
% Inputs:
%   F - (w x n) matrix of fluorophore excitations
%   FNames - cell array of fluorophore names
%   inData - (w x m) matrix of fluorescent data
%   wave   -
%
% Outputs:
%   Foxy     - (w x n) matrix of the fluorophores with blood transmittance
%              multipled into the  relevant (collagen, elastin) fluorophores
%   wgtsNN   - Weights of the FO to fit the inData = FO wgtsNN
%   oxyblood - Medium object of oxyblood with fitted optical density
%

%%
[w, n] = size(F);  % Dimensions of UL
[w_check, m] = size(inData); % Dimensions of UT
assert(w == w_check, 'F and inData must have the same number of rows.');

% Initial guess for Weights (random)
W0 = rand(m, n);
for dd = 1:size(inData,2)
    W0(:,dd) = lsqnonneg(fluorophores,inData(:,dd));
end

% Initial guess for optical density, 
od = 10;

oxyblood = medium('oxy_molarExtinctionCoefficient.mat','wave',wave);

% Define objective function for optimization
    function error = objective_func(params, F, FNames, inData, oxyblood, m, n)
        % The optical density should be positive
        %
        % After fitting

        oxyblood.opticalDensity = params(1);        
        transmittance = oxyblood.transmittance;

        % This should go inside the search
        for ii = 1:numel(FNames)
            if contains(lower(FNames{ii}),'collagen') || ...
                    contains(lower(FNames{ii}),'elastin')
                Foxy(:,ii) = F(:,ii).* transmittance(:);
            else
                Foxy(:,ii) = F(:,ii);
            end
        end


        % Compute the residual error
        residual_error = norm(UL - D * UT * W, 'fro')^2;

        % Constraint penalty for ensuring 0 <= d_values <= 1
        penalty = sum(max(0, d_values - 1).^2) + sum(max(0, -d_values).^2);

        % Total error with penalty
        error = residual_error + 100 * penalty;

    end

% Initial parameter vector (concatenating p0 and W0)
param0 = [od, W0(:)];
% param0 = [p0; W0(:)];

% Solve using fminunc (or fmincon if needed)
options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'Display', 'iter');
param_opt = fminunc(@(params) objective_func(params, F, FNames, m, n), param0, options);

% Extract optimized p and W
p_opt = param_opt(1:num_params);
W_opt = reshape(param_opt(num_params+1:end), [m, n]);

x = linspace(0, 1, w)';
D_diag = polyval(p_opt,x);

end
