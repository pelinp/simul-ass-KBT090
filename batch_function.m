 function dYdt=batch_function(t,Y)

S_ec = Y(1);
G = Y(2);
ATP = Y(3);
Pyr = Y(4);
cO2_L = Y(5);
E = Y(6);
X= Y(7);
yCO2 = Y(8);
yO2 = Y(9);

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
g22=10; %mmol ATP/mmol S
gamma71=0.025; %gX/mmol E
g72=12; %mmol ATP/mmol E

% parameters
G0 = 1000; %mmol/L
S_ec0 = 0.1; %mM
ATP0 = 1; %mM
Pyr0 = 0.5; %mM
X0 = 0.1; %g/L

V = 75; %L
F_in = 0;
K_La = 500; %/h
P_tot = 1; %? atm 
He = 790/1000; %atm L/mmol
Q = 1*V*60; %VVM at 20°C and 1atm
Vg = 25; %L
y_CO2in = 0.0005;
y_O2in = 0.2095; 
T=293; %K
R=0.08206/1000; %atm L/mmol K
rho=500; %g DW/L cell

% Matrices
A = [-1 0; 0 0; 0 0; 0 -3; 0 0; 0 -4; 0 0];
B = [0 0; 0 0; 0 0; 3 0; 1 1; 2 -1; 0 -1];
gamma = [0;gamma21;0;0;0;0;gamma71];
Gmet = [1 0 0; -1 -g22 0; -1 2 2; 0 6 -1; 0 0 -1; 0 8 0; 0 -g72 0];

%Kinetic rate expressions:
q(1,1)=q1_max*S_ec/((K_1Sec+S_ec));
q(2,1)=q2_max*G*ATP/((K_2G+G)*(K_2ATP+ATP));
q(3,1)=q3_max*G*ATP/((K_3G+G)*(K_3ATP+ATP)*(1+ATP/K_3IATP));
q(4,1)=q4_max*Pyr*cO2_L/((K_4Pyr+Pyr)*(K_4O2+cO2_L)*(1+S_ec/K_4ISec)); 
q(5,1)=q5_max*Pyr/(K_5Pyr+Pyr);
q(6,1)=q6_max*E*cO2_L/((K_6E+E)*(K_6O2+cO2_L)*(1+S_ec/K_6ISec));
q(7,1)=q7_max*E*ATP/((K_7E+E)*(K_7ATP+ATP)*(1+S_ec/K_7ISec));

v = [q(1,1);q(2,1);q(3,1);q(4,1);q(5,1);q(6,1);q(7,1)];
%specific reaction rates
r_s=A'*v; %[Glucose; O2]
r_p=B'*v; %[CO2; Ethanol]
r_x=gamma'*v; %[Cells]
r_met=Gmet'*v; %[Glucose_cyt(S_ec); ATP; Pyr]

grho_ATP=(Gmet(:,2).*rho)'*v;
grho_Pyr=(Gmet(:,3).*rho)'*v;
grho_G=(Gmet(:,1).*rho)'*v;

my = r_x; 

%derivatives
dS_ecdt = r_s(1)*X; %+((F_in/V)*(S0-S))
dGdt = -my*G+grho_G;
dATPdt = -my*ATP+grho_ATP;
dPyrdt = -my*Pyr+grho_Pyr;
dcO2_Ldt = K_La*(yO2*P_tot/He-cO2_L)+(r_s(2)*X);
dEdt = r_p(2)*X;
dXdt =  (r_x*X); %-((F_in/V)*X)
dyCO2dt =  (Q/Vg)*(y_CO2in-((1-y_O2in-y_CO2in)/(1-yO2-yCO2))*yCO2)+r_p(1)*X*V*((R*T)/(Vg*P_tot));
dyO2dt = (Q/Vg)*(y_O2in-((1-y_O2in-y_CO2in)/(1-yO2-yCO2))*yO2)-K_La*((yO2*P_tot/He)-cO2_L)*V*(R*T/(Vg*P_tot));

dYdt=[ dS_ecdt
       dGdt 
       dATPdt 
       dPyrdt 
       dcO2_Ldt 
       dEdt
       dXdt 
       dyCO2dt 
       dyO2dt];

