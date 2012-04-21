function [invts,pind,qind,b,at,t]=afinnorm(a,r,threscm,trase)
%[invts,pind,qind,b,at,t]=afinnorm(a,r,threscm,trase) normalizes moments of 
%an image a to an affine transform. The normalized moments are computed up
%to the r-th order (min.3). If r is given negative, no normalization to the
%mirror reflection is provided. There is such a magnitude normalization that 
%all non-zero values of a disk equals 1. 
%Parameters:
% a - image
% r - max. order
% threscm - basic threshold of non-zero moments, the actual threshold is 
%           computed from this number and the order of the moments. 
% trase - debugging. If trase>0, the running values of the normalization are 
% displayed, the higher number, the more detailed information.
% invts - array with the values of the normalized moments. 
% pind - first indices, 
% qind - second indices, i.e. invts(i)=tau_{pind(i),qind(i)}. 
% b - image in the standard position (it slows the computation - implicitly 
%     no image is computed), 
% at - the parameters of the normalizing affine transform (without translation), 
% t - the translation of the standard position.

mrflag=1;
if r<0
    r=-r;
    mrflag=0;
end
r=max([r,3]);
if nargin<3
    threscm=1e-3;   %implicit threshold of zeroness of the complex moments
end
if nargin<4
    trase=0;        %implicitly no debugging messages
end
stdm00=128*128;     %minimum size of the image in the standard position
m=cm(a,r);
m00=m(1,1);
if m00==0
    warning('Normalization by zero - zero m00: wrong normalization to scaling.');
    m00=1;
end
%scaling normalization
for p=0:r;
    for q=0:r-p;
        m(p+1,q+1)=m(p+1,q+1)/m00^((p+q+2)/2);
    end;
end;
%normalization to first rotation and stretching
denom=2*sqrt(m(3,1)*m(1,3)-m(2,2)^2);
if denom==0
    warning('Normalization by zero - zero I1: wrong normalization to stretching.');
    denom=1;
end
dt =sqrt((m(3,1)+m(1,3)-sqrt((m(3,1)-m(1,3))^2+4*m(2,2)^2))/denom);
idt=sqrt((m(3,1)+m(1,3)+sqrt((m(3,1)-m(1,3))^2+4*m(2,2)^2))/denom);
if dt==0 & idt~=0
    dt=1/idt;
end
if idt==0 & dt~=0
    idt=1/dt;
end
if m(3,1)==m(1,3) & m(2,2)==0
    sin_alpha=0;
    cos_alpha=1;
else
    sin_alpha=-sqrt((1-(m(3,1)-m(1,3))/sqrt((m(3,1)-m(1,3))^2+4*m(2,2)^2))/2);
    cos_alpha= sqrt((1+(m(3,1)-m(1,3))/sqrt((m(3,1)-m(1,3))^2+4*m(2,2)^2))/2);
end
if m(2,2)<0
    sin_alpha=-sin_alpha;
end
if trase>0
    disp(sprintf('normalization to the scaling: m00=%g,1/sqrt(m00)=%g',m00,1/sqrt(m00)))
    disp(sprintf('normalization to the first rotation: alpha=%g°',atan2(sin_alpha,cos_alpha)*180/pi))
    disp(sprintf('normalization to the stretching: delta=%g',dt))
end
mn=zeros(r+1);
for p=0:r;
    for q=0:r-p;
        for j1=0:p;
           pj1=nchoosek(p,j1);
           for j2=0:q;
              qj2=nchoosek(q,j2);
              mn(p+1,q+1)=mn(p+1,q+1)+pj1*qj2*(-1)^j1*dt^p*idt^q*sin_alpha^(p-j1+j2)*cos_alpha^(q+j1-j2)*...
                  m(j1+j2+1,p+q-j1-j2+1);
           end;
        end;
    end;
end;
%conversion from geometric to complex moments
cn=cmfromgm(r,mn);
%magnitude normalization of the complex moments
for p=0:r;
    for q=0:r-p;
        cn(p+1,q+1)=cn(p+1,q+1)*((p+q)/2+1)*pi^((p+q)/2);
    end;
end;
%normalization to the second rotation
flag1=0;
pn=0;
qn=0;
for d=1:r
    for q=0:(r-d)/2
        p=q+d;
        if p+q>2
            v1=cn(p+1,q+1);
            thressr=threscm*exp((p+q)/4);
            if abs(v1)>thressr & flag1==0
                pn=p;
                qn=q;
                flag1=1;
            end
     		if trase>1 & flag1==0
                disp(sprintf('search of a normalizing moment to the second rotation'))
                disp(sprintf('tested moment: c%d%d=%g+%gi',p,q,real(v1),imag(v1)))
                disp(sprintf('its absolute value %g is compared with threshold %g',abs(v1),thressr))
            end
        end
    end
