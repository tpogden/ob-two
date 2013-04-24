% ob_two_ramsey_test_a
% Tests:    Ramsey-type pulses, detuning, decay

clear;

%% Parameters

p.Omega_21 = 10; % Rabi frequency [2pi MHz]
p.Delta_21 = 5; % Detuning [2pi MHz]

pulse_1_start_in_pi = 1;
pulse_1_end_in_pi = 1.5; % [] e.g. 1 for pi-pulse, 1/2 for pi/2-pulse.
p.pulse_1_start = pulse_1_start_in_pi*pi/p.Omega_21; % [탎]
p.pulse_1_end = pulse_1_end_in_pi*pi/p.Omega_21; % [탎]

pulse_2_start_in_pi = 3;
pulse_2_end_in_pi = 3.5; % [] e.g. 1 for pi-pulse, 1/2 for pi/2-pulse.
p.pulse_2_start = pulse_2_start_in_pi*pi/p.Omega_21; % [탎]
p.pulse_2_end = pulse_2_end_in_pi*pi/p.Omega_21; % [탎]

p.Gamma_1 =  0;  % [2pi MHz]
p.Gamma_2 =  0;  % [2pi MHz]
p.gamma_21 = 0; % [2pi MHz] Lorenzian laser linewidth

p.init_pop = [1;0;0;0]; % initial populations of the states

p.duration = 5*pi/p.Omega_21; % [탎] duration to be solved

%% Solve for pulse

[t,rho] = ob_two_ramsey(p);
            
%% Plots

% Plot populations vs time
fig_1 = figure; plot(t/pi,[rho(:,1) rho(:,4)]); axis([t(1)/pi t(end)/pi -0.1 1.1]);
xlabel('t (\pi 탎)'), ylabel('|c|^2'), title([mfilename ': populations'], 'interpreter', 'none');
legend('\rho_{11}', '\rho_{22}');

csvwrite(['csv/' mfilename '_pop.csv'],[t rho(:,1) rho(:,4)]);

plot_bloch_sphere(t,rho); % Plot the evolution over the Bloch sphere