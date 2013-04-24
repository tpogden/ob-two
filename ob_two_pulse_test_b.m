% ob_two_pulse_test_b
% Tests:    2pi pulse, detuning, no decay

clear;

%% Parameters

p.Omega_21 = 1; % Rabi frequency [2pi MHz]
p.Delta_21 = 0.5; % Detuning [2pi MHz]

pulse_in_pi = 2; % e.g. 1 for pi-pulse, 1/2 for pi/2-pulse.
p.pulse_duration = pulse_in_pi*pi/p.Omega_21; % [µs]

p.Gamma_1 = 0; % [2pi MHz]
p.Gamma_2 = 0; % Decay rate for Rb87 [2pi MHz]

p.gamma_21 = 0; % [2pi MHz]

p.init_pop = [1;0;0;0]; % initial populations of the states

p.duration = 2*p.pulse_duration; % [µs] duration to be solved

%% Solve for pulse

[t,rho] = ob_two_pulse(p);
            
%% Plotting

% Plot populations vs time
fig_1 = figure; plot(t/pi,[rho(:,1) rho(:,4)]); axis([t(1)/pi t(end)/pi -0.1 1.1]);
xlabel('t (\pi µs)'), ylabel('|c|^2'), title([mfilename ': populations'], 'interpreter', 'none');
legend('\rho_{11}', '\rho_{22}');

csvwrite(['csv/' mfilename '_pop.csv'],[t rho(:,1) rho(:,4)]);

plot_bloch_sphere(t,rho); % Plot the evolution over the Bloch sphere
