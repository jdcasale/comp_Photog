function [foreground, background, intervals] = createHistograms(img, imgMask)
%Create Histograms to store pixel-value distribution
%for foreground and background sections
intervals = 25;
span = 3;

[~, ~, channels] = size(img);


foreground = zeros(channels,intervals+1);
background = foreground;

for k = 1:channels
    
    channel = img(:,:,k);
    %linspace creates a row vector of #bins evenly spaced points
    %We want to bin each pixel into one of theses evenly spaced intervals
    foreground(k,:) = histc(channel(imgMask), linspace(0,1,intervals+1));
    background(k,:) = histc(channel(~imgMask), linspace(0,1,intervals+1));
    
      %Smooth histograms
      %Credit idea to Aaron Smith (classmate) -- 
      %Without smoothing, mask gets very blocky and jagged sometimes
      foreground(k,:) = smooth(foreground(k,:), span);
      background(k,:) = smooth(background(k,:), span);
     
      %Normalize histograms
      foreground(k,:) = foreground(k,:)/sum(foreground(k,:));
      background(k,:) = background(k,:)/sum(background(k,:));
    
end