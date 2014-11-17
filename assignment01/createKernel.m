function h =  createKernel(size, sigma)
    for i = 1 : size 
        for j = 1 : size
        c = [j-(size+1)/2 i-(size+1)/2]';                
        h(i,j) = Gauss(c(1), sigma) * Gauss(c(2), sigma);        
        end
    end
end
