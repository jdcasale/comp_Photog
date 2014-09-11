function [i,j,theta] = pyramidFind(img1, img2)


I11 = impyramid(img1, 'reduce');
I12 = impyramid(I11, 'reduce');
I13 = impyramid(I12, 'reduce');
I14 = impyramid(I13, 'reduce');
I15 = impyramid(I14, 'reduce');

I21 = impyramid(img2, 'reduce');
I22 = impyramid(I21, 'reduce');
I23 = impyramid(I22, 'reduce');
I24 = impyramid(I23, 'reduce');
I25 = impyramid(I24, 'reduce');

[i,j,theta] = getOffsetsPartials(I15,I25, 25);

I24 = shiftArrayI(double(I24),i);  %shift in the horizontal direction
I24= shiftArrayJ(I24,j);  %shift in the vertical direction
I24 = imrotate(I24,theta, 'crop')  %rotate and crop to keep 
                                                    %size constant
                                                 
[i,j,theta] = getOffsetsPartials(I14,I24, 10);
I23 = shiftArrayI(double(I23),2*i);  
I23= shiftArrayJ(I23,2*j);  
I23 = imrotate(I23,theta, 'crop')

[i,j,theta] = getOffsetsPartials(I13,I23, 10);
I22 = shiftArrayI(double(I22),i);  
I22= shiftArrayJ(I22,j);  
I22 = imrotate(I22,theta, 'crop')

[i,j,theta] = getOffsetsPartials(I12,I22, 10);
I21 = shiftArrayI(double(I21),2*i);  
I21= shiftArrayJ(I21,2*j);  
I21 = imrotate(I21,theta, 'crop')
[i,j,theta] = getOffsetsPartials(I11,I21,10);


%imshow(I0)
%figure, imshow(I1)
%figure, imshow(I2)
%figure, imshow(I3)
%figure, imshow(I4)
%figure, imshow(I5)