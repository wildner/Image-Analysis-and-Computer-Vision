display_amplitude = @(shifted_fft) imagesc(log(1+abs(shifted_fft)));
display_phase     = @(shifted_fft) imagesc(angle(shifted_fft));
% image
img = imread('rebecca_384_gs.png');
img = double( img ) / 255.0;
[imgW,imgH] = size(img);
imgFftSize = 2^nextpow2(max(imgW,imgH));
imgFft = fft2(img, imgFftSize, imgFftSize);
imgFftShifted = fftshift( imgFft );

figure(1),
    display_amplitude( imgFftShifted ),
    axis image,
    title 'FFT input image: amplitude';
   
figure(2),
    display_phase( imgFftShifted ),
    axis image,
    title 'FFT input image: phase';
    
% kernel
kernelSigma = 10;
kernelSize = 80;
kernel = fspecial('gaussian',kernelSize, kernelSigma);
kernelFft = fft2(kernel, imgFftSize, imgFftSize);
kernelFftShifted = fftshift( kernelFft );

figure(3),
    display_amplitude( kernelFftShifted ),
    axis image,
    title 'FFT input image: amplitude';
   
figure(4),
    display_phase( kernelFftShifted ),
    axis image,
    title 'FFT input image: phase';
    
result = imgFft .* kernelFft;

result = ifft2( result );
result = result(1:imgW,1:imgH);

figure(5), 
    imshow(result),
    axis image,
    title 'result';