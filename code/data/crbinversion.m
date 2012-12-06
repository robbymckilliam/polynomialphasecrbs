function vars = crbinversion(m,N,snrs)
% computes the Cramer-Rao bound (CRB) for the polynomial phase
% coefficients of a polynomial phase signal of order m given N
% observations corrupted by additive white Gaussian noise.  The
% vector snrs is a row vector with the desired values of signal to
% noise ratio (SNR) to CRB at.  The output vars is an m+1 by length(snrs)
% matrix such that vars(i,s) is the CRB for the coefficient of
% order i when the SNR is equal to snrs(s).
%
% This attemps to invert the Fisher information matrix.  It's often
% not numerically stable!

%construct Vandermonde matrix
V = zeros(m+1,N);
for k=0:m
    V(k+1,:)=(1:N).^k;
end

%construct Fisher information matrix
F = V*V';

vars = diag(inv(F)) * snrs;

end