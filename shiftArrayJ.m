function Y = shiftArrayJ(X,j)

Y = zeros(size(X));
steps = 2;

if(j>0) 
convulutionVector = zeros(steps*j+1,1);
convulutionVector(end)=1;
Y = conv2(X,convulutionVector, 'same');

if(floor(j) ~=j)
 
   Y = shiftArrayPartialJ(Y,j-floor(j)); 
end

end

if(j<0)
convulutionVector = zeros((-steps)*j+1,1);
convulutionVector(1)=1;
Y = conv2(X,convulutionVector, 'same');

if(ceil(j) ~=j)
    
   Y = shiftArrayPartialJ(Y,j-ceil(j)); 
end


end

if j ==0
    Y = X;
end
