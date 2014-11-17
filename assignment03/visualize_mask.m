% Mark mask in a source image
% Input: Greyscale image and mask (same size), filter size to
%        dilate mask regions
% Output: Color image where red channel inside regions where
%          the mask is non-zero is turned red

% (c) Bastian Goldluecke 10/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0
 
function im_marked = visualize_mask( image, mask, s )
    % Display mask locations overlaid on base image
    % (paint them in red)
    [h, w] = size( image );
    if s ~= 0
        f = ones( s,s );
        M = imfilter( mask, f ) > 0;
    else
        M = mask;
    end;
    im_marked = zeros( h,w,3 );
    im_marked( :,:,1 ) = image.*(M==0) + M;
    im_marked( :,:,2 ) = image.*(M==0);
    im_marked( :,:,3 ) = image.*(M==0);
end
