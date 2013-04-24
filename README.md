# OB Two

by Tommy Ogden <<t.p.ogden@durham.ac.uk>>

## What is this?

This Matlab code solves the Optical Bloch equations for light interacting with an ensemble of two-level atoms in the rotating wave approximation.

Define functions for the Rabi frequency and detuning of the laser and the initial populations of the atomic levels and the code will solve the system with a Runge-Kutta method.

Two kinds of system are modelled: a square pulse through medium and a scan across the detuning.

It will plot 

- The populations and relative absorption and dispersion vs time (for a pulse) or detuning (for a scan)
- Relative absorption and dispersion vs time (for a pulse) or detuning (for a scan)
- Bloch sphere trajectories

It saves the data in CSV files in the folder `ob-two/csv`.

## How do I use it?

Open `ob-two` in Matlab and run a test, e.g.

    >> ob_two_pulse_test_a  

## Examples

These example tests are included:

- Pulse Test A:
- Pulse Test B:
- Pulse Test C:
- Pulse Test D:

- Scan Test A:
- Scan Test B:

You can make your own tests by copying an existing one and changing the _Parameters_ section.

## Notes

The Optical Bloch equations are described in my first year PhD report 'Atom Light Interactions in a Blockaded Medium'. For derivation of the equations see Atomic Physics, Foot.