end
if flag1==1
    ro=-angle(cn(pn+1,qn+1))/(pn-qn);
else
    ro=0;
end
if trase>0
    disp(sprintf('normalization to the second rotation: rho=%g°',ro*180/pi))
    if pn>=0 & qn>=0
        v1=cn(pn+1,qn+1);
        disp(sprintf('normalizing moment: c%d%d=%g+%gi',pn,qn,real(v1),imag(v1)))
        disp(sprintf('its absolute value %g was above the threshold %g',abs(v1),threscm*exp((pn+qn)/4)))
    end
end
sin_ro=sin(ro);
cos_ro=cos(ro);
mnr=zeros(r+1);
for p=0:r;
    for q=0:r-p;
        for j1=0:p;
           pj1=nchoosek(p,j1);
           for j2=0:q;
              qj2=nchoosek(q,j2);
              mnr(p+1,q+1)=mnr(p+1,q+1)+pj1*qj2*(-1)^j1*sin_ro^(p-j1+j2)*cos_ro^(q+j1-j2)*...
                  mn(j1+j2+1,p+q-j1-j2+1);
           end;
        end;
    end;
end;
%magnitude normalization to order according to a circle
for p=0:r;
    for q=0:r-p;
        v1=mnr(p+1,q+1);
        v2=(4*pi)^((p+q)/2)*gamma(p/2+1)*gamma(q/2+1)*gamma((p+q)/2+2)/(gamma(p+1)*gamma(q+1));    
        v3=v1*v2;
        mnr(p+1,q+1)=v3;
    end;
end;
%normalization to the mirror reflection
if mrflag
	v2=0;
	flag1=0;
	for r1=3:r
        for q=1:2:r1
            p=r1-q;
            v1=mnr(p+1,q+1);
            thresmr=threscm*exp((p+q)/4);
            if abs(v1)>thresmr & flag1==0
                pn=p;
                qn=q;
                v2=v1;
                flag1=1;
                if trase>0
                    disp(sprintf('normalization to the mirror reflection: z=%g',sign(v2)))
                    if pn>=0 & qn>=0
                        disp(sprintf('normalizing moment: m%d%d=%g',pn,qn,v2))
                        disp(sprintf('its absolute value was above the threshold %g',thresmr))
                    end
                end
            end
            if trase>1 & flag1==0
                disp(sprintf('search of a normalizing moment to the mirror reflection'))
                disp(sprintf('tested moment: m%d%d=%g',p,q,v1))
                disp(sprintf('its absolute value is compared with threshold %g',thresmr))
            end
        end
	end
	for r1=3:r
        for q=1:2:r1
            p=r1-q;
            if flag1==1 & v2<0
                mnr(p+1,q+1)=-mnr(p+1,q+1);
            end
        end
	end
end
%image in standard position
resm00=0;           
if nargout>3                %image in standard position is required
    mxa=max(max(a));        %max. brightness
    resm00=mxa*stdm00;      %result m00 - max. brightness x width x height
	z=eye(2);
	if mrflag==1 & flag1==1 & v2<0
        z(2,2)=-1;
	end
	u=[cos_alpha,-sin_alpha;sin_alpha,cos_alpha];
	d=[dt 0;0 idt]*sqrt(resm00/m00);
	v=[cos(ro),sin(ro);-sin(ro),cos(ro)];
	at=z*v*d*u;
    if rank(at)<2
        b=a;
        t=[0;0];
        warning('Zero Jacobian - the image in the standard position cannot be computed.');
    else
    	[b,t]=afint(a,at);
    end
end

%arrangement of the results
invts(1)=mnr(3,1);
pind(1)=2;
qind(1)=0;
invts(2)=mnr(4,1);
invts(3)=mnr(3,2);
invts(4)=mnr(2,3);
pind(2)=3;
pind(3)=2;
pind(4)=1;
qind(2)=0;
qind(3)=1;
qind(4)=2;
if r>3
    nf=5;
    for r1=4:r;
        for p=r1:-1:0;
            q=r1-p;
            invts(nf)=mnr(p+1,q+1);
            pind(nf)=p;
            qind(nf)=q;
            nf=nf+1;
        end;
    end;
end;
%invts=sign(invts).*abs(invts).^(2./(pind+qind)); %optional magnitude normalization to degree