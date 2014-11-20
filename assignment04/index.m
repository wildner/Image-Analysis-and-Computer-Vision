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
kernelSize = 20;
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

kernelSigma = 0.8;
kernelSize = 40;
kernel=conv2(fspecial('gaussian',kernelSize, kernelSigma),[1 0 -1],'valid');
kernelFft = fft2(kernel, imgFftSize, imgFftSize);
kernelFftShifted = fftshift( kernelFft );
%%
kernelFft = fft2([0.5 0 -0.5], imgFftSize, imgFftSize);
kernelFftShifted = fftshift( kernelFft );
%%
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

%%
im = rgb2gray(imread('1.jpg'));
img1 = double( im ) / 255.0;
im = rgb2gray(imread('3.jpg'));
img2 = double( im ) / 255.0;
[imgW,imgH, chan] = size(img1);
% fft of gaussian kernel
kernel1 = fspecial('gaussian',10, 20);
kernel2 = fspecial('gaussian',30, 10);
img1 = img1 - imfilter(img1,kernel1);
img2 = imfilter(img2,kernel2);

figure,
subplot(1,2,1)
imshow(img1)
title('img1')
axis image
subplot(1,2,2)
imshow(img2)
title('img2')
axis image;

imgFftSize = 2^nextpow2(max(imgW,imgH));
img1Fft = fft2(img1, imgFftSize, imgFftSize);
img2Fft = fft2(img2, imgFftSize, imgFftSize);

weight = 0.45;
result = img1Fft .* weight + img2Fft .* (1 - weight);

img1FftShifted = fftshift( img1Fft );
img2FftShifted = fftshift( img2Fft );
resultFftShifted = fftshift( result );

% visualize  
figure,
subplot(2,4,1)
display_amplitude( img1FftShifted )
title('img1 amp')
axis image
subplot(2,4,2)
display_phase( img1FftShifted )
title('img1 phase')
axis image
subplot(2,4,3)
display_amplitude( img2FftShifted )
title('img2 amp')
axis image
subplot(2,4,4)
display_phase( img2FftShifted )
title('img2 phase')
axis image;
subplot(2,4,5)
display_amplitude( resultFftShifted )
title('img1 amp')
axis image
subplot(2,4,6)
display_phase( resultFftShifted )
title('img1 phase')
axis image;

result = ifft2(result);
result = result(1:imgW,1:imgH,chan);
resultS = imresize(result,0.20);

figure,
imshow( result )
title('result')
axis image;
figure,
imshow( resultS )
title('resultSmall')
axis image;