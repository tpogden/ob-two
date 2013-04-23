% ob_two_pulse_test_a
% Tests:    4pi pulse, no detuning, no decay

clear;

%% Parameters

Omega_21 = 1; % Rabi frequency [2pi MHz]
Delta_21 = 0; % Detuning [2pi MHz]

pulse_in_pi = 4; % [] e.g. 1 for pi-pulse, 1/2 for pi/2-pulse.
pulse_duration = pulse_in_pi*pi/Omega_21; % [µs]

p.Omega_21_f = @(t) Omega_21*(t <= pulse_duration); % Rabi frequency, square pulse
p.Delta_21_f = @(t) Delta_21; % detuning, constant

p.Gamma_2 =  0;  % Decay rate for Rb87 [2pi MHz]
p.gamma_21 = 0; % [2pi MHz] Lorenzian laser linewidth

p.init_pop = [1;0;0;0]; % initial populations of the states

p.duration = 2*pulse_duration; % [µs] duration to be solved

%% Solve for pulse

[t,rho] = ob_two_pulse(p);
            
%% Plotting

% Plot populations vs time
fig_1 = figure; plot(t/pi,[rho(:,1) rho(:,4)]); axis([t(1)/pi t(end)/pi -0.1 1.1]);
xlabel('t (\pi µs)'), ylabel('|c|^2'), title([mfilename ': populations'], 'interpreter', 'none');
legend('\rho_{11}', '\rho_{22}');

csvwrite(['csv/' mfilename '_pop.csv'],[t rho(:,1) rho(:,4)]);

% Plot real, imag of susceptibility, i.e. the absorption and dispersion vs time
d_eg = 2.534e-29; %  [Cm] transition dipole moment 
n = 1e20; % [/m3] atomic number density N/V
plot_susceptibility_time(t,rho,d_eg,n);

%plot_bloch_sphere(t,rho); % Plot the evolution over the Bloch sphere