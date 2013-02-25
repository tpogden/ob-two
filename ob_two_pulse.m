function [t,rho] = ob_two_pulse(p_in)              
% OB_TWO_PULSE  Models the evolution of the density matrix of a two-level atom
%               in a square-pulsed laser field with detuning using ob_two.  
%
% In:       p_in.init_pop       num(2,1)    init population of the two states
%           p_in.Omega_21       num         Rabi frequency coupling states
%           p_in.Delta_21       num         detuning
%           p_in.Gamma_2        num         natural linewidth of spontaneous 
%           p_in.pulse_duration num         Duration of the pulse
%           p_in.duration       num         Duration of the solution
%           
% Out:      t       num(1,:)        Time vector
%           rho     num(4,:)        Evolution of the density matrix over t
%
% Author:   T P Ogden <t.p.ogden@durham.ac.uk>
%
% Notes:    See ob_two_test_[a-d].m for examples of use.
                
%% Convert parameters to dimless units               

% Natural linewidth due to spontaneous emmision. We're scaling in terms of
% this so make it equal unity.
p.Gamma_2 = 1;

p.Omega_21 = p_in.Omega_21/p_in.Gamma_2; % [dimless] Rabi frequency ([2pi MHz]/Gamma_2[2pi MHz])
p.Delta_21 = p_in.Delta_21/p_in.Gamma_2; % Detuning [dimless] ([2pi MHz]/Gamma_2[2pi MHz]) 

decay_lifetime = 1/(2*pi*p_in.Gamma_2); % [µs] 

p.pulse_duration = p_in.pulse_duration/decay_lifetime; % [dimless] pulse duration
duration = p_in.duration/decay_lifetime; % [dimless] total duration

%% Rabi frequency and detuning as functions of time

p.Omega_21_f = @(t) omega_pulse(t,p.Omega_21,p.pulse_duration); % Rabi frequency, square pulse
p.Delta_21_f = @(t) p.Delta_21; % detuning, constant

%% Set time domain and initial conditions
t_span = [0 duration]; % [dimless]

init_cond = [p_in.init_pop(1) 0 0 p_in.init_pop(2)]'; % initial populations

%atol=1e-5*ones(1,4); % Tolerances for ODE solver
options = odeset('RelTol',1e-5);%,'AbsTol',atol);

%% Solve ODE with Runge-Kutta method

tic
[t,rho] = ode23s(@(t,y) ob_two(t,y,p), t_span, init_cond, options);
toc

t = t*decay_lifetime; % [µs] Convert time back to SI units

end