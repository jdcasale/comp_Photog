function [i,j,theta, errors] = getOffsets( img1, img2, SHIFT_RANGE )

THETA_RANGE = 5;  %default value

errors = zeros(SHIFT_RANGE*2,SHIFT_RANGE*2,THETA_RANGE*2);
%erros = zeros(500,500);


for i = 1:1:2*SHIFT_RANGE
    for j = 1:1:2*SHIFT_RANGE
        
        
        img2temp = shiftArrayI(img2,i-SHIFT_RANGE-1);%, j-SHIFT_RANGE);
        img2temp = shiftArrayJ(img2temp, j-SHIFT_RANGE-1);
       
              
        
        %errors(i,j) = dot(img1./int16(mean(mean(img2))), img2./int16(mean(mean(img2))));
        for theta = 1:2*THETA_RANGE
            
        img2tempRotate = imrotate(img2temp,theta-THETA_RANGE-1,'crop'); 
   
        
        errors(i,j,theta) = sum(sum(abs(img1-img2tempRotate)));
      
        
       
        %[errors(i,j,theta),garbage] =  ssim_index(img1,img2tempRotate);
        end
    end
end


%z = sqrt(img1.^2 + img2.^2);
%contourf(img1,img2,z)
%figure
%colormap(flipud(jet))

[minval, idx] = min(errors(:))

[i, j, theta] = ind2sub(size(errors), idx);

HeatMap(errors(:,:,1),'Standardize', 1)%,'RowLabels', 'j', 'ColumnLabels', 'j')

%[i,j,theta] = find(errors == min(min(min(errors))));
i = i-SHIFT_RANGE-1
j = j-SHIFT_RANGE-1
theta = theta-THETA_RANGE-1