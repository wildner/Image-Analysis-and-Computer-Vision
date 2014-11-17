%just a short example on how to use the given functions

dogx=dgx(1); %generate dog in x direction
dogy=dgy(1);

tic
for i=1:1
    [e1, e2, v1, v2] = arrayfun(@st_eigensystem,dxx,dxy,dyy); %version calculating the eigenvalues/vectors for each position individually
end
toc

tic
for i=1:1
    [e1v, e2v, v1v, v2v] = st_eigensystem_vectorised(dxx,dxy,dyy); %version calculating the eigenvalues/vectors vectorised.
    %if you are interested in optimising your matlab code, you might want
    %to take a look at the implementation (although i can not guarantee
    %that this is the fastest way)
end
toc

%harrisResponse is just an scalar field
harrisResponseLocalMaxima = non_maxima_suppression(harrisResponse);
