function [t,rho] = ob_two_pulse(p_in)              
% OB_TWO_PULSE  Models the evolution of the density matrix of a two-level atom
%               in a square-pulsed laser field with detuning using ob_two.  
%
% In:       p_in.init_pop       num(2,1)    init population of the two states
%           p_in.Omega_21       num         Rabi frequency coupling states
%           p_in.Delta_21       num         detuning
%           p_in.gamma_21       num         laser linewidth
%           p_in.Gamma_2        num         natural linewidth of spontaneous
%           p_in.pulse_duration num         Duration of the pulse
%           p_in.duration       num         Duration of the solution
%           
% Out:      t       num(1,:)        Time vector
%           rho     num(4,:)        Evolution of the density matrix over t
%
% Author:   T P Ogden <t.p.ogden@durham.ac.uk>
%
% Notes:    See ob_two_pulse_test_[a-d].m for examples of use.
                
%% Rabi frequency and detuning as functions of time             

p.Omega_21_f = @(t) p_in.Omega_21*(t <= p_in.pulse_duration); % [2pi MHz] Rabi freq, square pulse
p.Delta_21_f = @(t) p_in.Delta_21; % [2pi MHz] detuning, constant

p.Gamma_1 = p_in.Gamma_1;
p.Gamma_2 = p_in.Gamma_2;

p.gamma_21 = p_in.gamma_21;

%% Set time domain and initial conditions
t_span = [0 p_in.duration]; % [µs]

init_cond = [p_in.init_pop(1) 0 0 p_in.init_pop(2)]'; % initial populations

options = odeset('RelTol',1e-5);

%% Solve ODE with Runge-Kutta method

tic
[t,rho] = ode23s(@(t,y) ob_two(t,y,p), t_span, init_cond, options);
toc

end
