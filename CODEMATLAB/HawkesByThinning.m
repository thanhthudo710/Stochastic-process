function[P] =HawkesByThinning(T,lambda,alpha,beta)
 rng(8)
 M = lambda;
 p = []; py = [];
 r = []; ry = [];
 t = 0;
 figure(1); clf; hold on;
 MXs = [];
 MYs = [];
 while t < T
 lastM = M; lastT = t;
 M = cif(t+1e-10, p, lambda, alpha, beta);
 t = t + exprnd(1/M);
 MXs = [MXs, [lastT; t]];
 MYs = [MYs, [M; M]];
 if t < T
 u = rand();
 if u <= cif(t, p, lambda, alpha, beta)/M
 p = [p, t];
 py = [py, M*u];
 else
 r = [r, t];
 ry = [ry, M*u];
 end
 end
 end
 t = 0:0.01:T; lambdas = cif(t, p, lambda, alpha, beta);
 xlabel('$t$', 'interpreter', 'latex');
 ylabel('$U$', 'interpreter', 'latex');
 h = zeros(4, 1);
 h(1) = plot(t, lambdas);
 h(3) = scatter(p, py, [], [0 .5 0], 'o');
 h(4) = scatter(r, ry, 'r+');
 many = line(MXs, MYs, 'Color', 'b', 'LineWidth', 3);
 h(2) = many(1);
 scatter(p, zeros(size(p)), 80, [0 .5 0], 's', 'filled');
 for i=1:numel(p)
 line([p(i), p(i)], [0, py(i)], 'LineStyle', '--', 'Color',[0 .5 0]);
 end
 axis([0, T, 0, max(lambdas)*1.05]);
 legend(h,{'$\lambda^*(t)$','$M$','Accepted Points','Rejected Points'}, 'interpreter', 'latex');
 set(gcf,'OuterPosition',[0,0,700,500])
end