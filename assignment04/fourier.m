% Loads an images, computes Fourier transform, modifies that a bit,
% back-transforms and visualizes everything.

% of the Fourier transforms

% (c) Bastian Goldluecke 11/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0

display_amplitude = @(shifted_fft) imagesc(log(1+abs(shifted_fft)));
display_phase     = @(shifted_fft) imagesc(angle(shifted_fft));

% Load image, keep size
im = imread( 'rebecca_384_gs.png' );
im = double( im ) / 255.0;
[imh, imw] = size(im);

% compute FFT
fftsize = 1024; % should be order of 2 (for speed) and include
fft_im = fft2(im, fftsize, fftsize);

% note: the coefficients of the FFT are moved around the image in
% a strange way due to the nature of the Fast Fourier Transform.
% The following command shifts them back so that the center of the image
% corresponds to zero frequency.
fft_im_shifted = fftshift( fft_im );

% Visualize the results
figure(1),
    imshow( im ),
    title 'input image';

figure(2),
    display_amplitude( fft_im_shifted ),
    title 'FFT input image: amplitude';
   
figure(3),
    display_phase( fft_im_shifted ),
    title 'FFT input image: phase';

freqThreshold = 0.1;
for x=1:fftsize
    for y=1:fftsize
        if ( fft_im_shifted( x,y ) < freqThreshold)
            fft_im_shifted( x,y ) = 0;
        end
    end
end


% Visualize the changed transform
figure(4),
    display_amplitude( fft_im_shifted ),
    title 'FFT result: amplitude';
   
figure(5),
    display_phase( fft_im_shifted ),
    title 'FFT result: phase';
    
    
% Shift back so that we can apply the inverse transform
fft_im = ifftshift( fft_im_shifted );
    
% Inverse transform
result = ifft2( fft_im );
% Cut out image area
result = result( 1:imh, 1:imw );

% Show result
figure(6),
    imshow( result ),
    title 'result image';