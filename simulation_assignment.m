%% Simulation assignment
clc
clear
clf

% batch simulation
Y0=[1000 0.1 1 0.5 2.6519e-01 0 0.1 0.0005 0.2095]; %S_ec G ATP Pyr cO2_L[mol/L] E X yCO2 yO2
[t,Y] = ode15s(@batch_function, [0 70], Y0);

for i=1:9
    subplot(3,3,i)
    plot(t,Y(:,i))
    if i==1
        title('[S_e_c]')
        xlabel('Time [h]')
        ylabel('Concentration [mmol L^-^1]')
    end
    if i==2
        title('[G]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==3
        title('[ATP]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==4
        title('[Pyr]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==5
        title('[c_O_2_L]')
        xlabel('Time [h]')
        ylabel('Concentration [M]')
    end
    if i==6
        title('[E]')
        xlabel('Time [h]')
        ylabel('Concentration [g L^-^1]')
    end
    if i==7
        title('[X]')
        xlabel('Time [h]')
        ylabel('Concentration [g L^-^1]')
    end
    if i==8
        title('[yCO2]')
        xlabel('Time [h]')
        ylabel('Mole fraction')
    end
    if i==9
        title('[yO2]')
        xlabel('Time [h]')
        ylabel('Mole fraction')
    end
end

biomass_produced = Y(end,7)-Y(1,7);
substrate_consumed = (1000/1000)*180; %mmol/L
Yield=biomass_produced/substrate_consumed

Productivity=biomass_produced/55
% plotta inte alla intracellulära metaboliter om det inte tillför något
% till resonemanget!!

%legend('[S_ec]','[G]','[ATP]', '[Pyr]', '[cO2_L]','[E]','[X]','[yCO2]','[yO2]')
%xlabel('Time (h)')
%ylabel('Koncentration')

%% Fed-batch
%100L reactor
clc, clear, clf
Y0=[0 0.375 0 2.6519e-01 20 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 
global F_in
global Vg
F_in=0.1;
V=20;
Vg=100-V;
Vfin=75;
time=[0 1];
Ytot=[];
Ttot=[];

while V<Vfin
[t,Y] = ode15s(@fedbatch_function, time, Y0);
V=Y(end,5);
time=time+1;
Y0=Y(end,:);

%save data
Ttot=[Ttot;t];
Ytot=[Ytot;Y];
end

for i=1:10
    subplot(2,5,i)
    plot(Ttot,Ytot(:,i))
        if i==1
        title('[S_e_c]')
        xlabel('Time (h)')
        ylabel('Concentration')
    end
    if i==2
        title('[X]')
        xlabel('Time (h)')
        ylabel('Concentration')
    end
    if i==3
        title('[E]')
    end
    if i==4
        title('[cO2_L]')
    end
    if i==5
        title('[V]')
    end
    if i==6
        title('[G]')
    end
    if i==7
        title('[ATP]')
    end
    if i==8
        title('[Pyr]')
    end
    if i==9
        title('[yO2]')
    end
    if i==10
        title('[yCO2]')
    end

end
biomass=Y(end,2)
endtime=Ttot(end)

biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5); %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-20)*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed

Productivity=biomass_produced/endtime

%% Fedbatch PI control
%100L reactor
clc, clear, clf
global F_in
V=20;
Y0=[0 0.375 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 yCO2 
time=[0 1]
Vfin = 75; %L 
F_in = 0.0005; %L/h
Esp = 1;
IntErr = 0;
Kp = 0.0001;
Ki = 0.00001;
Ttot=[];
Ytot=[];
Flows = [];

while V<Vfin
[t,Y] = ode15s(@fedbatch_function, time, Y0);

% save flows
Flows = [Flows;F_in*ones(size(t))];
Error=Esp-Y(end,3);
IntErr=IntErr+Error; 
V=Y(end,5);
F_in=F_in+(Kp*V*Error)+(Ki*IntErr);
if F_in<0
    F_in=0
end
%update time
time=time+1;
Y0=Y(end,:)

%save data
Ttot=[Ttot;t];
Ytot=[Ytot;Y];

%for i=1:10
    %subplot(2,5,i)
    %plot(t,Y(:,i))
        
%end
end

for d=1
    Volume=[Flows,Ytot(:,5)];
    Extra=[Ytot(:,1)/0.18,Ytot(:,2),Ytot(:,3)/0.18]; %Y(:,1) är i mmol/L inte g/L som jag trodde
    Intra=[Ytot(:,6),Ytot(:,7),Ytot(:,8)];
    oxygen=[Ytot(:,4)];
    offgas=[Ytot(:,9),Ytot(:,10)];
    subplot(2,3,1)
    plot(Ttot,Volume)
    title('Reactor volume and flow')
    legend('Flow','Volume')
    xlabel('Time [h]')
    ylabel('Volume [L]')
    grid on
    subplot(2,3,2)
    plot(Ttot,Extra)
    legend('S_e_c','X','E')
    xlabel('Time [h]')
    ylabel('Concentration [g L^-^1]')
    title('Extracellular metabolites')
    grid on
    subplot(2,3,3)
    plot(Ttot,Intra)
    title('Intracellular metabolites')
    legend('G','ATP','Pyr')
    xlabel('Time [h]')
    ylabel('Concentration [mM]')
    grid on
    subplot(2,3,4)
    plot(Ttot,oxygen)
    legend('cO_2L')
    title('Oxygen in liquid phase')
    xlabel('Time [h]')
    ylabel('Concentration [M]')
    grid on
    subplot(2,3,5)
    plot(Ttot,offgas)
    title('Off gas composition')
    legend('yO2','yCO2')
    xlabel('Time [h]')
    ylabel('mole fraction')
    grid on
end
endtime=Ttot(end)

biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5); %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-20)*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed

TRY=Ytot(end,2)*Yield*(Ytot(end,2)/endtime); %TRY
Productivity=biomass_produced/(endtime*Y(end,5))

%% 100L fed-batch with increased flow in end 
%100L reactor
clc, clear, clf
global F_in
V=20;
Y0=[0 0.375 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 yCO2 
time=[0 1]
Vfin = 75; %L
F_in = 0.0001; %L/h
Esp = 1;
IntErr = 0;
Kp = 0.0001;
Ki = 0.000001;
Ttot=[];
Ytot=[];
Flows = [];
    
while V<Vfin
[t,Y] = ode15s(@fedbatch_function, time, Y0);

% save flows
Flows = [Flows;F_in*ones(size(t))];
Error=Esp-Y(end,3);
IntErr=IntErr+Error; 
V=Y(end,5);
F_in=F_in+(Kp*V*Error)+(Ki*IntErr);
if F_in<0
    F_in=0
end
if Y(end,2)>4
    F_in=F_in+(Kp*V*Error)+(Ki*IntErr)+0.02;
end
%if Y(end,2)<0.8
 %   F_in=0.0001
%end
%update time
time=time+1;
Y0=Y(end,:)

%save data
Ttot=[Ttot;t];
Ytot=[Ytot;Y];

%for i=1:10
    %subplot(2,5,i)
    %plot(t,Y(:,i))
        
%end
end
endtime=Ttot(end)
flow=Flows(end);

for d=1
    Volume=[Flows,Ytot(:,5)];
    Extra=[Ytot(:,1),Ytot(:,2),Ytot(:,3)];
    Intra=[Ytot(:,6),Ytot(:,7),Ytot(:,8)];
    subplot(1,3,1)
    plot(Ttot,Volume)
    title('Reactor volume and flow')
    legend('Flow','Volume')
    xlabel('Time [h]')
    ylabel('Volume [L]')
    grid on
    subplot(1,3,2)
    plot(Ttot,Extra)
    legend('S_e_c','X','E')
    xlabel('Time [h]')
    ylabel('Concentration [g L^-^1]')
    title('Extracellular metabolites')
    grid on
    subplot(1,3,3)
    plot(Ttot,Intra)
    title('Intracellular metabolites')
    legend('G','ATP','Pyr')
    xlabel('Time [h]')
    ylabel('Concentration [mM]')
    grid on
end
biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5); %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-20)*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed

