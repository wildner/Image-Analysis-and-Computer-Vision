% Keeps only points which are local maxima in a 3x3 neighborhood
% Not optimized, probably very slow

% (c) Bastian Goldluecke 10/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0

function R = non_maxima_suppression( A )

  % pad by 1
  [h w] = size( A );
  m = min( A(:) );
  B = repmat( m, h+2, w+2 );
  Xs = 2:w+1;
  Ys = 2:h+1;
  B( Ys, Xs ) = A;
  
  % maximum suppression function
  suppress = @(j,i) B( i,j ) * ( B(i,j) >= B( i-1,j ) ...
        && B(i,j) >= B(i-1,j-1) && B(i,j) >= B(i,j-1) ...
        && B(i,j) >= B(i+1,j-1) && B(i,j) >= B(i+1,j) ...
        && B(i,j) >= B(i+1, j+1) && B(i,j) >= B(i,j+1) ...
        && B(i,j) >= B(i-1,j+1) );

  % as usual, the following elegant way is slow because
  % arrayfun seems badly optimized
  %  [X Y] = meshgrid( Xs, Ys );
  %  R = arrayfun( suppress, X,Y );
 
  % this is the ugly but faster way
  R = zeros( h,w );
  for x=Xs
    for y=Ys
      R(y-1,x-1) = suppress( x,y );
    end
  end
end
