%% Simulation assignment 

function q=batch(t,Y)

S_ec = Y(1,1);
G = Y(2,1);
ATP = Y(3,1);
Pyr = Y(4,1);
cO2_L = Y(5,1);
E = Y(6,1);
X= Y(7,1);
yCO2 = Y(8,1);
yO2 = Y(9,1);

%kinetic parameters
q1_max = 14; %mmol/gDW/h
K_1Sec = 1; %mM

q2_max = 2.7; %mmol/gDW/h
K_2G = 0.05; %mM
K_2ATP = 0.20; %mM

q3_max = 60; %mmol/gDW/h 
K_3G = 0.8; %mM intracell.
K_3ATP = 0.5;%mM intracell.
K_3IATP = 1; %mM intracell.

q4_max = 10; %mmol/gDW/h
K_4Pyr = 0.2; %mM intracell.
K_4O2 = 0.02; %mM
K_4ISec = 1; %mM 

q5_max = 40; %mmol/gDW/h 
K_5Pyr = 5;  %mM intracell.

q6_max = 6; %mmol/gDW/h
K_6E = 3; %mM
K_6O2 = 0.02; %mM
K_6ISec = 0.5; %mM

q7_max = 2; %mmol/gDW/h
K_7E = 0.5; %mM
K_7ATP = 0.5; %mM
K_7ISec = 0.5; %mM

%Stoichiometric coefficients
%True biomass yield in biosynthesis (1 C-mol glucose -> 1 C-mol cells)
gamma21=0.15; %gX / mmol S 
%ATP cons due to growth
g21=10; %mmol ATP/mmol S
gamma71=0.025; %gX/mmol E
g71=12; %mmol ATP/mmol E

%Kinetic rate expressions:
v1=q(1,1)=q1_max*S_ec/((K_1Sec+S_ec));
v2=q(2,1)=q2_max*G*ATP/((K_2G+G)*(K_2ATP+ATP));
v3=q(3,1)=q3_max*G*ATP/((K_3G+G)*(K_3ATP+ATP)*(1+ATP/K_3IATP));
v4=q(4,1)=q4_max*Pyr*cO2_L/((K_4Pyr+Pyr)*(K_4O2+cO2_L)*(1+S_ec/K_4ISec)); 
v5=q(5,1)=q5_max*Pyr/(K_5Pyr+Pyr);
v6=q(6,1)=q6_max*E*cO2_L/((K_6E+E)*(K_6O2+cO2_L)*(1+S_ec/K_6ISec));
v7=q(7,1)=q7_max*E*ATP/((K_7E+E)*(K_7ATP+ATP)*(1+S_ec/K_7ISec));

dS_ecdt = -r_s*X+((F_in/V)*(S0-S));
dGdt = 
dATPdt = 
dPyrdt = 
dcO2_Ldt = K_La*(O2g*P_tot/He-O2)-(r_o*X);
dEdt = 
dXdt = (r_x*X)-((F_in/V)*X);
dyCO2dt = (Q/Vg)*(y_CO2in-((1-y_O2in-y_CO2in)/(1-O2g-CO2g))*CO2g)+Yco2x*my*X*V*((R*T)/(Vg*P_tot));
dyO2dt = (Q/Vg)*(y_O2in-((1-y_O2in-y_CO2in)/(1-O2g-CO2g))*O2g)-K_La*((O2g*P_tot/He)-O2)*V*(R*T/(Vg*P_tot));

