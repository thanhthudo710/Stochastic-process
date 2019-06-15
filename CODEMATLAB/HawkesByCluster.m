function[P] =HawkesByCluster(T,lambda,alpha,beta)
 % Generate the number and location of cluster centres, and the ?number of
 % descendents in each cluster.
 k = poissrnd(lambda*T);
 C = sort(T * rand(k, 1));
 D = poissrnd(alpha/beta, k, 1);
 % For each cluster centre generate an inhomogenous PP.
 allOff = [];
 figure(1); clf; hold on;
 colorOrder = get(gca, 'ColorOrder');
 % Generate each cluster.
 for c=1:k
 color = colorOrder(mod(c, size(colorOrder, 1))+1,:);
 numOffspring = poissrnd(alpha/beta);
 off = C(c) + exprnd(1/beta,numOffspring, 1);
 scatter(C(c), c, [], color, 'filled', '^');
 s = scatter(off, c.*ones(size(off)), [], color);
 allOff = [allOff; off];
 end
 points = sort([C; allOff]);
 scatter(points, zeros(size(points)), 80, [0 .5 0], 'filled', 's');
 xlabel('$t$', 'interpreter', 'latex');
 ylabel('Family Number', 'interpreter', 'latex');
 a = axis(); axis([0, T, a(3), a(4)]);
 set(gcf,'OuterPosition',[0,0,700,250])
 %% Plot the conditional intensity function for this realisation.
 figure(2); clf; hold on;
 t = 0:0.01:T; lambdas = cif(t, points, lambda, alpha, beta);
 plot(t, lambdas);
 scatter(points, zeros(size(points)), 80, [0 .5 0], 'filled', 's');
 xlabel('$t$', 'interpreter', 'latex');
 ylabel('$\lambda^*(t)$', 'interpreter', 'latex');
 set(gcf,'OuterPosition',[0,0,700,250])
 
end