function Y = shiftArrayPartialI(X,i)

Y = zeros(size(X));

if(i>0) 

convulutionVector = [0 1-i i];
Y = conv2(X,convulutionVector, 'same');

end

if(i<0)
convulutionVector =[-i i+1 0];
Y = conv2(X,convulutionVector, 'same');
end

if i == 0
    Y = X;
end
