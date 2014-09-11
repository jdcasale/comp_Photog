function edgefiltered = edgeFilter(img)

gaussianFilter = fspecial('gaussian',[15 15], 2);
Gsmoothed = imfilter(img, gaussianFilter, 'replicate');
edgefiltered = Gsmoothed-img;
for i = 1:size(edgefiltered(:))
    if(edgefiltered(i)<0)
        edgefiltered(i)=0;
    end
end
end