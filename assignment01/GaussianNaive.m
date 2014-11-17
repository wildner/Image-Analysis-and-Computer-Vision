function res = GaussianNaive(path,kernelSize,sigma)
% load image
img = im2double(imread(path));
% create gaussian kernel
kernel = fspecial('gaussian', kernelSize, sigma);
% use filter
%res = imfilter(img,kernel);
[xSize,ySize,dim] = size(img);
hsize = ceil(kernelSize/2);
res = zeros(xSize:ySize);
for x = 1:(xSize-kernelSize)
    for y = 1:(ySize-kernelSize)
        % color
        color = zeros(1:dim);
        for xKernel = 1:kernelSize
            for yKernel = 1:kernelSize
                for d = 1:dim
                   color(d) = color(d) + kernel(xKernel,yKernel) * img(x+xKernel,y+yKernel,d); 
                end
            end
        end
        %set color
        for d = 1:dim
            res(x+hsize,y+hsize,d) = color(d);
        end
    end
end
for y = hsize:(ySize-hsize)
    for x = 1:hsize
        for d = 1:dim
            res(y,x,d) = res(y,hsize+1,d);
            
        end
    end
    for x = xSize-hsize:xSize
        for d = 1:dim
            res(y,x,d) = res(y,xSize-(hsize+1),d);
            
        end
    end
end

for x = 1:xSize
    for y = 1:hsize
        for d = 1:dim
            res(y,x,d) = res(hsize+1,x,d);
            
        end
    end
    for y = ySize-hsize:ySize
        for d = 1:dim
            res(y,x,d) = res(ySize-(hsize+1),x,d);
            
        end
    end    
end


figure, imshow(kernel * 255);
figure, imshow(res);
figure, imshow(img);


