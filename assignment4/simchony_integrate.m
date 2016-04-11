function z = simchony_integrate(n1,n2,n3,mask)
    % An implementation of the method from Simchony et Al for integration
    % of a normal field with natural boundary condition
    % Ref : Direct Analytical Methods for Solving Poisson Equation in
    % Computer Vision problems - PAMI 1990
    % (very very slightly) modified from Yvain Queau's code.
    %
    p = -n1./n3;
    q = -n2./n3;
    
    
    % Compute div(p,q)
    px = 0.5*(p([2:end end],:)-p([1 1:end-1],:));
    qy = 0.5*(q(:,[2:end end])-q(:,[1 1:end-1]));

    % Div(p,q) + Boundary Condition
    f = px+qy;
    f(1,2:end-1) = 0.5*(p(1,2:end-1)+p(2,2:end-1));
    f(end,2:end-1) = 0.5*(-p(end,2:end-1)-p(end-1,2:end-1));
    f(2:end-1,1) = 0.5*(q(2:end-1,1)+q(2:end-1,2));
    f(2:end-1,end) = 0.5*(-q(2:end-1,end)-q(2:end-1,end-1));

    f(1,1)=0.5*(p(1,1)+p(2,1)+q(1,1)+q(1,2));
    f(end,1)=0.5*(-p(end,1)-p(end-1,1)+q(end,1)+q(end,2));
    f(1,end)=0.5*(p(1,end)+p(2,end)-q(1,end)-q(1,end-1));
    f(end,end)=0.5*(-p(end,end)-p(end-1,end)-q(end,end)-q(end,end-1));

    % Cosine transform of f
    fsin=dct2(f);

    % Denominator
    [x,y] = meshgrid(0:size(p,2)-1,0:size(p,1)-1);
    denom = (2*cos(pi*x/(size(p,2)))-2) + (2*cos(pi*y/(size(p,1))) - 2);
    Z = fsin./(denom);
    Z(1,1)=0.5*Z(1,2)+0.5*Z(2,1); %Or whatever...

    % Inverse cosine transform :
    U=idct2(Z);
    z = nan*ones(size(mask));
    nz = find(mask);
    z(nz) = U(nz);
    
    
end
