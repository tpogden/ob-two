function [t,rho] = ob_two_ramsey(p_in)     





%% Rabi frequency and detuning as functions of time    

pulse_1 = @(t) p_in.Omega_21*((t > p_in.pulse_1_start) & (t <= p_in.pulse_1_end));
pulse_2 = @(t) p_in.Omega_21*((t > p_in.pulse_2_start) & (t <= p_in.pulse_2_end));

p.Omega_21_f = @(t) (pulse_1(t) + pulse_2(t)); % Rabi frequency, square pulse
p.Delta_21_f = @(t) p_in.Delta_21; % detuning, constant

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
