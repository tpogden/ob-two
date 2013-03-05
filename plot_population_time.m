function plot_population_time(t,rho)

% Plot real(p_gg) -- the ground state population -- against time. 
figure; plot(t,[rho(:,1) rho(:,4)])
xlabel('t (µs)'), ylabel('g_{11}')
title(['Population of state |1\rangle and |2\rangle vs time'])
axis([t(1) t(end) -0.1 1.1])

end % plot_population_time