function c=cosine2(k,x,ep)

cs=zeros(2,k);
cs(1,1)=cos(x)+ep;
cs(2,1)=sin(x);
U=[cs(1,1) -cs(2,1);cs(2,1) cs(1,1)];
for i=2:k
    cs(:,i)=U*cs(:,i-1);
end
c=cs(1,k);