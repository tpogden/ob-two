function plot_susceptibility_time(t,rho,d_eg,n)

c = constants; % Load physical constants

Chi = 2*n*d_eg*rho(:,2)./c.eps_0;

figure
plot(t,imag(Chi))
title('absorption \chi_I')
xlabel('t (\mu s)'), ylabel('')

figure
plot(t,real(Chi))
title('dispersion \chi_R')
xlabel('t (\mu s)'), ylabel('')

%csvwrite('plotted_susceptibility_time.txt',[t imag(Chi)/imag(Chi_0) real(Chi)/imag(Chi_0)]);

end % plot_susceptibility_time