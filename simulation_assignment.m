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

%legend('[S_ec]','[G]','[ATP]', '[Pyr]', '[cO2_L]','[E]','[X]','[yCO2]','[yO2]')
%xlabel('Time (h)')
%ylabel('Koncentration')

%% 
