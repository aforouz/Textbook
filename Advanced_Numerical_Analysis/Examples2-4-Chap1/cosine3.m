function c=cosine3(k,x,ep)

c=zeros(1,k+1);
dc=zeros(1,k+1);
c(1)=1;
dc(1)=-2*(sin(x/2))^2+ep;
t=2*dc(1);
for i=2:k+1
    c(i)=c(i-1)+dc(i-1);
    dc(i)=t*c(i)+dc(i-1);
end
c=c(k+1);