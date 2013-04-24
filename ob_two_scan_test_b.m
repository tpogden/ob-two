% ob_two_scan_test_b

%% Test system parameters 

clear;

p.Gamma_2 = 1;  % natural linewidth of spontaneous decay for Rb87 [2pi MHz]
p.Omega_21 = 0.1;  % Rabi frequency [2pi MHz]

% detuning scan parameters
p.Delta_21_min = -5;           % scan range [2pi MHz]
p.Delta_21_max = 5;
p.pulse_21_duration = 10000;        % scan duration [µs]

p.init_pop = [1;0]; % Start with all population in the ground state.

p.gamma_21 = 0; % [2pi MHz] Lorenzian laser linewidth

p.duration = p.pulse_21_duration; % [µs] duration to be solved

%% Scan and solve

[t,rho] = ob_two_scan(p);

%% Plots

% Create the detuning vector for plots.
Delta_21 = p.Delta_21_min ... 
                + (t./p.pulse_21_duration)*(p.Delta_21_max-p.Delta_21_min); % [MHz]

% Plot excited state population vs detuning
fig_1 = figure; plot(Delta_21,[rho(:,4)]); axis([Delta_21(1) Delta_21(end) 0 1e-2]);
xlabel('t (\pi µs)'), ylabel('|c|^2');
title([mfilename ': excited population'], 'interpreter', 'none'); legend('\rho_{22}');

% Plot susceptibility vs detuning
z = abs(Delta_21); [j] = find(min(z)==z); Chi_0 = rho(j,2); % Find Chi at Delta = 0

fig_2 = figure; plot(Delta_21,[imag(rho(:,2))/imag(Chi_0) real(rho(:,2))/imag(Chi_0)]);
axis([Delta_21(1) Delta_21(end) -1.1 1.1]); title('normalised absorption \chi_I');
xlabel('\Delta (MHz)'), ylabel(''); legend('\chi_{R}', '\chi_{I}');