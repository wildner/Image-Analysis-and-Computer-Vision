% Replaces each point by the local maximum in a 3x3 neighbourhood

% (c) Bastian Goldluecke 11/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0
function R = local_maxima_3x3( A )

%    f = @(x) max( [x(1,1) x(1,2) x(1,3) x(2,1) x(2,3) x(3,1) x(3,2) x(3,3) ] );
%    R = nlfilter( A, [3 3], f );
    R = imdilate( A, strel( 'square', 3 ));

end
