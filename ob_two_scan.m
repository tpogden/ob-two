function [t,rho] = ob_two_scan(p_in)
%% OB_TWO_SCAN. Solves two-level Optical Bloch with scan of detuning 
%
% In:       init_pop        num(2,1)  initial population of states (0 to 1)
%           scan_min        num       minimum detuning [2pi MHz]
%           scan_max        num       maximim detuning [2pi MHz]
%           scan_duration   num       time duration of the scan [탎]
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

% Natural linewidth due to spontaneous emmision. We're scaling in terms of
% this so make it equal unity.
p.Gamma_2 = 1; 

% Rabi frequency [dimensionless] ([2pi MHz]/Gamma_2[2pi MHz])
p.Omega_21 = p_in.Omega_21/p_in.Gamma_2;  

%Scan Parameters [dimensionless] ([2pi MHz]/Gamma_2[2pi MHz])
p.scan_min = p_in.scan_min/p_in.Gamma_2;
p.scan_max = p_in.scan_max/p_in.Gamma_2;

decay_lifetime = 1/(2*pi*p_in.Gamma_2); % [탎] 

% Pulse duration (dimensionless [탎]/decay_lifetime[탎])
p.pulse_duration = p_in.scan_duration/decay_lifetime; % Scan duration 

p.gamma_21 = p_in.gamma_21/p_in.Gamma_2; % [dimless] Lorenzian laser linewidth

%% Rabi frequency and detuning functions

% The Rabi frequency is passed in as a function of time. In this case it is
% a square pulse of duration specified by p.pulse_duration
p.Omega_21_f = @(t) omega_pulse(t,p.Omega_21,p.pulse_duration);

% The detuning is passed in as a function of time. In this case it is a scan
% function across the range defined by p.scan_min, p.scan_max and p.pulse_duration.
p.Delta_21_f = @(t) delta_scan(t,p.scan_min,p.scan_max,p.pulse_duration);

%% Set time domain and initial conditions
t_span = [0 p.pulse_duration]; % [탎]

% The initial populations of the density matrix. The density matrix is
% passed in as a vector.
init_cond = [p_in.init_pop(1) 0 0 p_in.init_pop(2)]';

atol=1e-5*ones(1,4); % tolerences for the Matlab solver
options = odeset('RelTol',1e-5,'AbsTol',atol);

%% Solve ODE with Runge-Kutta method
  
tic 
[t,rho] = ode23s(@(t,y) ob_two(t,y,p), t_span, init_cond, options); 
toc

t = t.*decay_lifetime; % [탎] Convert time back to SI

end