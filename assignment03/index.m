%% 3.1 (a)
img = im2double(rgb2gray(imread('slide.png')));
%img = checkerboard(5,5);
g = fspecial('gaussian',[11 11], 1);
gx = dgx(1);
gy = dgy(1);

fx = imfilter(img,gx);
fy = imfilter(img,gy);

fxx = fx .* fx;
fyy = fy .* fy;
fxy = fx .* fy;

fxx = imfilter(fxx,g);
fyy = imfilter(fyy,g);
fxy = imfilter(fxy,g);

figure
subplot(1,3,1);
imagesc(fxx);
title('fxx');
axis image
colormap gray
subplot(1,3,2);
imagesc(fyy);
title('fyy');
axis image
colormap gray
subplot(1,3,3);
imagesc(fxy)
title('fxy');
axis image
colormap gray
%%
%[e1, e2, v1, v2] = arrayfun(@st_eigensystem,fxx,fxy,fyy);
[e1, e2, v1, v2] = st_eigensystem_vectorised(fxx,fxy,fyy);
%res = imfilter(img,fx);

figure
subplot(2,2,1);
imagesc(e1);
title('e1');
axis image
colormap gray
subplot(2,2,2);
imagesc(e2)
title('e2');
axis image
colormap gray
subplot(2,2,3);
imagesc(v1);
title('v1');
axis image
colormap gray
subplot(2,2,4);
imagesc(v2)
title('v2');
axis image
colormap gray

%% 3.1 (b)
%harris = (fxx * fyy - fxy^2) - (0.14 * (fxx + fyy)^2);
harrisResponse = (v1 .* v2) - (0.04 .* ( v1 + v2 ) .^ 2);
harrisResponseLocalMaxima = non_maxima_suppression(harrisResponse);

theta = 0.00002;
harrisResponseLocalMaxima(harrisResponseLocalMaxima<theta) = 0;

vis = visualize_mask(img,harrisResponseLocalMaxima, 2);

figure
subplot(1,2,1);
imagesc(harrisResponse);
title('harrisResponse');
axis image
colormap gray
subplot(1,2,2);
imagesc(harrisResponseLocalMaxima);
title('harrisResponseLocalMaxima');
axis image
colormap gray

figure
subplot(1,1,1);
imagesc(vis)
title('corners');
axis image
colormap gray

