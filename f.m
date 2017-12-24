function dy = f(t, y)
    c = 0.1;
    a = 1.35;
%     alpha = 1e-1;
    
    x = y(1);
    s = y(2);
    alpha=y(3);
    dy = zeros(2,1);
    
    dy(1) = c*((1-x)*x^a*s-x*(1-x)^a*(1-s));
    dy(2) = alpha*(1/(x+1) + 1/(x-2))*(1-s)*s;
    dy(3)=0;
end