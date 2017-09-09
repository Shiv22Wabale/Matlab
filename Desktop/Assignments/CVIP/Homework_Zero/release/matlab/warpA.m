function [ warp_im ] = warpA( im, A, out_size )
% warp_im=warpAbilinear(im, A, out_size)
% Warps (w,h,1) image im using affine (3,3) matrix A 
% producing (out_size(1),out_size(2)) output image warp_im
% with warped  = A*input, warped spanning 1..out_size
% Uses nearest neighbor mapping.
% INPUTS:
%   im : input image
%   A : transformation matrix 
%   out_size : size the output image should be
% OUTPUTS:
%   warp_im : result of warping im by A



M = A(1:2,1:2)';
T = A(1:2,3:3);
T([1 2]) = T([2 1]);

warp_im = zeros(out_size(1), out_size(2)); %test_im = zeros(out_size(1), out_size(2));

for i = 1:out_size(1)
    for j = 1:out_size(2)
        
        p =  M \ ( [i; j] - T );
        x = round(p(1, 1, 1));
        y = round(p(2, 1, 1));
        if x > 0 && x <= size(im, 1) && y > 0 && y <= size(im, 2)
            warp_im(i, j)= im(x,y);
        end
    end
end

end