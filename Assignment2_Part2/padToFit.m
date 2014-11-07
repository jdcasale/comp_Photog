function [paddedIMG, paddedMASK] = padToFit(imgToPad,imgMask, imgToFit, offsetA)
 %pad mask and image arrays with zeros in order to match
 %its size to that of the target image 


[AH,AW,AC] = size(imgToPad);
[BH,BW,BC] = size(imgToFit);
paddedIMG = zeros([max(AH,BH),max(AW,BW),max(AC,BC)]);
paddedMASK = paddedIMG;
offsetY = offsetA(1);
offsetX = offsetA(2);
for imx = 1:AH
    for imy = 1:AW
        for imz = 1:AC
            paddedIMG(max(imx+offsetY,1),max(imy+offsetX,1),imz) = imgToPad(imx,imy,imz);
            paddedMASK(max(imx+offsetY,1),max(imy+offsetX,1),imz) = imgMask(imx,imy);
        end
    end
end