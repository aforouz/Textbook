clc;
clear;
z=input('if you want to use function enter 1 elseif 0=');
syms x;
m=10;
x1=-pi:2*pi/m:pi;
n=length(x1)-1;
if z==1
    f=sin(4*x);
    x2=-pi:pi/100:pi;
    y=subs(f,x1);
    y2=subs(f,x2);
    hold on
    plot(x2,y2,'b');
    hold off
elseif z==0
   f=sin(4*x);
   y=subs(f,x1);
   hold on
   plot(x1,y,'o');
   hold off
end;
for i=2:n+1
    h(i)=x1(i)-x1(i-1);
end
A=2*eye(n+1,n+1);
A(1,2)=0;A(n+1,n)=0;
for i=2:n
    for j=1:n-1
        if j+1 == i
            A(i,j+2)=h(j+1)/(h(j)+h(j+1));%landa
            A(i,j)=h(j)/(h(j)+h(j+1));%meu
        end;
    end;
end;
d(1)=0;d(n+1)=0;
for j=2:n
    d(j)=(6/(h(j)+h(j+1))).*((y(j+1)-y(j))/h(j+1)-(y(j)-y(j-1))/h(j));
end;
v=inv(A);
M=v*d';
G=(1/2).*M;
for i=1:n
    B(i)=(((y(i+1)-y(i))/h(i+1))-((2.*M(i,1)+M(i+1,1))/6).*h(i+1));
    u(i)=(M(i+1,1)-M(i,1))/(6.*h(i+1));
end;
hold on
for i=1:n
    S=(y(i)+B(i).*(x-x1(i))+G(i,1).*((x-x1(i)).^2)+u(i).*((x-x1(i)).^3));
    S=simplify(S)
    W=x1(i):(x1(i+1)-x1(i))/100:x1(i+1);
    W2=subs(S,W);
    plot(W,W2,'r');
    title('natural spline')
    xlabel('x')
    ylabel('y')
end
hold off

