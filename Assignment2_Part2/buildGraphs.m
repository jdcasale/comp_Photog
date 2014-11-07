function [A, T] = buildGraphs(foreground, background, intervals, img)

%Calculate helpful indices
[imh, imw,channels] = size(img);
numPixels = imh*imw;
numEdges = 2*numPixels - (imh+imw);



%Preallocate for speed
T = zeros(imh*imw,2);
A = spalloc(numPixels, numPixels, 2*numEdges);


%Set sink and source indices
[SOURCE, SINK] = deal(1,2);


%Create helper matrix to translate 
%between subscripts to matix indices
im2var = reshape(1:numPixels, [imh,imw]);


%Assign edge-weights 

for i = 1:imh
    for j = 1:imw
        LinIndex = im2var(i,j);   
        [bg,fg] = deal(1,1);
        for k = 1: channels  
            %Edges between pixels and source/sink 
            fg = fg*foreground(channels, floor(img(i,j,k)*intervals)+1);
            bg = bg*background(channels, floor(img(i,j,k)*intervals)+1);
        end
            T(LinIndex, SOURCE) = fg/(fg+bg);
            T(LinIndex, SINK) = bg/(fg+bg);
            
            
            %Edges between neighboring pixels 
            if i > 1
            A(LinIndex, im2var(i-1, j)) = ...
                1 - sumabs(img(i-1, j, :) - img(i, j, :))/channels;
            end
            
            if i < imh
                A(im2var(i+1, j),i) =...
                    1 - sumabs(img(i+1,j,:) - img(i,j,:))/channels;
            end
            
            if j > 1
                A(im2var(i, j-1), LinIndex) = ...
                    1 - sumabs(img(i, j-1, :) - img(i, j, :))/channels;                 
            end
            
            if j < imw
                A(im2var(i, j+1), LinIndex) = ...
                    1 - sumabs(img(i, j+1, :) - img(i, j, :))/channels;            
            end                         
    end
end

