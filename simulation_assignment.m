%% Simulation assignment
clc
clear
clf

% batch simulation
Y0=[1000 0.1 0 2.6519e-01 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L G ATP Pyr yO2 yCO2
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
        title('[X]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==3
        title('[E]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==4
        title('[cO2_L]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==5
        title('[G]')
        xlabel('Time [h]')
        ylabel('Concentration [M]')
    end
    if i==6
        title('[ATP]')
        xlabel('Time [h]')
        ylabel('Concentration [g L^-^1]')
    end
    if i==7
        title('[Pyr]')
        xlabel('Time [h]')
        ylabel('Concentration [g L^-^1]')
    end
    if i==8
        title('[yO2]')
        xlabel('Time [h]')
        ylabel('Mole fraction')
    end
    if i==9
        title('[yCO2]')
        xlabel('Time [h]')
        ylabel('Mole fraction')
    end
    set(gca,'fontname','times')
    set(findall(gcf,'-property','FontSize'),'FontSize',12)
end

biomass_produced = Y(end,2)-Y(1,2) %g/L --> Titer
substrate_consumed = (1000/1000)*180; %mmol/L
Yield=biomass_produced/substrate_consumed

Productivity=biomass_produced/55 %55 är tiden då all substrat tagit slut..
% plotta inte alla intracellulära metaboliter om det inte tillför något
% till resonemanget!!

%legend('[S_ec]','[G]','[ATP]', '[Pyr]', '[cO2_L]','[E]','[X]','[yCO2]','[yO2]')
%xlabel('Time (h)')
%ylabel('Koncentration')

%% 10L batch
clc
clear
clf

% batch simulation
Y0=[1000 0.1 0 2.6519e-01 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L G ATP Pyr yO2 yCO2
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
        title('[X]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==3
        title('[E]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==4
        title('[cO2_L]')
        xlabel('Time [h]')
        ylabel('Concentration [mM]')
    end
    if i==5
        title('[G]')
        xlabel('Time [h]')
        ylabel('Concentration [M]')
    end
    if i==6
        title('[ATP]')
        xlabel('Time [h]')
        ylabel('Concentration [g L^-^1]')
    end
    if i==7
        title('[Pyr]')
        xlabel('Time [h]')
        ylabel('Concentration [g L^-^1]')
    end
    if i==8
        title('[yO2]')
        xlabel('Time [h]')
        ylabel('Mole fraction')
    end
    if i==9
        title('[yCO2]')
        xlabel('Time [h]')
        ylabel('Mole fraction')
    end
end

biomass_produced = Y(end,2)-Y(1,2) %g/L
substrate_consumed = (1000/1000)*180; %mmol/L
Yield=biomass_produced/substrate_consumed

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

clf

Extra=[Ytot(:,1),Ytot(:,2),Ytot(:,3)];
subplot(1,2,1)
yyaxis left
set(gca, 'yColor','r')
plot(Ttot,Ytot(:,1),'b-',Ttot,Ytot(:,2),'r-',Ttot,Ytot(:,3),'g-')
legend('[S_ec]','[X]','[E]','FontSize',14)
xlabel('Time [h]','FontSize', 14)
ylabel('Concentration [g L^-^1]','Color','r','FontSize', 14)
yyaxis right
set(gca, 'yColor','k')
ylabel('Concentration [mM]','FontSize', 14)
title('Extracellular metabolites','FontSize', 16)
set(gca,'fontname','times')
grid on
subplot(1,2,2)
yyaxis left
set(gca, 'yColor','r')
plot(Ttot,Ytot(:,1),'b-',Ttot,Ytot(:,2),'r-',Ttot,Ytot(:,3),'g-')
legend('[S_ec]','[X]','[E]','FontSize',14)
xlabel('Time [h]','FontSize', 14)
ylabel('Concentration [g L^-^1]','Color','r','FontSize', 14)
yyaxis right
set(gca, 'yColor','k')
ylabel('Concentration [mM]','FontSize', 14)
title('Extracellular metabolites','FontSize', 16)
set(gca,'fontname','times')
grid on


biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5); %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-20)*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed
Titer=biomass_produced/Ytot(end,5)
Productivity=biomass_produced/(endtime*Ytot(end,5))

%% Fedbatch PI control
%100L reactor
clc, clear, clf
global F_in
global K_La
K_La = 500;
V=20;
Y0=[0 22.2 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 yCO2 
time=[0 1]
Vfin = 75; %L 
F_in = 0.2; %L/h
Esp = 1;
IntErr = 0;
Kp = 0.0008;
Ki = 0.0001;
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
    Intra=[Ytot(:,6),Ytot(:,7),Ytot(:,8)];
    oxygen=[Ytot(:,4)];
    offgas=[Ytot(:,9),Ytot(:,10)];
    subplot(1,2,1)
    plot(Ttot,Volume)
    title('Reactor volume and flow','FontSize', 16)
    legend('Flow','Volume','FontSize', 14)
    xlabel('Time [h]','FontSize', 14)
    ylabel('Volume [L]','FontSize', 14)
    set(gca,'fontname','times')
    grid on
    subplot(1,2,2)
    yyaxis left
    set(gca, 'yColor','r')
    plot(Ttot,Ytot(:,1),'b-',Ttot,Ytot(:,2),'r-',Ttot,Ytot(:,3),'g-')
    legend('S_e_c','X','E','FontSize', 14)
    xlabel('Time [h]','FontSize', 14)
    ylabel('Concentration [g L^-^1]','Color','r','FontSize', 14)
    yyaxis right 
    set(gca, 'yColor','k')
    ylabel('Concentration [mM]','FontSize', 14)
    title('Extracellular metabolites','FontSize', 16)
    set(gca,'fontname','times')
    grid on
%     subplot(1,3,3)
%     plot(Ttot,Intra)
%     title('Intracellular metabolites')
%     legend('G','ATP','Pyr')
%     xlabel('Time [h]')
%     ylabel('Concentration [mM]')
%     grid on
%     subplot(1,3,3)
%     plot(Ttot,oxygen)
%     legend('cO_2L')
%     title('Oxygen in liquid phase')
%     xlabel('Time [h]')
%     ylabel('Concentration [M]')
%     grid on
%     subplot(1,5,5)
%     plot(Ttot,offgas)
%     title('Off gas composition')
%     legend('yO2','yCO2')
%     xlabel('Time [h]')
%     ylabel('mole fraction')
%     grid on
end
endtime=Ttot(end)

biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5) %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-Ytot(1,5))*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed
Titer=biomass_produced/Ytot(end,5)
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
    yyaxis left
    set(gca, 'yColor','r')
    plot(Ttot,Ytot(:,1),'b-',Ttot,Ytot(:,2),'r-',Ttot,Ytot(:,3),'g-')
    legend('S_e_c','X','E')
    xlabel('Time [h]')
    ylabel('Concentration [g L^-^1]','Color','r')
    yyaxis right 
    set(gca, 'yColor','b')
    ylabel('Concentration mM')
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
global K_La
global Vg

K_La = 1000;
V=2;
Vg = 10-V;
Y0=[0 0.375 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 yCO2 
time=[0 1]
Vfin = 7.5; %L 
F_in = 0.01; %L/h
Esp = 1;
IntErr = 0;
Kp = 0.006;
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
    yyaxis left
    set(gca, 'yColor','r')
    plot(Ttot,Ytot(:,1),'b-',Ttot,Ytot(:,2),'r-',Ttot,Ytot(:,3),'g-')
    legend('S_e_c','X','E')
    xlabel('Time [h]')
    ylabel('Concentration [g L^-^1]','Color','r')
    yyaxis right 
    set(gca, 'yColor','b')
    ylabel('Concentration mM')
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
biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5) %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-Ytot(1,5))*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed

% for i=1:10
%     subplot(2,5,i)
%     plot(Ttot,Ytot(:,i))
%         if i==1
%         title('[S_e_c]')
%         xlabel('Time (h)')
%         ylabel('Concentration')
%     end
%     if i==2
%         title('[X]')
%         xlabel('Time (h)')
%         ylabel('Concentration')
%     end
%     if i==3
%         title('[E]')
%     end
%     if i==4
%         title('[cO2_L]')
%     end
%     if i==5
%         title('[V]')
%     end
%     if i==6
%         title('[G]')
%     end
%     if i==7
%         title('[ATP]')
%     end
%     if i==8
%         title('[Pyr]')
%     end
%     if i==9
%         title('[yO2]')
%     end
%     if i==10
%         title('[yCO2]')
%     end
% 
% end
% biomass=Y(end,2)
% endtime=Ttot(end)

% biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5); %g
% substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-Ytot(1,5))*1000 - Ytot(end,1)*Vfin)/1000*180;
% Yield=biomass_produced/substrate_consumed

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
Y0=[0 15.86 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 yCO2 
time=[0 1]
Vfin = 750; %L
F_in = 8; %L/h
Esp = 1;
IntErr = 0;
Kp = 0.0007;
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
    Intra=[Ytot(:,6),Ytot(:,7),Ytot(:,8)];
    subplot(1,3,1)
    plot(Ttot,Volume)
    title('Reactor volume and flow')
    legend('Flow','Volume')
    xlabel('Time [h]')
    ylabel('Volume [L]')
    grid on
    subplot(1,3,2)
    yyaxis left
    set(gca, 'yColor','r')
    plot(Ttot,Ytot(:,1),'b-',Ttot,Ytot(:,2),'r-',Ttot,Ytot(:,3),'g-')
    legend('S_e_c','X','E')
    xlabel('Time [h]')
    ylabel('Concentration [g L^-^1]','Color','r')
    yyaxis right 
    set(gca, 'yColor','b')
    ylabel('Concentration mM')
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

%% 10 000L reactor

clc, clear, clf
global F_in
global Vg
global K_La
V=2000;
Vg=10000-V;
Y0=[0 19 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 yCO2 
time=[0 1]
Vfin = 7500; %L
F_in = 20; %L/h
Esp = 3;
IntErr = 0;
Kp = 0.0002;
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
K_La = 300+(7500-V)/30; %sätter den efter att vi definierat V så att det funkar
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
    subplot(1,5,5)
    plot(Ttot,Ytot(:,4))
    legend('cO2_L')
end
biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5) %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-Ytot(1,5))*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed
Productivity=biomass_produced/(endtime*Y(end,5))

