function plot_susceptibility_detuning(Delta,rho,d_eg,n)

c = constants; % Load physical constants

Chi = 2*n*d_eg*rho(:,2)./c.eps_0;

% Find Delta = 0
z = abs(Delta);
[j] = find(min(z)==z);

Chi_0 = Chi(j);

figure
plot(Delta,imag(Chi)/imag(Chi_0))
title('normalised absorption \chi_I')
xlabel('\Delta (MHz)'), ylabel('')

figure
plot(Delta,real(Chi)/imag(Chi_0))
title('normalised dispersion \chi_R')
xlabel('\Delta (MHz)'), ylabel('')

csvwrite('csv/plotted_susceptibility_detuning.csv',[Delta imag(Chi)/imag(Chi_0) real(Chi)/imag(Chi_0)]);

end % plot_susceptibility_time