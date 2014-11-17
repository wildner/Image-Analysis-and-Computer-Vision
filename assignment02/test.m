input = imread('rebecca_original.png');

k = 51;
G1=fspecial('gaussian',[k k], 2);
G2=fspecial('gaussian',[k k], 4);
G12 = G1 - G2;
res = imfilter(input,G12);
%%

figure
subplot(1,3,1);
surf(G1);
title('fxx');
subplot(1,3,2);
surf(G2);
title('fyy');
subplot(1,3,3);
surf(G1-G2)
title('fxy');
%%

figure, imshow(res)
