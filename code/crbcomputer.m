function vars = crbcomputer(m,N,snrs)
% computes the Cramer-Rao bound (CRB) for the polynomial phase
% coefficients of a polynomial phase signal of order m given N
% observations corrupted by additive white Gaussian noise.  The
% vector snrs is a row vector with the desired values of signal to
% noise ratio (SNR) to CRB at.  The output vars is an m+1 by length(snrs)
% matrix such that vars(i,s) is the CRB for the coefficient of
% order i when the SNR is equal to snrs(s).

% the q function, coefficients of the integer valued polynomials
    function out = q(s,i)
        if(s<0 || i <0) out = 0;
        elseif(s==0 && i==0) out = 1;
        elseif(s==0) out = 0;
        else out = q(s-1,i-1)/s - q(s-1,i); end
    end
    
    %run some tests on q (output from mathematica)
    tol = 1e-15;
    if( q(0,0) ~= 1 ) disp('FAIL 1'); end
    if( q(4,2) ~= 35/24 ) disp('FAIL 2'); end
    if( abs(q(7,1) - 363/140) > tol ) disp(['FAIL 3']); disp( q(7,1) - 363/140);  end
    if( q(11,3) ~= 341747/129600 ) disp('FAIL 4'); end

    %The coefficients of the discrete orthogonal polynomials, you
    %can set N
    function out = P(k,i,N)
        out = 0;
        for s=0:k
            out = out + (-1)^(s+k)*nchoosek(s+k,s)*nchoosek(N-s-1, ...
                                                            N-k-1)*q(s,i);
        end
    end
    
    %run tests on P (output from mathematica)
    if( P(0,0,50) ~= 1 ) disp('FAIL 5'); end
    if( P(1,0,50) ~= -51 ) disp('FAIL 6'); end
    if( P(1,1,50) ~= 2 ) disp('FAIL 7'); end
    if( P(2,1,50) ~= -153 ) disp('FAIL 8'); end
    if( abs(P(4,1,50) - -113900) > tol ) disp('FAIL 9');  end
    if( abs(P(4,1,10) - -3850/3) > tol ) disp('FAIL 10'); end
    if( abs(P(6,3,10) - -13629/4) > tol ) disp('FAIL 11'); end
    
    storedsum = zeros(m+1,1);
    for i=0:m
        for k=0:m
            storedsum(i+1) = storedsum(i+1) + P(k,i,N)^2/nchoosek(2*k,k)/nchoosek(N+k,2*k+1);
        end
    end
    
    vars = storedsum * snrs;
    
end
