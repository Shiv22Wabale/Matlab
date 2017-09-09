function [rgbResult] = alignChannels(red, green, blue)
% alignChannels - Given 3 images corresponding to different channels of a
%       color image, compute the best aligned result with minimum
%       aberrations
% Args:
%   red, green, blue - each is a matrix with H rows x W columns
%       corresponding to an H x W image
% Returns:
%   rgb_output - H x W x 3 color image output, aligned as desired

%% Write code here

sub_red = red;% get red 
sub_green = green( uint32(size(green, 1) / 3) : uint32(2 * size(green, 1) / 3) - 1 , uint32(size(green, 2) / 3) : uint32(2 * size(green, 2) / 3) - 1); % get the sub array from 1/3 to 2/3 in both dim
sub_blue = blue( uint32(size(blue, 1) / 3) : uint32(2 * size(blue, 1) / 3) - 1, uint32(size(blue, 2) / 3) : uint32(2 * size(blue, 2) / 3) - 1); % get the sub array from 1/3 to 2/3 in both dim

y = uint32(2 * size(green, 1) / 3) - 1;
x = uint32(2 * size(green, 2) / 3) - 1;

ncc = normxcorr2(sub_green(:,:),sub_red(:,:));

[ypeak, xpeak] = find(ncc==max(ncc(:)));

green = circshift(green, [double(ypeak) - double(y), double(xpeak) - double(x)]);

ncc = normxcorr2(sub_blue(:,:),sub_red(:,:));

[ypeak, xpeak] = find(ncc==max(ncc(:)));

blue = circshift(blue, [double(ypeak) - double(y), double(xpeak) - double(x)]);

rgbResult = uint8(cat(3, red, green, blue));

end