Productivity=(biomass_produced/endtime) %TRY

%% 10L fed-batch
%Ändra kLa till 1000
clc, clear, clf
global F_in
Y0=[0 0.375 0 2.6519e-01 20 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 
F_in=0.001;
V=2;
Vfin=7.5;
time=[0 1];
Ytot=[];
Ttot=[];

while V<Vfin
[t,Y] = ode15s(@fedbatch_function, time, Y0);
V=Y(end,5);
time=time+1;
Y0=Y(end,:)

%save data
Ttot=[Ttot;t];
Ytot=[Ytot;Y];
end

for i=1:10
    subplot(2,5,i)
    plot(Ttot,Ytot(:,i))
        if i==1
        title('[S_e_c]')
        xlabel('Time (h)')
        ylabel('Concentration')
    end
    if i==2
        title('[X]')
        xlabel('Time (h)')
        ylabel('Concentration')
    end
    if i==3
        title('[E]')
    end
    if i==4
        title('[cO2_L]')
    end
    if i==5
        title('[V]')
    end
    if i==6
        title('[G]')
    end
    if i==7
        title('[ATP]')
    end
    if i==8
        title('[Pyr]')
    end
    if i==9
        title('[yO2]')
    end
    if i==10
        title('[yCO2]')
    end

end
biomass=Y(end,2)
endtime=Ttot(end)

biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5); %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-20)*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed

