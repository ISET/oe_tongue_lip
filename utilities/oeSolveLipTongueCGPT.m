function [W_opt, D_diag] = oeSolveLipTongueCGPT(UL, UT, poly_degree)
% SOLVE_MATRIX_EQUATION finds W (m x n) and parameterized diagonal D (w x w)
% such that UL = D * UT * W.
%
% Synopsis
%
% Brief description:
%   Posed to ChatGPT:
%
%   I have an equation I would like to solve. I know two matrices, UL (w x
%   n) and UT (w x m). I think that there might be a matrix W (n x m) and a
%   diagonal matrix, D, (w x w) such that  UL = D UT W.
%
%   I am willing to parameterize the entries of the diagonal D to have
%   fewer parameters than w, say by using a polynomial function with
%   respect to the diagonal entries of D.
% 
%   How can I solve for the parameterized D and the matrix W, given that I
%   know UL and UT?  
%
%   Can you write a Matlab function that searches for the solution?
%
% Inputs:
%   UL - (w x n) matrix
%   UT - (w x m) matrix
%   poly_degree - degree of polynomial to parameterize D
%
% Outputs:
%   W_opt - (m x n) matrix solution
%   p_opt - polynomial coefficients defining D
%
% To find the diagonal, you can use
%  
%{
UL = rand(w, 2);
UT = rand(w, 4);
poly_degree = 8; % degree of the polynomial

[W_opt, D_diag] = oeSolveLipTongueCGPT(UL, UT, poly_degree);

% What did it return for the diagonal?
ieFigure; plot(1:w,D_diag);
disp(W_opt)
tmp = diag(D_diag)*UT*W_opt;
ieFigure; plot(tmp(:),UL(:),'.');
identityLine;
%}

[w, n] = size(UL);  % Dimensions of UL
[w_check, m] = size(UT); % Dimensions of UT
assert(w == w_check, 'UL and UT must have the same number of rows.');

num_params = poly_degree + 1; % Number of polynomial coefficients

% Initial guess for polynomial coefficients (random)
p0 = rand(num_params, 1);

% Initial guess for W (random)
W0 = rand(m, n);

% Define objective function for optimization
    function error = objective_func(params, UL, UT, w, num_params, m, n)
        % The objective function should require that the d_values be
        % between 0 and 1. 

        p = params(1:num_params); % Polynomial coefficients
        W = reshape(params(num_params+1:end), [m, n]); % Reshape W

        % Construct diagonal matrix D based on polynomial parameterization
        y = linspace(0, 1, w)';   % Normalized indices
        d_values = polyval(p, y); % Compute diagonal elements
        D = diag(d_values); % Construct diagonal matrix

        % Compute the residual error
        residual_error = norm(UL - D * UT * W, 'fro')^2;

        % Constraint penalty for ensuring 0 <= d_values <= 1
        penalty = sum(max(0, d_values - 1).^2) + sum(max(0, -d_values).^2);

        % Total error with penalty
        error = residual_error + 100 * penalty;

    end

% Initial parameter vector (concatenating p0 and W0)
param0 = [p0; W0(:)];

% Solve using fminunc (or fmincon if needed)
options = optimoptions('fminunc', 'Algorithm', 'quasi-newton', 'Display', 'iter');
param_opt = fminunc(@(params) objective_func(params, UL, UT, w, num_params, m, n), param0, options);

% Extract optimized p and W
p_opt = param_opt(1:num_params);
W_opt = reshape(param_opt(num_params+1:end), [m, n]);

x = linspace(0, 1, w)';
D_diag = polyval(p_opt,x);

end
