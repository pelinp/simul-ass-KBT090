function dYdt=Ex_B4gas(t,Y)

O2 = Y(1,1);
CO2 = Y(2,1);
Vg = Y(3,1);


%parameters
F_in = 0.2; %L/h
S0 = 25; %g/L --> concentration med flödet
mymax=0.5; %/h
K_s=0.5; %g/L
K_La=500; %/h
He=790; %atm L/mol for O
P_tot=1; %atm
T=293; %K
R=0.08206; %atm L/mol K
y_O2in=0.2095; 


Yxs=0.5; %g/g
Ysx=1/Yxs; %g/g
Yos=0.01; %mol/g
Ycs=0.01; %mol/g
Yox=Ysx*Yos;

% variables
my = (mymax*S)/(K_s+S);

%derivatives
dO2dt = 
dCO2dt = 
dVgdt = -F0;

dYdt(1,1) = dO2dt;
dYdt(2,1) = dCO2dt;
