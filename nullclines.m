a = 1.31;
kstar = (2*a-2)/(2*a-1);
k = kstar;
x = linspace(0,1);
y1 = 1-(x.*(1-x).^(a-1)./(1-k)).^(1/a);
plot(x, y1); hold on;
plot(y1, x); hold on;
plot(x, x); hold on;
xlabel('x');
ylabel('y');
legend('nx', 'ny', 'ns')
if k > kstar
    title('k > k*')
elseif k < kstar
    title('k < k*')
else
    title('k=k*')
end