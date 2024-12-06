% function c=cosine1(k,x,c1)
% if k==0
%     c=1;
% elseif k==1
%     c=c1;
% else
%     c=2*c1*cosine1(k-1,x,c1)-cosine1(k-2,x,c1);
% end

function c=cosine1(k,x,ep)
cc=zeros(1,k+1);
cc(1)=1;
cc(2)=cos(x)+ep;
for i=3:k+1
    cc(i)=2*cc(2)*cc(i-1)-cc(i-2);
end
c=cc(k+1);