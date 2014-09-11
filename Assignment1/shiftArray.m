function Y = shiftArray(X,i,j)

Y = zeros(size(X));

if(i>0) 
%str = 'positive i'
Y(i+1:end,:) = X(1:end-i,:);    
end

if(i<0)
%str = 'negative i'
Y(1:end+i,:) = X(-1*i+1:end,:); 
end

if(j>0) 
%str = 'positive j'
Y(:,j+1:end) =  X(:,1:end-j);   
%size(Y(:,j:end,:))
%size(X(:,1:end-j+1))
end

if(j<0)
%str = 'negative j'
%size(Y(:,1:end+j+1))   
%size(X(:,-1*j:end))

Y(:,1:end+j) = X(:,-1*j+1:end); 
end





