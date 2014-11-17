% Loads two images, creates two new images by exchanging the amplitude
% of the Fourier transforms

% (c) Bastian Goldluecke 11/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0

% Some helper functions
display_amplitude = @(fft) imagesc(log(1+abs(fftshift(fft)))), axis image, colormap jet;
display_phase     = @(fft) imagesc(angle(fftshift(fft))), axis image, colormap jet;


% Read Rebecca image, compute FFT
rebecca = imread( 'rebecca_384_gs.png' );
rebecca = double( rebecca ) / 255.0;
[imh, imw] = size(rebecca); % assuming same size for Lukas

fftsize = 1024; % should be order of 2 (for speed)
fft_rebecca = fft2(rebecca, fftsize, fftsize);

% Display Rebecca and her FFT
figure(1), imshow( rebecca ),
    title 'Rebecca';
figure(2),
    display_amplitude( fft_rebecca ),
    title 'Rebecca FFT amplitude';
figure(3), display_phase( fft_rebecca ),
    title 'Rebecca FFT phase';
    

% Load Lukas and compute FFT
lukas = imread( 'lukas_384_gs.png' );
lukas = double( lukas ) / 255.0;
fft_lukas = fft2( lukas, fftsize, fftsize );

% Display Lukas and FFT
figure(4),
    imshow( lukas ),
    title 'Lukas';
figure(5),
    display_amplitude( fft_lukas ),
    title 'Lukas FFT amplitude';
figure(6), display_phase( fft_lukas );
    title 'Lukas FFT phase';

    
% Compute FFT of Rukas: Rebeccas Fourier amplitude + Lukas Fourier phase
fft_rukas = abs( fft_rebecca ) .* exp( i * angle( fft_lukas ) );
% Inverse FFT
rukas = ifft2( fft_rukas );
% Cut out correct rectangle
rukas = rukas( 1:imh, 1:imw );
% Display
figure(7),
    imshow( rukas ),
    title 'Rukas';

% Compute FFT of Lebecca: Lukas Fourier amplitude + Rebeccas Fourier phase
fft_lebecca = abs( fft_lukas ) .* exp( i * angle( fft_rebecca ) );
% Inverse FFT
lebecca = ifft2( fft_lebecca );
% Cut out correct rectangle
lebecca = lebecca(1:imh, 1:imw);
% Display
figure(8),
    imshow( lebecca ),
    title 'Lebecca';
