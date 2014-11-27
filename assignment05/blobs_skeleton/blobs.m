% Blob detector (based on DoG scale space maxima)
% Skeleton code, to be completed as exercise
% Check the code for TODOs

% (c) Bastian Goldluecke 10/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0
%%
image = imread( 'sunflowers.png' );
image = double(image) / 255.0;
%image = rgb2gray( image );

% Scale space construction
[h w] = size( image );

% Factor between consecutive scales
k = 1.3;
% Base scale
sigma = 0.5;
% Total number of scales
N = 20;
% Vector of all scales
scales = 1:N;
% TODO: replace each entry in the vector "scales" by the correct
% standard deviation of the Gaussian for this scale
% EDIT: factor 
scales = k.^(scales-1) * sigma 

% Scale space placeholder, one image per layer
scs = zeros( h, w, N );
% Difference of Gaussians placeholder, one layer less
dog = zeros( h, w, N-1 );

% Local maxima in a 3x3 neighbourhood, placeholder
% for every pixel, this stores the maximum of all neighbours in a
% 3x3 spatial neighbourhood of dog( :,:,s ) at the corresponding scale
% you can use this to speed up testing for a local maximum if you want,
% completely optional
dog_max = zeros( h, w, N-1 );
dog_min = zeros( h, w, N-1 );

% IMPORTANT: Gaussian kernel size must be the same for all scales
% so use maximum necessary value (for largest std. dev.)
% initialize with maximum necessary kernel size
% EDIT: Formel used in openCV to calculate sigma.
sz = ceil(10 / 3 * (2 * scales(end) - 1))


% Initialize scale space
for t = 1:N
    %t
    % compute Gaussian convolution of image with
    % std. dev. for scale t, kernel size sz
    % EDIT: create Gaussian
    kernel = fspecial('gaussian', sz, scales(t));
    scs( :,:,t ) = imfilter(image, kernel,'replicate'); 
end

% super cool scale space visualization
figure(1), clf( 'reset' ), volume_visualize( 1:w, 1:h, 1:N, scs ), colormap gray;

% Compute difference of Gaussians and local maxima in
% a 3x3 neighborhood - this makes checking for scale space
% maxima slightly more efficient
for t = 1:N-1
    % compute difference of Gaussians at this scale
    % EDIT: 
    dog( :,:,t ) = scs(:,:,t+1) - scs(:,:,t);  
    % this is optional, use if you like to speed up future tests
    dog_max( :,:,t ) = local_maxima_3x3( dog( :,:,t ));
    % EDIT: also find local minimal
    dog_min( :,:,t ) = -local_maxima_3x3( -dog( :,:,t ));
end
    
% equally cool DoG visualization
figure(2), clf( 'reset' ), volume_visualize( 1:w, 1:h, 1:N-1, dog ), colormap jet;


% Loop over DoG volume and store all local maxima in a list
% This is not very efficient, but works well enough and one
% sees what is going on.

% Note that local maxima only exist beween scale space layers,
% the boundaries are ignored for the sake of simplicity.
count_maxima = 1;
count_minima = 1;
clear maxima;
clear minima;
for x=2:h-1
    x % feedback to see something is still happening
      % if this loop gets very very slow the longer it runs, you are detecting
      % too many local maxima, i.e. probably have buggy code ;)
    for y=2:w-1
        for t=2:N-2
            v = dog( x,y,t );

            % TODO: in next line, replace the random initialization with
            % the correct test for a local MAXIMUM (note: this only detects
            % black blobs).
            % keep the feature
            % EDIT: 
            is_local_maximum = v == dog_max(x,y,t);
            is_local_minimum = v == dog_min(x,y,t);
            if ( is_local_maximum )
                 maxima( count_maxima,: ) = [ v y x scales(t) ];
                 count_maxima = count_maxima + 1;
            end
            if ( is_local_minimum )
                 minima( count_minima,: ) = [ v y x scales(t) ];
                 count_minima = count_minima + 1;
            end
        end
    end
end



% Display the best F features (by using the DoG value of the
% Fth best feature as a threshold)
F = 150;
sorted_max = sort( maxima );
sorted_min = sort( minima );
threshold_max = sorted_max( size(maxima,1) - F, 1 );
threshold_min = sorted_min( F + 1, 1 );

% Draw a circle into the image for each of the features
figure(3), clf, imshow( image ), hold on;
for m=1:size(maxima,1)
    if ( maxima( m,1 ) > threshold_max )
        x = maxima( m, 2 );
        y = maxima( m, 3 );
        r = maxima( m, 4 ) * sqrt(2.0);
        circle( [x y], r, 1000, '-y' );
    end
end
for m=1:size(minima,1)
    if ( minima( m,1 ) < threshold_min )
        x = minima( m, 2 );
        y = minima( m, 3 );
        r = minima( m, 4 ) * sqrt(2.0);
        circle( [x y], r, 1000, '-r' );
    end
end
