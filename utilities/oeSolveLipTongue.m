function [optimized_params, optimized_S] = oeSolveLipTongue(UL, UT, param_func, initial_params, initial_S)
% Solves UL = D UT S, with parameterized D, using optimization.
%
%
% Args:
%     UL: Basis function for the lip (w x 2 matrix).
%     UT: Basis function for the tongue (w x 4 matrix).
%     diag_func: Function handle that takes polynomial parameters and
%         returns the diagonal of D. 
%     initial_params: Initial parameters for D, the diagonal filter.
%     initial_S: Initial guess for S the matrix of weights
%
% Returns:
%     Optimized parameters and S.


% Example usage (assuming UL and UT are already defined in your workspace)
%{
w = 100;
UL = rand(w, 2);
UT = rand(w, 4);

degree = 3; % degree of the polynomial
initial_params = rand(degree + 1, 1);
initial_S = rand(4, 2);

[params, S] = oeSolveLipTongue(UL, UT, @polynomial_param, initial_params, initial_S);

disp('Optimized Parameters:');
disp(params);
disp('Optimized S:');
disp(S);
%}

    function error = error_func(x, UL_local, UT_local,initial_params_local) % Corrected: Added UL_local, UT_local
        params = x(1:length(initial_params_local));
        S = reshape(x(length(initial_params_local) + 1:end), 4, 2);
        D_diag = polynomial_param(params, size(UL_local,1)); % Pass UL and UT to param_func
        D = diag(D_diag);
        error = norm(UL_local - D * UT_local * S, 'fro');
    end

% Flatten initial parameters of the polynomial used to define the diagonal
% The second set are the weights (S) that will be the matrix.  They should
% 4 x 2 (8).  If we change the dimensions of the bases we need to change
% this as well.
initial_x = [initial_params(:); initial_S(:)]; 

options = optimoptions('fminunc', 'Algorithm', 'quasi-newton'); % You can change the algorithm
error_func_handle = @(x) error_func(x, UL, UT);
optimized_x = fminunc(error_func_handle, initial_x, options);

optimized_params = optimized_x(1:length(initial_params));
optimized_S = reshape(optimized_x(length(initial_params) + 1:end), 4, 2);

end

%% Example parameterization (polynomial)



