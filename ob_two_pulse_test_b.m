% Test of:  ob_two_pulse.m
%
% Author:   T P Ogden <t.p.ogden@durham.ac.uk>
%
% Notes:    8pi-pulse, no detuning, Omega_21 >> Gamma_2 (i.e. negligible
%           decay)

%% System parameters

clear all;

p.Gamma_2 =  0.001;  % Decay rate for Rb87 [2pi MHz]
p.Omega_21 = 10; % Rabi frequency [2pi MHz]
p.Delta_21 = 0; % Detuning [2pi MHz]

pulse_in_pi = 8; % e.g. 1 for pi-pulse, 1/2 for pi/2-pulse.
p.pulse_duration = pulse_in_pi/p.Omega_21/2; % [µs]

p.init_pop = [1;0]; % initial populations of the states

p.duration = 1*p.pulse_duration; % [µs] duration to be solved

%% Solve for pulse

[t,rho] = ob_two_pulse(p);
            
%% Plotting

plot_population_time(t,rho); % plot population of states 1,2 vs time

% Plot real, imag of susceptibility, i.e. the absorption and dispersion vs time
d_eg = 2.534e-29; %  [Cm] transition dipole moment 
n = 1e20; % [/m3] atomic number density N/V
plot_susceptibility_time(t,rho,d_eg,n);

plot_bloch_sphere(t,rho); % Plot the evolution over the Bloch sphere