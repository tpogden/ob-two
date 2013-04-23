% ob_two_pulse_test_e
% Tests:    Ramsey-type pulses, detuning, decay

clear;

%% Parameters

Omega_21 = 10; % Rabi frequency [2pi MHz]
Delta_21 = 1; % Detuning [2pi MHz]

pulse_1_start_in_pi = 1;
pulse_1_end_in_pi = 1.5; % [] e.g. 1 for pi-pulse, 1/2 for pi/2-pulse.
pulse_1_start = pulse_1_start_in_pi*pi/Omega_21; % [탎]
pulse_1_end = pulse_1_end_in_pi*pi/Omega_21; % [탎]

pulse_2_start_in_pi = 3;
pulse_2_end_in_pi = 3.5; % [] e.g. 1 for pi-pulse, 1/2 for pi/2-pulse.
pulse_2_start = pulse_2_start_in_pi*pi/Omega_21; % [탎]
pulse_2_end = pulse_2_end_in_pi*pi/Omega_21; % [탎]

pulse_1 = @(t) Omega_21*((t > pulse_1_start) & (t <= pulse_1_end));
pulse_2 = @(t) Omega_21*((t > pulse_2_start) & (t <= pulse_2_end));

p.Omega_21_f = @(t) (pulse_1(t) + pulse_2(t)); % Rabi frequency, square pulse
p.Delta_21_f = @(t) Delta_21; % detuning, constant

p.Gamma_2 =  0;  % Decay rate for Rb87 [2pi MHz]
p.gamma_21 = 0; % [2pi MHz] Lorenzian laser linewidth

p.init_pop = [1;0;0;0]; % initial populations of the states

p.duration = 5*pi/Omega_21; % [탎] duration to be solved

%% Solve for pulse

[t,rho] = ob_two_pulse(p);
            
%% Plots

% Plot populations vs time
fig_1 = figure; plot(t/pi,[rho(:,1) rho(:,4)]); axis([t(1)/pi t(end)/pi -0.1 1.1]);
xlabel('t (\pi 탎)'), ylabel('|c|^2'), title([mfilename ': populations'], 'interpreter', 'none');
legend('\rho_{11}', '\rho_{22}');

csvwrite(['csv/' mfilename '_pop.csv'],[t rho(:,1) rho(:,4)]);

plot_bloch_sphere(t,rho); % Plot the evolution over the Bloch sphere