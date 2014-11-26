% Blob detector (based on DoG scale space maxima)
% Skeleton code, to be completed as exercise
% Check the code for TODOs

% (c) Bastian Goldluecke 10/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0
 
image = imread( 'sunflowers.png' );
image = double(image) / 255.0;
%image = rgb2gray( image );

% Scale space construction
[h w] = size( image );

% Base scale
sigma = 0.5;
% Factor between consecutive scales
k = 1.3;
% Total number of scales
N = 20;
% Vector of all scales
scales = 1:N;

% TODO: replace each entry in the vector "scales" by the correct
% standard deviation of the Gaussian for this scale
scales = TODO

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

% IMPORTANT: Gaussian kernel size must be the same for all scales
% so use maximum necessary value (for largest std. dev.)
sz = TODO; % initialize with maximum necessary kernel size

% Initialize scale space
for t = 1:N
    t
    scs( :,:,t ) = TODO; % compute Gaussian convolution of image with
                         % std. dev. for scale t, kernel size sz
end

% super cool scale space visualization
figure(1), clf( 'reset' ), volume_visualize( 1:w, 1:h, 1:N, scs ), colormap gray;

% Compute difference of Gaussians and local maxima in
% a 3x3 neighborhood - this makes checking for scale space
% maxima slightly more efficient
for t = 1:N-1
    dog( :,:,t ) = TODO;  % compute difference of Gaussians at this scale

    % this is optional, use if you like to speed up future tests
    dog_max( :,:,t ) = local_maxima_3x3( dog( :,:,t ));
end
    
% equally cool DoG visualization
figure(2), clf( 'reset' ), volume_visualize( 1:w, 1:h, 1:N-1, dog ), colormap jet;


% Loop over DoG volume and store all local maxima in a list
% This is not very efficient, but works well enough and one
% sees what is going on.

% Note that local maxima only exist beween scale space layers,
% the boundaries are ignored for the sake of simplicity.
count = 1;
clear maxima;
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
            
            is_local_maximum = rand() < 0.01; % TODO correct test
            
            if ( is_local_maximum )
                                 
                 % keep the feature
                 maxima( count,: ) = [ v y x scales(s+1) ];
                 count = count + 1;

            end
            
        end
    end
end



% Display the best F features (by using the DoG value of the
% Fth best feature as a threshold)
F = 150;
sorted_max = sort( maxima );
threshold = sorted_max( size(maxima,1) - F, 1 );

% Draw a circle into the image for each of the features
figure(3), clf, imshow( image ), hold on;
for m=1:size(maxima,1)
    if ( maxima( m,1 ) > threshold )
        x = maxima( m, 2 );
        y = maxima( m, 3 );
        r = maxima( m, 4 ) * sqrt(2.0);
        circle( [x y], r, 1000, '-y' );
    end
end
