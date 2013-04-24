function [dydt] = ob_two(t,y,p_in)
% OB_TWO    Optical Bloch equations for a two-level ladder system in the rotating wave approx.  
%
% In:       t               num         time
%           y               num(1,4)    Bloch ODE system vector (density matrix elements)    
%           p.Omega_21_f    function    Rabi frequency
%           p.Gamma_2_f     function    Natural linewidth of spontanous emission
%           
% Out:      dydt            num(1,4)   ODE solution vector
%
% Notes:    Models OB equations for two-level ladder system, with functions
%           of time for Rabi frequency and detuning. See ob_two_pulse and 
%           ob_two_scan for examples of use. 
%
%           -- |2>                      rho = [ rho_11 rho_12 ]
%           |                                 [ rho_21 rho_22 ] 
%           | Omega_21
%           |
%           -- |1>

%% Density matrix and Hamiltonian

rho = transpose(reshape(y,2,2)); % Density matrix, convert (1,4) to (2,2)

Omega_21 = p_in.Omega_21_f(t); % Rabi Frequency (function of time)

Delta_21 = p_in.Delta_21_f(t); % Detuning function (function of time)

H = [       0    Omega_21; 
     Omega_21 -2*Delta_21]/2; % Hamiltonian

%% Decoherence 

% decoherence due to spontaneous emission + Lorenzian laser linewidth 
Gamma_21 = p_in.Gamma_2/2 + p_in.gamma_21;

% Lindblad operator
lindblad = zeros(2,2);
lindblad(1,1) = -p_in.Gamma_2*rho(2,2);
lindblad(1,2) = Gamma_21*rho(1,2);
lindblad(2,1) = Gamma_21*rho(2,1);
lindblad(2,2) = p_in.Gamma_2*rho(2,2);
     
%% Liouville equation
ddt_rho = 1i*(rho*H - H*rho) - lindblad;

dydt = reshape(transpose(ddt_rho),4,1); % Convert (2,2) back to (1,4)

end