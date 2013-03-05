% ob_two_pulse_test_a
% Tests:    pi/2 pulse, no detuning, Omega_21 >> Gamma_2 (i.e. negligible decay)

%% Parameters

clear;

p.Gamma_2 =  1;  % Decay rate for Rb87 [2pi MHz]
p.Omega_21 = 10000; % Rabi frequency [2pi MHz]
p.Delta_21 = 0; % Detuning [2pi MHz]

pulse_in_pi = 1/2; % e.g. 1 for pi-pulse, 1/2 for pi/2-pulse.
p.pulse_duration = pulse_in_pi/p.Omega_21/2; % [µs]

p.init_pop = [1;0]; % initial populations of the states

p.duration = 2*p.pulse_duration; % [µs] duration to be solved

p.gamma_21 = 0; % [2pi MHz] Lorenzian laser linewidth

%% Solve for pulse

[t,rho] = ob_two_pulse(p);
            
%% Plotting

plot_population_time(t,rho); % plot population of states 1,2 vs time

% Plot real, imag of susceptibility, i.e. the absorption and dispersion vs time
d_eg = 2.534e-29; %  [Cm] transition dipole moment 
n = 1e20; % [/m3] atomic number density N/V
plot_susceptibility_time(t,rho,d_eg,n);

plot_bloch_sphere(t,rho); % Plot the evolution over the Bloch sphere