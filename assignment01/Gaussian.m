function res = Gaussian(path,size,sigma)
% load image
img = im2double(imread(path));
% create gaussian kernel
kernel = fspecial('gaussian', size, sigma);
% use filter
%res = imfilter(img,kernel);
res(:,:,1) = conv2(img(:,:,1),kernel,'same');
res(:,:,2) = conv2(img(:,:,2),kernel,'same');
res(:,:,3) = conv2(img(:,:,3),kernel,'same');

figure, imshow(kernel * 255);
figure, imshow(res );
figure, imshow(img);


