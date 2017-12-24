a = 1.31;
c = 1;
alpha = 1e-3;
% s = 1/2;

syms k x y s
% syms k x y
% v(1) = c*(1-x)*((1-k)*s*(1-y)^a - (1-s)*x*(1-x)^(a-1));
% v(2) = c*(1-y)*((1-k)*(1-s)*(1-x)^a - s*x*(1-x)^a);
% v(3) = alpha*(1/(x+1)-1/(y+1))*s*(1-s);

J = jacobian([c*(1-x)*((1-k)*s*(1-y)^a - (1-s)*x*(1-x)^(a-1)), c*(1-y)*((1-k)*(1-s)*(1-x)^a - s*y*(1-y)^(a-1)), alpha*(1/(x+1)-1/(y+1))*s*(1-s)], [x y s]);
% J = jacobian([c*(1-x)*((1-k)*s*(1-y)^a - (1-s)*x*(1-x)^(a-1)), c*(1-y)*((1-k)*(1-s)*(1-x)^a - s*y*(1-y)^(a-1))], [x y]);

%     kstar = (2*a-2)/(2*a-1)
k = 0.4;
x = (1-k)/(2-k);
y = (1-k)/(2-k);
s = 1/2;

simplify(eig(J))

J = eval(J);
E = eig(J)
