function [b,p]=afint(a,at,interp)
%[b,p]=afint(a,at,interp)
%Afinne transform of the image a: X'=at*X, zero is in left upper corner.
%Result b is translated so it contain whole image. p is this translation.
%Interpolation interp is used, it can be 'nearest', 'linear', 'cubic' 
%or 'spline'. Bicubic interpolation is implicit.

[n1,n2]=size(a);
dat=at;
iat=inv(at);
rohy=[0 n2-1 0 n2-1;0 0 n1-1 n1-1];
celk=dat*rohy;
obe=[celk,rohy];
mn=min(obe');
mx=max(obe');
mn1=floor(mn(1))-1;
mx1=ceil(mx(1))+1;
mn2=floor(mn(2))-1;
mx2=ceil(mx(2))+1;
ap=zeros(mx2-mn2,mx1-mn1);
ap(1:n1,1:n2)=a;
[n1,n2]=size(ap);
[x,y]=meshgrid(0:n2-1,0:n1-1);
i1=iat(1,1)*(x+mn1)+iat(1,2)*(y+mn2);
i2=iat(2,1)*(x+mn1)+iat(2,2)*(y+mn2);
if nargin>2
    b=interp2(x,y,ap,i1,i2,interp);
else
    b=interp2(x,y,ap,i1,i2,'cubic');
end
b(find(isnan(b)==1))=0;
p=[mn1;mn2];
[x1,y1]=find(b);
szx=size(x1);
szy=size(y1);
if(szx(1)>0 & szy(1)>0)
	mn1=min(x1);
	mx1=max(x1);
	mn2=min(y1);
	mx2=max(y1);
    b=b(mn1:mx1,mn2:mx2);
end
%size(b)
%sum(sum(b))
