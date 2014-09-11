function [retI,retJ] = findBiggestEntropy(img, stepSize)

[m,n] = size(img);

remainderI = mod(m,stepSize);
remainderJ = mod(n,stepSize);
maxEntropy = 0;
for i = 1:stepSize:m-stepSize-remainderI
    for j = 1:100:n-stepSize-remainderJ
        
        
        if(entropy(img(i:i+stepSize,j:j+stepSize))>maxEntropy)
            retI = i;
            retJ = j;
        end
    end
end