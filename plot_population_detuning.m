 function plot_population_detuning(Delta,rho)

% Plot real(p_gg) -- the ground state population -- against time. 
figure
plot(Delta,real(rho(:,1)))
xlabel('\Delta (MHz)'), ylabel('\rho_{11}')
title(['state |1\rangle population'])
%axis([0 t_span(2) -0.1 1.1])

% Plot real(p_ee) -- the excited state population -- against time. 
figure
plot(Delta,real(rho(:,4)))
xlabel('\Delta (MHz)'), ylabel('\rho_{22}')
title(['state |2\rangle population'])
%axis([0 t_span(2) -0.1 1.1])

csvwrite('csv/population_detuning.csv',[Delta real(rho(:,1)) real(rho(:,4))]);

end % plot_population_time