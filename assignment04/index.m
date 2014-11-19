% Some helper functions
display_amplitude = @(shifted_fft) imagesc(log(1+abs(shifted_fft)));
display_phase     = @(shifted_fft) imagesc(angle(shifted_fft));

%% 4.2.b
% fft of image
img = imread('rebecca_384_gs.png');
img = double( img ) / 255.0;
[imgW,imgH] = size(img);
imgFftSize = 2^nextpow2(max(imgW,imgH));
imgFft = fft2(img, imgFftSize, imgFftSize);
imgFftShifted = fftshift( imgFft );
    
% fft of gaussian kernel
kernelSigma = 10;
kernelSize = 80;
kernel = fspecial('gaussian',kernelSize, kernelSigma);
kernelFft = fft2(kernel, imgFftSize, imgFftSize);
kernelFftShifted = fftshift( kernelFft );

% combine two fft
result = imgFft .* kernelFft;
result = ifft2( result );
result = result(1:imgW,1:imgH);

% visualize  
figure,
subplot(2,2,1)
display_amplitude( imgFftShifted )
title('FFT input image: amplitude')
axis image
subplot(2,2,2)
display_phase( imgFftShifted )
title('FFT input image: phase')
axis image
subplot(2,2,3)
display_amplitude( kernelFftShifted )
title('FFT input image: amplitude')
axis image
subplot(2,2,4)
display_phase( kernelFftShifted )
title('FFT input image: phase')
axis image;

figure,
imshow( result )
color grey
title('result')
axis image;

%% 4.2.c

kernelSigma = 1;
kernelSize = 80;
kernel=conv2(fspecial('gaussian',kernelSize, kernelSigma),[1 0 -1],'valid');
kernelFft = fft2(kernel, imgFftSize, imgFftSize);
kernelFftShifted = fftshift( kernelFft );


% combine two fft
result = imgFft .* kernelFft;
result = ifft2( result );
result = result(1:imgW,1:imgH);

% visualize
figure, surf(kernel);
figure,
subplot(1,2,1)
display_amplitude( kernelFftShifted )
title('FFT input image: amplitude')
axis image
subplot(1,2,2)
display_phase( kernelFftShifted )
title('FFT input image: phase')
axis image;

figure,
imshow( result )
color grey
title('result')
axis image;
