 function [Omega] = omega_pulse(t,rabi_frequency,pulse_duration)
% OMEGA_PULSE    Returns frequency at a time during a pulse.  
%
% In:       t               num(1,:)    time points [µs]  
%           rabi_frequency  num         Scan frequency start point [MHz]
%           pulse_duration  num         How long the scan will last [µs]            
%
% Out:      Omega           num(1,:)    the frequency at each point t [MHz]
%
% Author:   T P Ogden <t.p.ogden@durham.ac.uk>
%
% Notes:    In ob_two_scan and _pulse the frequency, Omega, is passed in as a
%           function. This one works for a pulse: constant before being cut off to zero.
 
    Omega = rabi_frequency*(t <= pulse_duration);
    
 end % omega_pulse