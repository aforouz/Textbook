clear
clc
% this section is for enter the data------------------------------------------

X=-pi:(2*pi/20):pi;
F=sin(4*X);
n=size(X,2)-1;

% this section is for define the values---------------------------------------

for i=1:n
    
    h(i+1)=X(i+1)-X(i);
end

for j=2:n
        
        l(j)=h(j+1)/(h(j)+h(j+1));
        u(j)=h(j)/(h(j)+h(j+1));
        d(j)=6*((F(j+1)-F(j))/h(j+1)-(F(j)-F(j-1)/h(j)))/(h(j)+h(j+1));
end

l(n+1)=h(2)/(h(n+1)+h(2));
u(n+1)=h(n+1)/(h(n+1)+h(2));
d(n+1)=6*(F(1)-F(n+1)/h(2)-(F(n+1)-F(n)/h(n+1)))/(h(n+1)+h(2));

%difine a MATRIX A------------------------------------------------------------

A=zeros(n);
for i=1:n-1
    
    A(i,i)=2;
    A(i,i+1)=l(i+1);
    A(i+1,i)=u(i+2);
    
end
A(n,n)=2;
A(1,n)=u(2);
A(n,1)=l(n+1);
A
%shifting d MATRIX -----------------------------------------------------------

for m=1:n
    
    D(m)=d(m+1);
    
end
%solving and displaying the system by MATLAB----------------------------------

M1=D/A;
disp('M2 is the solve of MATLAB:  ')
M2=[M1(n),M1]

% guse method-----------------------------------------------------------------

for i=2:n-1
    
    A(i,i)=A(i,i)-(A(i-1,i)*A(i,i-1)/A(i-1,i-1));
    D(i)=D(i)-(D(i-1)*A(i,i-1))/A(i-1,i-1);
    A(i,n)=A(i,n)-(A(i-1,n)*A(i,i-1)/A(i-1,i-1));
    D(n)=D(n)-(D(i-1)*A(n,i-1))/A(i-1,i-1);
    A(n,i)=-(A(i-1,i)*A(n,i-1))/A(i-1,i-1);
    A(n,n)=A(n,n)-(A(i-1,n)*A(n,i-1))/A(i-1,i-1);
    A(i,i-1)=0;
    A(n,i-1)=0;

end

A(n,n)=A(n,n)-(A(n,n-1)*A(n-1,n))/A(n-1,n-1);
A(n,n-1)=0;
A

%-----------------------------------------------------------------------------

M(n)=D(n)/A(n,n);
M(n-1)=(D(n-1)-(A(n-1,n)*M(n)))/A(n-1,n-1);
for j=n-2:-1:1

   M(j)=(D(j)-(M(n)*A(j,n))-(M(j+1)*A(j,j+1)))/A(j,j);
   
end   
disp('M is the solution of gause method')
M=[M(n),M]
% ploting the unknown function whith the real data ---------------------------

plot(X,F,'k')
hold on;

%difining the spline function whith gause method solve------------------------
syms z
for i=1:n
    al(i)=F(i);
    ga(i)=M(i)/2;
    be(i)=((F(i+1)-F(i))/h(i+1))-((2*M(i)+M(i+1))*h(i+1)/6);
    de(i)=(M(i+1)-M(i))/(6*h(i+1));
    sd=inline(al(i)+(be(i)*(z-X(i)))+(ga(i)*(z-X(i))^2)+(de(i)*(z-X(i))^3));
    fplot(sd,[X(i) X(i+1)],'r')
    
end
% for dispay the all of domain------------------------------------------------

k=inline(z);
fplot(k,[X(1) X(n+1)],'w')
