%% simulation assignment batch
%% Batch 10L

clc
clear
clf

% batch simulation
V=10;
Y0=[1000 0.1 0 2.6519e-01 V 0.1 1 0.5 0.2095 0.0005]; %S_ex X E cO2_L V G ATP Pyr yO2 yCO2
[t,Y] = ode15s(@batch_10L, [0 70], Y0);

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
% plotta inte alla intracellulära metaboliter om det inte tillför något
% till resonemanget!!

%legend('[S_ec]','[G]','[ATP]', '[Pyr]', '[cO2_L]','[E]','[X]','[yCO2]','[yO2]')
%xlabel('Time (h)')
%ylabel('Koncentration')