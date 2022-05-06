%% Simulation assignment
clc
clear
clf

% batch simulation
Y0=[1000 0.1 1 0.5 2.6519e-01 0 0.1 0.0005 0.2095]; %S_ec G ATP Pyr cO2_L E X yCO2 yO2
[t,Y] = ode15s(@batch_function, [0 70], Y0);

for i=1:9
    subplot(3,3,i)
    plot(t,Y(:,i))
    if i==1
        title('[S_e_c]')
        xlabel('Time (h)')
        ylabel('Concentration')
    end
    if i==2
        title('[G]')
        xlabel('Time (h)')
        ylabel('Concentration')
    end
    if i==3
        title('[ATP]')
    end
    if i==4
        title('[Pyr]')
    end
    if i==5
        title('[c_O_2_L]')
    end
    if i==6
        title('[E]')
    end
    if i==7
        title('[X]')
    end
    if i==8
        title('[yCO2]')
    end
    if i==9
        title('[yO2]')
    end
end
% plotta inte alla intracellulära metaboliter om det inte tillför något
% till resonemanget!!

%legend('[S_ec]','[G]','[ATP]', '[Pyr]', '[cO2_L]','[E]','[X]','[yCO2]','[yO2]')
%xlabel('Time (h)')
%ylabel('Koncentration')

%% Fed-batch
clc, clear, clf
Y0=[1000 0.375 0 2.6519e-01 20 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 
 
[t,Y] = ode15s(@fedbatch_function, [0 100], Y0);
for i=1:10
    subplot(2,5,i)
    plot(t,Y(:,i))
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

%% Fedbatch PI control

clc, clear, %clf
Y0=[0 0.375 0 2.6519e-01 20 0.1 1 0.5 0.2095 0.0005]; %S_ec X E cO2_L V G ATP Pyr yO2 
time=[0,1]
Vfin = 75; %L 
F_in = 0.01; %L/h
Esp = 5;
IntErr = 0;
Kp = 100;
Ki = 0;
V=20;
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
plot(Ttot,Ytot(:,3))
%%
plot(Ttot,Flows)
plot(Ttot,Ytot(:,:))
legend('S_ec','X','E','cO2_L','V','G','ATP','Pyr','yO2')

