function dYdt=Ex_B4_D(t,Y)
S = Y(1,1);
X = Y(2,1);
V = Y(3,1);
O2 = Y(4,1);
O2g = Y(5,1);
CO2g = Y(6,1);
Vg = Y(7,1);

%parameters
F_in = 0.02; %L/h
S0 = 100; %g/L --> concentration med flödet
mymax=0.5; %/h
K_s=0.5; %g/L
K_La=500; %/h
He=790; %atm L/mol for O
P_tot=1; %atm
T=293; %K
R=0.08206; %atm L/mol K
y_O2in=0.2095; 
y_CO2in = 0.0004; 
Q=60; %L/h



Yxs=0.5; %gX/gS
Ysx=1/Yxs; %g/g
Yos=0.01; %mol/g
Ycs=0.01; %mol/g
Yox=Ysx*Yos;
Yco2x=Ysx*Ycs;

% variables
my = (mymax*S)/(K_s+S);

%derivatives
dSdt = -Ysx*my*X+((F_in/V)*(S0-S));
dXdt = (my*X)-((F_in/V)*X);
dVdt = F_in;
dO2dt = K_La*(O2g*P_tot/He-O2)-(Yox*my*X);
dO2gdt = (Q/Vg)*(y_O2in-((1-y_O2in-y_CO2in)/(1-O2g-CO2g))*O2g)-K_La*((O2g*P_tot/He)-O2)*V*(R*T/(Vg*P_tot));
dCOg2dt = (Q/Vg)*(y_CO2in-((1-y_O2in-y_CO2in)/(1-O2g-CO2g))*CO2g)+Yco2x*my*X*V*((R*T)/(Vg*P_tot));
dVgdt = -F_in;

dYdt(1,1) = dSdt;
dYdt(2,1) = dXdt;
dYdt(3,1) = dVdt;
dYdt(4,1) = dO2dt;
dYdt(5,1) = dO2gdt;
dYdt(6,1) = dCOg2dt;
dYdt(7,1) = dVgdt;