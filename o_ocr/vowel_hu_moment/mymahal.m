function [dist] =  mymahal(Y, X, comp)

  Y = Y(:,1:comp);
  X = X(:,1:comp);
  %dist = mahal(YS, XS);

  %return;
  
if (size(X, 1) <= size(X, 2))
  YS = Y(:,1:size(X, 1)-1);
  XS = X(:,1:size(X, 1)-1);
  dist = mahal(YS, XS);
else
  dist = mahal(Y, X);
end

  