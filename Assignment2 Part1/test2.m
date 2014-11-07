function flow = test2()

% TEST2 Demonstrates gradient-based image
%   min-cut partitioning.
%
%   (c) 2008 Michael Rubinstein, WDI R&D and IDC
%   $Revision: 140 $
%   $Date: 2008-09-15 15:35:01 -0700 (Mon, 15 Sep 2008) $
%

im = imread('img1Orig.jpg');
%im = im(30:450,175:350,:);
im = im(50:500,250:550,1:3);
%i = imrotate(im(:,:,1),-90);
%j = imrotate(im(:,:,2),-90);
%k = imrotate(im(:,:,3),-90); 
%imo = cat(3,i,j,k);
%im = imo;

figure
imshow(im);



m = double(rgb2gray(im));
[height,width] = size(m);
disp('building graph');
N = height*width;

% construct graph
E = edges4connected(height,width);
V = abs(m(E(:,1))-m(E(:,2)))+eps;
A = sparse(E(:,1),E(:,2),V,N,N,4*N);

% terminal weights
% connect source to leftmost column.
% connect rightmost column to target.

%T = sparse(N,2);
a =[1:height; N-height+1:N]';
b =[ones(height,1); ones(height,1)*2];
c = ones(2*height,1)*9e9;
T =sparse(a,b,c);
%T = sparse([1:height;N-height+1:N]',[ones(height,1);ones(height,1)*2],ones(2*height,1)*9e9);

size(T)
disp('calculating maximum flow');

[flow,labels] = maxflow(A,T);
labels = reshape(labels,[height width]);

imagesc(labels); title('labels');
finalImg = zeros(size(labels),3);

for i =1:height
    for j = 1:width
        if(labels(i,j)==1)
           for k = 1:1
            finalImg(i,j,k) = m(i,j,k);
           end
        end
    end
end

figure 
size(labels)
imagesc(finalImg);
