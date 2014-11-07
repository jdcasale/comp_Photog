function blendedImage = poissonBlend(source,sourceMask, destination)

[destination_imh, destination_imw] = size(destination(:,:,1));
im2var = zeros(destination_imh, destination_imw);
                           %Set up mapping of pixels to/from sparse mapping



NUM_EQUATIONS = 0;         %initialize equation counter
                           %to calculate sizes for our
                           %sparse matrix and coefficients vector
for i = 1:destination_imw
    for j = 1:destination_imh
        if(sourceMask(j,i) == 1)
            NUM_EQUATIONS = NUM_EQUATIONS+1;
            im2var(j,i) = NUM_EQUATIONS;
        end
    end
end

A = sparse([],[],[],destination_imh,destination_imw,NUM_EQUATIONS);
                           %Initialize sparse matrix A based upon
                           %calculated number of equations
b = zeros(NUM_EQUATIONS,3);
                           %Initialize coefficients vector b based upon
                           %calculated number of equations

l1 = [0 -1 0];
l2 = [-1 4 -1];
laplacianMatrix = [l1;l2;l1];
sourceLaplacian = cat(3, conv2(source(:,:,1), laplacianMatrix, 'same'), conv2(source(:,:,2), laplacianMatrix, 'same'),conv2(source(:,:,3), laplacianMatrix, 'same'));
                           %Initialize laplacianMatrix to calculate
                           %laplacian of source image

e = 0;                     %intialize equation index counter
for i = 2:destination_imw-1
    for j = 2:destination_imh-1
                           %ignore outermost ring of pixels when
                           %calculating gradient
        if(sourceMask(j,i) ==1)
            e = e+1;
                           %only evaluate for pixel within masked
                           %area of source image.


                           %if pixel below is within masked area
            if(sourceMask(j-1,i) == 1)
                A(e, im2var(j-1, i)) = -1;
            else
                for(k = 1:3)
                b(e,k) = b(e,k)+destination(j-1, i,k);
                end
            end
                          %if pixel to the left is within masked area
            if(sourceMask(j, i-1) == 1)
                A(e, im2var(j, i-1)) = -1;
            else
                for(k = 1:3)
                b(e,k) = b(e,k)+destination(j, i-1,k);
                end
            end
                          %if pixel above is within masked area
            if(sourceMask(j+1, i) == 1)
                A(e, im2var(j+1, i)) = -1;
            else
                for(k=1:3)
                b(e,k) = b(e,k)+destination(j+1, i,k);
                end
            end
                         %if pixel below is within masked area
            if(sourceMask(j, i+1) == 1)
                A(e, im2var(j, i+1)) = -1;
            else
                for(k = 1:3)
                b(e,k) = b(e,k)+destination(j, i+1,k);
                end
            end

            A(e,e) = 4;  %size of our Laplacian operator
            for(k = 1:3)
            b(e,k) = b(e,k)+ sourceLaplacian(j,i,k);
            end
        end
    end
end

vmat = lscov(A,b);
                      %solve Ax = b to get vmat (x)
blendedImage = destination;
alpha = 1;
for i = 1:destination_imw
    for j = 1:destination_imh
        if(sourceMask(j,i) == 1)
            for k = 1:3
		blendedImage(j,i,k) = alpha* (vmat(im2var(j,i),k))+ (1-alpha)*destination(j,i, k);
            end
        end
    end
end
                     %Copy Alpha-blended pixels back into final blended image
                     %based upon the mapping in im2var