%% 100 000 L reactor

clc, clear, clf
global F_in
global Vg
global K_La
V=20000;
Vg=100000-V;
Y0=[0 11.8 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 yCO2 
time=[0 1];
Vfin = 75000; %L
F_in = 200; %L/h
Esp = 1;
IntErr = 0;
Kp = 0.0003;
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
K_La = 200+(75000-V)/300;
F_in=F_in+(Kp*V*Error)+(Ki*IntErr);
if F_in<0
    F_in=0
end
%if Y(end,2)>50
 %   F_in=F_in+(Kp*V*Error)+(Ki*IntErr)+0.02;
%end
%update time
time=time+1;
Y0=Y(end,:);


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
    subplot(1,5,1)
    plot(Ttot,Volume)
    title('Reactor volume and flow')
    legend('Flow','Volume')
    xlabel('Time [h]')
    ylabel('Volume [L]')
    grid on
    subplot(1,5,2)
    plot(Ttot,Ytot(:,1),Ttot,Ytot(:,2),Ttot,Ytot(:,3))
    legend('S_e_c','X','E')
    xlabel('Time [h]')
    ylabel('Concentration [g L^-^1]')
    title('Extracellular metabolites')
    grid on
    subplot(1,5,3)
    plot(Ttot,Intra)
    title('Intracellular metabolites')
    legend('G','ATP','Pyr')
    xlabel('Time [h]')
    ylabel('Concentration [mM]')
    grid on
    subplot(1,5,4)
    plot(Ttot,Offgas)
    legend('O2','CO2')
    grid on
    subplot(1,5,5)
    plot(Ttot,Ytot(:,4))
    legend('cO2_L')
    grid on
end
clf

for d=1
    subplot(1,2,1)
    yyaxis left
    set(gca, 'yColor','r')
    plot(Ttot,Ytot(:,1),'b-',Ttot,Ytot(:,2),'r-',Ttot,Ytot(:,3),'g-')
    legend('S_e_c','X','E','FontSize', 14)
    xlabel('Time [h]','FontSize', 14)
    ylabel('Concentration [g L^-^1]','Color','r','FontSize', 14)
    yyaxis right 
    set(gca, 'yColor','b')
    ylabel('Concentration mM','FontSize', 14)
    title('Extracellular metabolites','FontSize', 16)
    grid on
    set(gca, 'fontname','times')
    subplot(1,2,2)
    plot(Ttot,Ytot(:,4))
    title('Oxygen in liquid phase','FontSize', 16)
    legend('cO2_L','FontSize', 14)
    xlabel('Time [h]','FontSize', 14)
    ylabel('Concentration [mM]','FontSize', 14)
    grid on
    set(gca, 'fontname','times')
end

biomass_produced = Y(end,2)*Y(end,5)-Ytot(1,2)*Ytot(1,5) %g
substrate_consumed = (Ytot(1,1)*Ytot(1,5)+(Ytot(end,5)-Ytot(1,5))*1000 - Ytot(end,1)*Vfin)/1000*180;
Yield=biomass_produced/substrate_consumed
Productivity=biomass_produced/(endtime*Y(end,5))