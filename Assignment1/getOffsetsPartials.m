function [i,j,theta, errors] = getOffsetsPartials( img1, img2, SHIFT_RANGE )



THETA_RANGE = 2;  %The range of values through which we search, ie
                  %[-THETA_RANGE,THETA_RANGE].
                  %Default value, could be made bigger/smaller depending on
                  %results, but 2 worked fine here.
                  %SHIFT_RANGE works the same way, but is passed as an
                  %argument for convenience.
                  
steps = 2;        %Number of translation steps per index. ie 2 means that
                  %we check each half-pixel translation
theta_steps = 4;  %Number of rotation steps per index. ie 4 means that
                  %we check each quarter-degree rotation
                  
errors = zeros(SHIFT_RANGE*2+1,SHIFT_RANGE*2+1,THETA_RANGE*2);

for i = .5:1/steps:2*SHIFT_RANGE
    for j = .5:1/steps:2*SHIFT_RANGE
        
        
        img2temp = shiftArrayI(img2,i-SHIFT_RANGE-1/steps); 
        img2temp = shiftArrayJ(img2temp, j-SHIFT_RANGE-1/steps);
        %shift by the desired amount
       
              
        for theta = 1/theta_steps:1/theta_steps:2*THETA_RANGE
            
        img2tempRotate = imrotate(img2temp,theta-THETA_RANGE-1/theta_steps,'crop');
        %rotate by the desired amount
        
        
        intermediate = abs(img1-img2tempRotate);
        errors(steps*i,steps*j,theta_steps*theta) = sum(intermediate(:).^2);
        %bookkeeping steps to calculate and store error of this particular
        %configuration
        
        
        end
    end
end




[minval, idx] = min(errors(:));
[i, j, theta] = ind2sub(size(errors), idx);
%get indices corresponding to smallest error
figure, imagesc(errors(:,:,theta))

i = i/steps-SHIFT_RANGE-1/steps
j = j/steps-SHIFT_RANGE-1/steps
theta = theta/theta_steps-THETA_RANGE-1/theta_steps
%transform indices back to actual values to return



