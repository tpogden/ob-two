function [Delta] = delta_scan(t,scan_min,scan_max,scan_duration)
% DELTA_SCAN    Returns detuning at a time during a scan.  
%
% In:       t               num(1,:)    time points [µs]  
%           scan_min        number      Scan frequency start point [MHz]
%           scan_max        number      Scan frequency end point [MHz]
%           scan_duration   number      How long the scan will last [µs]            
%
% Out:      Delta           num(1,:)    the detuning at each point t [MHz]
%
% Author:   T P Ogden <t.p.ogden@durham.ac.uk>
%
% Notes:    In ob_two_scan and _pulse the detuning, Delta, is passed in as a
%           function. This one works for a scan.

    scan_range = scan_max - scan_min;

    Delta = scan_min + (t./scan_duration)*scan_range;
    
end % delta_scan