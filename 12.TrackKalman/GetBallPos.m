function [xc, yc] = GetBallPos(index)
%
%
persistent imgBg
persistent firstRun

if isempty(firstRun)
  imgBg = imread('Img/bg.jpg');
  
  firstRun = 1;
end

xc = 0;
yc = 0;
  
imgWork = imread(['Img/', int2str(index), '.jpg']); 
imshow(imgWork)

fore = imabsdiff(imgWork, imgBg);
fore = (fore(:,:,1) > 10) | (fore(:,:,2) > 10) | (fore(:,:,3) > 10);

L     = logical(fore);
stats = regionprops(L, 'area', 'centroid');
area_vector = [stats.Area];
[tmp, idx] = max(area_vector);

centroid = stats(idx(1)).Centroid;
  
xc = centroid(1) + 15*randn;
yc = centroid(2) + 15*randn;
  