function [Q lambda]=PerformPCA(X)

    C=cov(X');

    [Q LAMBDA]=eig(C);

    lambda=diag(LAMBDA);
    [lambda SortOrder]=sort(lambda,'descend');

    Q=Q(:,SortOrder);

end