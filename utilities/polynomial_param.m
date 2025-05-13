function D_diag = polynomial_param(params,nWave)
% Make a polynomial function over the wavelength domain
%
% This will be the diagonal of the matrix. 

indices = 0:(nWave - 1);
D_diag = polyval(params, indices);

end