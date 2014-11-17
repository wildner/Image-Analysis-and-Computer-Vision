% Returns Derivative of Gaussian kernel, standard deviation sigma
% X-direction
% Filter size is chosen so that it covers 3 standard deviation in
% each direction
% Warning: these are for imfilter, not conv2 !

% (c) Bastian Goldluecke 10/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0

function G = dgx(sigma)

  n = round(3*sigma);
  V = -n:1:n;
  [X Y] = meshgrid( V,V );
  gsigma = @(x,y) 2.0*x / (sigma^3 * sqrt( 2*pi )) * exp( -(x^2+y^2) / sigma^2 );
  G = arrayfun( gsigma, X, Y );
  
end
