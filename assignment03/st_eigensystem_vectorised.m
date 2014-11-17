% this is a fast method to compute the Eigenvalues and Eigenvectors
% from the structure tensor components

% returns the Eigenvalues in v1, v2 and the Eigenvector
% corresponding to the larger one (direction across edge)
% in [e1, e2]

% (c) Bastian Goldluecke 10/2014, University of Konstanz
% License: Creative Commons BY-SA 4.0
 
function [e1 e2 v1 v2] = st_eigensystem_vectorised(t11, t12, t22)

  % Compute Eigenvalues
  trace = t11 + t22;
  det = t11.*t22 - t12.*t12;
  d = real(sqrt( 0.25*trace.*trace - det )); %in some cases 0.25*trace.*trace < det. so sqrt gets imaginary (e-15)
  v1 = max( 0.0, 0.5 * trace + d );
  v2 = max( 0.0, 0.5 * trace - d );

  % Compute Eigenvector for larger Eigenvalue
  l1=hypot(v2-t22,t12);
  l1=(l1==0)+l1; %otherwise we might devide by zero => NaN, and NaN + something = NaN...
  e1=(t12==0).*(t11>=t22) + ... %this is the first condition
      (t12~=0).*(v2-t22)./l1;   %this is the else part
  e2=(t12==0).*(t11<t22) + ... %this is the first condition
      (t12~=0).*(t12)./l1;     %this is the else part
  
%   if t12 == 0.0
%     if t11 >= t22
%       e1 = 1.0; e2 = 0.0;
%     else
%       e1 = 0.0; e2 = 1.0;
%     end
%   else 
%     e1 = v2 - t22; e2 = t12;
%     l1 = hypot( e1, e2 );
%     e1 = e1 / l1; e2 = e2 / l1;
%   end

end
