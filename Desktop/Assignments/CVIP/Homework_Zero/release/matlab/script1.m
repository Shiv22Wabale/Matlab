% Problem 1: Image Alignment
clear;

%% 1. Load images (all 3 channels)cd 
red = [];  % Red channel
green = [];  % Green channel
blue = [];  % Blue channel

load('../data/red.mat', 'red')
load('../data/green.mat', 'green')
load('../data/blue.mat', 'blue')

%% 2. Find best alignment
% Hint: Lookup the 'circshift' function
rgbResult = alignChannels(red, green, blue);

%% 3. Save result to rgb_output.jpg (IN THE "results" folder)
figure, imshow(rgbResult);
imwrite(rgbResult,'../results/rgb-output.jpg');