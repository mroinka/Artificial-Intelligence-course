function y=MySVRFunc(x,eta,X,Kernel)

    n=numel(eta);

    y=0;
    for i=1:n
        y=y+eta(i)*Kernel(X(:,i),x);
    end

end