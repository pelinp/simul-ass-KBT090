%% B2
%a)
%t1=15 t2=24 t3=24 t4=38 t5=48
%ddtc1_o2=((5.0*10^-2)-(1.6*10^-1))/(24-0);
r0_o2=0.9*(0.23-1.6*10^-1);
r1_o2=0.9*(0.23-6.0*10^-2);
r2_o2=0.9*(0.23-5.0*10^-2);
r3_o2=0.9*(0.23-3.2*10^-2);
r4_o2=0.9*(0.23-3.0*10^-2);

q0_o2=(r0_o2)/(2.0*10^8); %vi tar cellantalet per L inte mL
q1_o2=(r1_o2)/(4.5*10^8); 
q2_o2=(r2_o2)/(6.0*10^8);
q3_o2=(r3_o2)/(7.7*10^8);
q4_o2=(r4_o2)/(9.5*10^8);

time = [0;15;24;38;48];
r_o2 = [r0_o2;r1_o2;r2_o2;r3_o2;r4_o2];
q_o2 = [q0_o2;q1_o2;q2_o2;q3_o2;q4_o2];
answerB2 = table(time,r_o2,q_o2)

% c) Subtstratet kanske börjar ta slut. Viskositeten blir större när man har
%mer celler--> kan påverka q. Cellerna kanske börjar dö...

%% B3
% A)
% Monod kinetics 
D = 0.043; %h^-1
S_0 = 10.6; %g/L
S = 0.10; %g/L
X = 3.84; %g/L
P = 0.17; % g/L
CER = 8.1; % mmol/Lh
OTR = 7.3; %mmol/Lh

%steady-state continous (chemostat) --> D=μ
% Monod kinetics: μ=μ_max(S/(S+K_s))
% where μ_max is the maximum specific growth rate and K_s is the substrate
% concentration corresponding to μ_max/2

% a) calcilate the yield of 

% biomass Y_X
S_consumed = (S_0-S);
Y_xs = X/S_consumed;

% xylitol Y_P
Y_ps = P/S_consumed;

% O_2 Y_O2 [mmol/g]
% [mmol/Lh]/[g/L]
Y_O2s = OTR/(S_consumed*D);

% CO_2 Y_CO2
Y_CO2s = CER/(S_consumed*D);

% The CER is slightly higher than the OTR because the molemasses of the two
% compunds differ slightly. This must be wrong...

%% B3 B)
clear, clc
%S0=20g/L, X0=0.1g/L, P0=0mM V_L = 2L
Y0 = [20 0.1 0 0.000265]';
[t,Y]=ode15s(@Ex_B3, [0 30], Y0);

plot(t,Y)


