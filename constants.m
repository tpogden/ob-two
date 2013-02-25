function [c] = constants
%% CONSTANTS      Physical Constants in SI units 
%
% Author:   Tommy Ogden <t.p.ogden@durham.ac.uk>
%
% Notes:    Run this script within Matlab code to add these physical constants
%           to the workspace.

%% Physical Constants

c.c       = 2.99792458e8;    % Speed of light in vacuo (m/s)

c.a_0     = 5.291772108e-11; % Bohr radius (m)

c.e       = 1.602176487e-19; % Elementary charge (C)

c.eps_0    = 8.854187817e-12; % Vacuum Permittivity (F/m) or [C^2/N]

c.hbar    = 1.054571726e-34; % Reduced Planck constant (Js)

c.amu     = 1.660538921e-27; % atomic mass unit (kg)

c.N_A     = 6.0221412927e23; % Avogadro constant (/mol)

c.k_B     = 1.380648813e-23; % Boltzmann constant (J/K)

end