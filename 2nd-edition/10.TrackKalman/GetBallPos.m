function [xm, ym] = GetBallPos(index)
%
%
persistent imgBg

persistent firstRun
if isempty(firstRun)
    imgBg = imread('Img/bg.jpg');

    firstRun = 1;
end

imgWork = imread(['Img/', int2str(index), '.jpg']);
image(imgWork);
axis image off

diff = uint8(abs(double(imgWork) - double(imgBg)));
fore = (diff(:,:,1) > 10) | (diff(:,:,2) > 10) | (diff(:,:,3) > 10);

[rows, cols] = find(fore);
if isempty(rows)
    return;
end

xm = mean(cols) + 20*randn;     % Return ball's center coordinates (through line 26)
ym = mean(rows) + 20*randn;
