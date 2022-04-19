function dYdt=Ex_B3(t,Y)
% define internal variables
S = Y(1,1);
X = Y(2,1);
P = Y(3,1);
O2 = Y(4,1);

%define parameter
mymax = 0.3; %/h
K_s = 0.6; %g/L
V_G = 1; %L
Q = 120; %L/h
y_O2in = .2095; % i% 
c_O2sat = 0.265 %mM
K_La = 500; %/h
He = 790; %atm L/mol

my = (mymax*S)/(K_s+S);
Y_xs = 0.3657;
Y_sx = 1/0.3657;
Y_px = 0.17/3.84;

%c_O2 = (Q*y_O2in)/(V_G*He);
OTR = 8.1*10^-3; %mol/Lh
r_O2 = (Q*y_O2in)*X;
 % Yxo=my/q0 --> q0=my/Yxo;
%Yxo=(32*0.000265)/3.84=0.0022 g/g
%OCR = (my/0.0022)*X;

%define derivatives
dSdt = -Y_sx*my*X; %
dXdt = my*X;
dPdt = Y_px*X;
dO2dt = -r_O2+OTR;

dYdt(1,1) = dSdt;
dYdt(2,1) = dXdt;
dYdt(3,1) = dPdt;
dYdt(4,1) = dO2dt;