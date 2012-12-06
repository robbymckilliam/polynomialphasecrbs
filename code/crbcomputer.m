function computer

% the q function, coefficients of the integer valued polynomials
    function out = q(s,i)
        if(s<0 || i <0) 
            out = 0;
        elseif(s==0 && i==0) 
            out = 1;
        elseif(s==0) 
            out = 0;
        else 
            out = q(s-1,i-1)/s - q(s-1,i);
        end
    end
    
    %run some tests on q
    if( q(0,0) ~= 1 ) 
        disp('FAIL 1'); 
    end
    
    
    
end
