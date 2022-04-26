%% Simulation assignment

% matrices
A=[-1 0; 0 0; 0 0; 0 -1; 0 0; 0 -1; 0 0];

B=[0 0; 0 0; 0 0; 1 0; 1 1; 1 -1; 0 -1];

gamma=[0;1;0;0;0;0;1];

G=[1 0 0; -1 -1 0; -1 1 1; 0 1 -1; 0 0 -1; 0 1 0; 0 -1 0];

% batch simulation
Y0=[0.1 1000 1 0.5 2.6519e-04 0 0.1 0.0005 0.2095]; %S_ec G ATP Pyr cO2_L E X yCO2 yO2
[t,Y] = ode15s(@simulation_function, [0 36], Y0);
plot(t,Y)
