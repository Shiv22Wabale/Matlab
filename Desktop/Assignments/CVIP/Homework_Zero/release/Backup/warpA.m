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


%B = A(1:2, :)';

%tform = maketform( 'affine', B);


% change 'nearest' to 'bilinear' to compare with 'warpAbilinear'
%warp_im = imtransform( im, tform, 'bilinear', ...
%'XData', [1 out_size(2)], ...
%'YData', [1 out_size(1)], 'Size', out_size );

A

M = A(1:2,1:2)';
M
T = A(1:2,3:3);
T([1 2]) = T([2 1]);
%T(2,1) = T1(1,1);

warp_im = zeros(out_size(1), out_size(2)); %test_im = zeros(out_size(1), out_size(2));

% test = M \ ( [1;1] - T );
% whos test

for i = 1:out_size(1)
    for j = 1:out_size(2)
        
        p =  M \ ( [i; j] - T );
        x = round(p(1, 1, 1));
        y = round(p(2, 1, 1));
        if x > 0 && x <= size(im, 1) && y > 0 && y <= size(im, 2)
            warp_im(i, j)= im(x,y);
            %fprintf(' ---- %d ------- %d ------ %f\n',i, j, im(i,j));
            %p
        end
    end
end


% for i = 1:size(im, 1)
%     for j = 1:size(im, 2)
%         
%         p = A * [i;j;1];
%         x = round(p(1, 1, 1));
%         y = round(p(2, 1, 1));
%         if x > 0 && x <= out_size(1) && y > 0 && y <= out_size(2)
%             warp_im(x, y)= im(i,j);
%             %fprintf(' ---- %d ------- %d ------ %f\n',i, j, im(i,j));
%             %p
%         end
%     end
% end

%figure, imshow(test_im)
% p = A * x;
% 
% p(1,1,1)





%warp_im(100,100)

end
