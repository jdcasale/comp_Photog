clear;	% Delete all variables.
close all;	% Close all figure windows except those created by imtool.
imtool close all;	% Close all figure windows created by imtool.
workspace;

imread Sample_From_Site_JPG.jpg; %import image file
original_BW_Image = ans; 
original_Dimensions = size(original_BW_Image);
m = original_Dimensions(1);
n = original_Dimensions(2);


a = floor(m/3);                         %crop the picture into thirds,
img1 = original_BW_Image(1:a,:);        %being careful to maintain
img2 = original_BW_Image(a+1:2*a,:);    %consistent matrix dimensions
img3 = original_BW_Image(2*a+1:3*a,:);


cropDist = floor(a/4); %How much of each side of the images are we going to 
                       %crop off to get the areas
                       %off to get the areas for comparison.  Arbitrary
                       %design decision

crop1 = edgeFilter(double(img1(cropDist:end-cropDist,cropDist:end-cropDist)));
crop2 = edgeFilter(double(img2(cropDist:end-cropDist,cropDist:end-cropDist)));
crop3 = edgeFilter(double(img3(cropDist:end-cropDist,cropDist:end-cropDist)));

%[cropOffsetI,cropOffsetJ] = findBiggestEntropy(crop1,0)

[i,j,theta,errors1] = getOffsetsPartials(crop1, crop2 ,10); %calls my script 
                                                            %to return the
                                                            %best fitting 
                                                            %orientation
                                                            %for the given
                                                            %channel
%[i,j,theta] = pyramidFind(crop1, crop2);
                                                            
                                                            
offsetCrop2 = shiftArrayI(double(img2),i);  %shift in the horizontal direction
offsetCrop2 = shiftArrayJ(offsetCrop2,j);  %shift in the vertical direction
offsetCrop2 = imrotate(offsetCrop2,theta, 'crop');  %rotate and crop to keep 
                                                    %size constant


[i,j,theta,errors2] = getOffsetsPartials(crop1, crop3,10); %repeat for the
                                                            %other channel
%[i,j,theta] = pyramidFind(crop1, crop3);

offsetCrop3 = shiftArrayI(double(img3),i);
offsetCrop3 = shiftArrayJ(offsetCrop3,j);
offsetCrop3 = imrotate(offsetCrop3,theta, 'crop');


RGBPic = cat(3,uint8(offsetCrop3),uint8(offsetCrop2),uint8(img1)); 
%concatenate the three channels into a color image     
figure
image(RGBPic);