Productivity=(biomass_produced/endtime) %TRY

%% 1000L with PI control
%1000L reactor
clc, clear, clf
global F_in
global Vg
global K_La
K_La = 400;
V=300;
Vg=1000-V;
Y0=[0 16 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 yCO2 
time=[0 1]
Vfin = 750; %L
F_in = 5; %L/h
Esp = 1;
IntErr = 0;
Kp = 0.0001;
Ki = 0;
Ttot=[];
Ytot=[];
Flows = [];
    
while V<Vfin
[t,Y] = ode15s(@fedbatch_function, time, Y0);

% save flows
Flows = [Flows;F_in*ones(size(t))];
Error=Esp-Y(end,3);
IntErr=IntErr+Error; 
V=Y(end,5);
F_in=F_in+(Kp*V*Error)+(Ki*IntErr);
if F_in<0
    F_in=0
end
%if Y(end,2)>50
 %   F_in=F_in+(Kp*V*Error)+(Ki*IntErr)+0.02;
%end
%update time
time=time+1;
Y0=Y(end,:)

%save data
Ttot=[Ttot;t];
Ytot=[Ytot;Y];
end
endtime=Ttot(end)
flow=Flows(end);

for d=1
    Volume=[Flows,Ytot(:,5)];
    Extra=[Ytot(:,1),Ytot(:,2),Ytot(:,3)];
    Intra=[Ytot(:,6),Ytot(:,7),Ytot(:,8)];
    Offgas=[Ytot(:,9),Ytot(:,10)];
    subplot(1,4,1)
    plot(Ttot,Volume)
    title('Reactor volume and flow')
    legend('Flow','Volume')
    xlabel('Time [h]')
    ylabel('Volume [L]')
    grid on
    subplot(1,4,2)
    plot(Ttot,Extra)
    legend('S_e_c','X','E')
    xlabel('Time [h]')
    ylabel('Concentration [g L^-^1]')
    title('Extracellular metabolites')
    grid on
    subplot(1,4,3)
    plot(Ttot,Intra)
    title('Intracellular metabolites')
    legend('G','ATP','Pyr')
    xlabel('Time [h]')
    ylabel('Concentration [mM]')
    grid on
    subplot(1,4,4)
    plot(Ttot,Offgas)
    legend('O2','CO2')
    grid on
end
biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5) %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-20)*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed
Productivity=biomass_produced/(endtime*Y(end,5))

%% 10 000L reactor

