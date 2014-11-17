input = imread('rebecca_original.png');

G=conv2(fspecial('gaussian',[21 21], 3),[1 0 -1],'valid');
figure, surf(G)
sum(G(:))

res = conv2(double(input),G);
figure, imshow(res);