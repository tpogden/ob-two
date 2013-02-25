function plot_population_time(t,rho)

% Plot real(p_gg) -- the ground state population -- against time. 
figure
plot(t,rho(:,1))
xlabel('t (µs)'), ylabel('g_{11}')
title(['Population of state |1\rangle against time'])
axis([t(1) t(end) -0.1 1.1])

% Plot real(p_ee) -- the excited state population -- against time. 
figure
plot(t,rho(:,4))
xlabel('t (µs)'), ylabel('g_{22}')
title(['Population of state |2\rangle against time'])
axis([t(1) t(end) -0.1 1.1])

csvwrite('csv/plotted_population_time.csv',[t real(rho(:,1)) real(rho(:,4))]);

end % plot_population_time