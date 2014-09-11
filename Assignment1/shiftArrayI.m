function Y = shiftArrayI(X,i)

Y = zeros(size(X));
steps = 2;

if(i>0) 
convulutionVector = zeros(steps*i+1,1)';
convulutionVector(end)=1;
Y = conv2(X,convulutionVector, 'same');

if(floor(i) ~=i)

   Y = shiftArrayPartialI(Y,i-floor(i)); 
end

end

if(i<0)
convulutionVector = zeros((-steps)*i+1,1)';
convulutionVector(1)=1;
Y = conv2(X,convulutionVector, 'same');

if(ceil(i) ~=i)

   Y = shiftArrayPartialI(Y,i-ceil(i)); 
end

end

if i == 0
    Y = X;
end
