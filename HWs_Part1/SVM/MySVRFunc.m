function f=MySVRFunc(X,alpha,y,x,Kernel)

    n=numel(alpha);

    f=0;
    for i=1:n
        f=f+alpha(i)*y(i)*Kernel(x(:,i),X);
    end

end