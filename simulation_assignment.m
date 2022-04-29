%% Simulation assignment
clc
clear
clf

% batch simulation
Y0=[1000 0.1 1 0.5 2.6519e-01 0 0.1 0.0005 0.2095]; %S_ec G ATP Pyr cO2_L E X yCO2 yO2
[t,Y] = ode15s(@simulation_function, [0 36], Y0);
plot(t,Y)
legend('[S_ec]','[G]','[ATP]', '[Pyr]', '[cO2_L]','[E]','[X]','[yCO2]','[yO2]')
xlabel('Time (h)')
ylabel('Koncentration')
