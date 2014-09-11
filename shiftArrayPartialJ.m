function Y = shiftArrayPartialJ(X,j)

Y = zeros(size(X));

if(j>0) 
    
convulutionVector = [0 1-j j]';
Y = conv2(X,convulutionVector, 'same');

end

if(j<0)
convulutionVector = [-j 1+j 0]';
Y = conv2(X,convulutionVector, 'same');
end

if j == 0
    Y = X;
end
