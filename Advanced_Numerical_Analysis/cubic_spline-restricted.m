clc
clear
input('Determining Interpolating Cubic Spline pleas press enter');
syms x
z=input('if you want enter the function enter 1 else enter 2 :');
A=input('[x(1) x(2)...x(n+1)] such as [0 1 2 3] =');
N=input('interpolating at? N=');
n=length(A)-1;
if z==1
    hold on
syms x
f=sin(4*x);
j=A(1):0.01:A(n+1);
t=subs(f,j);
f1=diff(f,x);
B=subs(f,A);
D=[A(1) A(n+1)];
E=subs(f1,D);
plot(j,t)
elseif z==2
    B=input('[y1 y2 ...yn] such as [0 .5 2 1.5] =');
    E=input('[y11 y1n] such as[.2 -1] =');
end

for i=2:n+1
    h(i)=A(i)-A(i-1);
end
L(1)=1;
for j=2:n
    L(j)=h(j+1)/(h(j)+h(j+1));
end
M(n)=1;
for j=1:n-1
    M(j)=h(j+1)/(h(j+1)+h(j+2));
end
d(1)=(6/h(2)).*(((B(2)-B(1))/h(2))-E(1));
d(n+1)=(6/h(n+1)).*(E(2)-((B(n+1)-B(n))/h(n+1)));
for j=2:n
    d(j)=(6/(h(j)+h(j+1))).*((B(j+1)-B(j))/h(j+1)-(B(j)-B(j-1))/h(j));
end
q(1)=-L(1)/2;u(1)=d(1)/2;L(n+1)=0;
r=[];
for k=2:n+1
    r(k)=M(k-1).*q(k-1)+2;
    q(k)=-L(k-1)/r(k);
    u(k)=(d(k)-M(k-1).*u(k-1))/r(k);
end
MC(n+1)=u(n+1);
for k=n:-1:1
    MC(k)=q(k).*MC(k+1)+u(k);
end
MC=MC';
G=.5.*MC;
for i=1:n
    B1(i)=(((B(i+1)-B(i))/h(i+1))-((2.*MC(i,1)+MC(i+1,1))/6).*h(i+1));
    D1(i)=(MC(i+1,1)-MC(i,1))/(6.*h(i+1));
end
hold on
for i=1:n
    double(B(i))
    S=(double(B(i))+double(B1(i)).*(x-double(A(i)))+double(G(i,1)).*((x-double(A(i))).^2)+double(D1(i)).*((x-double(A(i))).^3))
    S=simplify(S);
     if A(i)<=N && N<=A(i+1)
       A2= subs(S,N)
       plot(N,A2,'+')
       text(N,A2,'interpolation point')
     end
    W=A(i):.1:A(i+1);
     k=length(W);
    W2=subs(S,W);
    plot(W,W2,'c');
    O=subs(S,A(i+1));
    title('cubic splin');
    xlabel('x');
    ylabel('y');
end
plot(A,B,'*');
hold off








    
        
