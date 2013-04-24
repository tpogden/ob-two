function [t,rho] = ob_two_scan(p_in)
%% OB_TWO_SCAN. Solves two-level Optical Bloch with scan of detuning 
%
% In:       init_pop        num(2,1)  initial population of states (0 to 1)
%           scan_min        num       minimum detuning [2pi MHz]
%           scan_max        num       maximim detuning [2pi MHz]
%           scan_duration   num       time duration of the scan [µs]
%           Omega_21        num       Rabi frequency [2pi MHz]
%           Gamma_2         num       Natural linewidth [2pi MHz] 
%
% Out:      t       num(1,num_t_steps)  solved time vector
%           rho     num(4,num_t_steps)  solved density matrix elements
%
% Author:   T P Ogden  <t.p.ogden@durham.ac.uk>
%                     
% Notes:    Models OB equations for two level ladder system, with a
%           constant Rabi frequency and a scan of a detuning range. 
%           See test_f.m for an example of use.
                    
%% Convert parameters to dimensionless units

% Rabi frequency [2pi MHz]
p.Omega_21 = p_in.Omega_21;

% Pulse duration [µs])
p.pulse_21_duration = p_in.pulse_21_duration; % Scan duration 

p.Gamma_2 = p_in.Gamma_2;

p.gamma_21 = p_in.gamma_21; % [2pi MHz] Lorenzian laser linewidth

%% Rabi frequency and detuning functions

% Rabi frequency as function of time, square pulse
p.Omega_21_f = @(t) p.Omega_21*(t <= p.pulse_21_duration);

% Detuning as function of time, scan across the range defined by p.scan_min, p.scan_max
p.Delta_21_f = @(t) p_in.Delta_21_min ... 
                + (t./p_in.pulse_21_duration)*(p_in.Delta_21_max-p_in.Delta_21_min); % [MHz]

%% Set time domain and initial conditions
t_span = [0 p_in.duration]; % [µs]

% The initial populations of the density matrix. The density matrix is
% passed in as a vector.
init_cond = [p_in.init_pop(1) 0 0 p_in.init_pop(2)]';

atol=1e-5*ones(1,4); % tolerences for the Matlab solver
options = odeset('RelTol',1e-5,'AbsTol',atol);

%% Solve ODE with Runge-Kutta method
  
tic 
[t,rho] = ode23s(@(t,y) ob_two(t,y,p), t_span, init_cond, options); 
toc

end