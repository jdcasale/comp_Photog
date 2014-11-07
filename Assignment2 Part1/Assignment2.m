RESIZE_FACTOR = .25;
img1 = im2double(imread('penguinchick.jpeg'));
img1 = imresize(img1,RESIZE_FACTOR);
                %read in a sample source image
                %resize so that we can fit it appropriately
                %in the target image.
                %Resizing factor is an arbitrary choice
importfile('penguinMask.mat');
img1Mask = penguinMask;
img1 = im2double(img1);
img1Mask = imresize(img1Mask,RESIZE_FACTOR);
                %read in the mask from the source image
                %MASK CREATED USING CODE FROM:
                %http://www.mathworks.com/matlabcentral/answers/38547-masking-out-image-area-using-binary-mask
                %resize the mask by the same factor as above
importfile('im3.jpg');
destination = im3;
                %read in the sample destination image
destination = im2double(destination);




img1Padded = zeros(size(destination));
img1MaskPadded = img1Padded;
                %initialize padded mask and image arrays
[imw,imh,imd] = size(img1);
offsetY = 350;
offsetX = 900;
for imx = 1:imw
    for imy = 1:imh
        for imz = 1:imd
            img1Padded(max(imx+offsetY,1),max(imy+offsetX,1),imz) = img1(imx,imy,imz);
            img1MaskPadded(max(imx+offsetY,1),max(imy+offsetX,1),imz) = img1Mask(imx,imy);
        end
    end
end
                %pad mask and image arrays with zeros in order to match
                %its size to that of the destination image


final = zeros(size(destination));
alpha = .85;
for i = 1:size(img1Padded,1)
    for j = 1: size(img1Padded,2)
        if img1MaskPadded(i,j) == true
            blended_Pixel = alpha* (img1Padded(i,j,:))+ (1-alpha)*destination(i,j, :);
            final(i, j, :) = blended_Pixel;

        end
    end
end
                %Alpha blend the two images together



%for i = 1:size(img2,1)
%    for j = 1: size(img2,2)
%        if img2Mask(i,j) == true
%            blended_Pixel = alpha* (img2(i,j,:))+ (1-alpha)*destination(offset2Y+i, offset2X+j, :);
%            destination(offset2Y+i, offset2X+j, :) = blended_Pixel;
%        end
%    end
%end
figure;
imshow(final)
                %Display alpha-blended image
figure
imshow(poissonBlend(img1Padded,img1MaskPadded,destination))
                %Call my poissonBlend method on Image
                %Display alpha-blended image result