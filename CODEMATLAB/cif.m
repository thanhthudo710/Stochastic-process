function[lambda] =cif(t,H,mu,alpha,Beta)
x=length(t) ;
lambda=mu*ones(x,1) ;
for i= 1:x
    h=H;
    h=h(h<t(i)) ;
    if~ isempty(h)
        lambda(i) =lambda(i) +alpha*sum(exp(-Beta*(t(i)-h)));
    end
end