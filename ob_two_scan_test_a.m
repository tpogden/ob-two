% Test of: ob_two_scan.m
%
% Author:   T P Ogden <t.p.ogden@durham.ac.uk>
%
% Notes:    Solving the OB equations with constant Rabi frequency
%           and a scan across the detuning. Uses the Rb87 D2 line
%           natural linewidth. This test is to see if, using the 
%           same parameters, we can match that of a model by Jon Pritchard. 
%           See http://massey.dur.ac.uk/jdp/code.html#obe1
%
%           Rb87 D2 line: 5S_1/2 |F=2, m_F=2> to 5P_3/2 |F'=3, m_F'=3>

%% Test system parameters 

clear all;

p.Gamma_2 = 1;  % natural linewidth of spontaneous decay for Rb87 [2pi MHz]
p.Omega_21 = 100;  % Rabi frequency [2pi MHz]

% detuning scan parameters
p.scan_min = -20;           % scan range [2pi MHz]
p.scan_max = 20;
p.scan_duration = 500;        % scan duration [1e-6 s]

% initial populations of the states. Here we start with all population in the 
% ground state.
p.init_pop = [1;0];

%% Scan and solve

[t,rho] = ob_two_scan(p);

% Create the detuning vector for plots.
Delta_21 = delta_scan(t,p.scan_min,p.scan_max,p.scan_duration);

%% Plots

plot_population_detuning(Delta_21,rho);

d_eg = 2.534e-29; %  transition dipole moment [C m]
n = 1e20; % [/m3] atomic number density (N/V)

plot_susceptibility_detuning(Delta_21,rho,d_eg,n);

plot_bloch_sphere(t,rho);