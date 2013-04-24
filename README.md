# OB Two

by Tommy Ogden <<t.p.ogden@durham.ac.uk>>

## What is this?

This Matlab code solves the Optical Bloch equations for light interacting with an ensemble of two-level atoms in the rotating wave approximation.

Define functions for the Rabi frequency and detuning of the laser and the initial populations of the atomic levels and the code will solve the system with a Runge-Kutta method.

Three kinds of system are modelled: a square pulse through medium, a scan across the detuning and a Ramsey-type double pulse.

It will plot

- The populations vs time (for a pulse) or detuning (for a scan)
- Relative absorption and dispersion vs time (for a pulse) or detuning (for a scan)
- Bloch sphere trajectories

It saves the data in CSV files in the folder `ob-two/csv`.

## How do I use it?

Go to `ob-two` in Matlab and run a test, e.g.

    >> ob_two_pulse_test_a  

## Examples

These example tests are included:

- Pulse Test A: 2π pulse
- Pulse Test B: 2π pulse with detuning
- Pulse Test C: 4π pulse with decay
- Pulse Test D: 4π pulse with detuning and decay
- Pulse Test E: ½π pulse
- Ramsey Test A: A Ramsey-type double pulse
- Scan Test A: A scan with parameters for the Rb87 D2 line
- Scan Test B: A scan with example parameters

You can make your own tests by copying an existing one and changing the _Parameters_ section.

## Notes

The Optical Bloch equations are described in my report [Atom Light Interactions in a Rydberg Blockaded Medium](https://dl.dropbox.com/u/349151/2012-06-15_first_year_report_v1.pdf). For derivation of the equations see for example §7 of Atomic Physics by CJ Foot.

[1] 