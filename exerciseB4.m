%% B4
clear, clc, clf

% V_tot = V_l + V_g = 10L
%V_l,initial = 0.5L
%F_l = 0.2L/h
%F_g,in = 0.06 m3/h
%S_0 = 25 g/L
%S_initial = 5 g/L

%y_O2,in/initial = 0.2095
%y_CO2,in/inital = 0.0004

%X_initial = 0.5 g/L
%S_initial = 5 g/L
%c_O2,initial = 265 μM
O2_initial=0.2095*1/790;

Y0 = [5 0.5 0.5 2.6519e-04 0.2095 0.0004 9.5];
[t,Y] = ode15s(@Ex_B4, [0 36], Y0);

figure('name','All concentrations')
plot(t,Y)
legend('[S]','[X]','[V]', '[O2]', '[O2gas]','[CO2gas]','[Vg]')
xlabel('Time (h)')
ylabel('KOncentration (g/L)')

figure('name','A')
for i=1:7
    subplot(3,3,i)
    plot(t,Y(:,i))
        if i==1
        title('[S]')
        xlabel('Time (h)')
        ylabel('Koncentration (g/L)')
    end
    if i==2
        title('[X]')
        xlabel('Time (h)')
        ylabel('Koncentration (g/L)')
    end
    if i==3
        title('[V]')
        xlabel('Time (h)')
        ylabel(' Liquid volume (L)')
    end
    if i==4
        title('[O2]')
        xlabel('Time (h)')
        ylabel('Concentration (M)')
    end
    if i==5
        title('[O2gas]')
        xlabel('Time (h)')
        ylabel('Mole fraction (%)')
    end
    if i==6
        title('[CO2gas]')
        xlabel('Time (h)')
        ylabel('Mole fraction (%)')
    end
    if i==7
        title('[Vgas]')
        xlabel('Time (h)')
        ylabel('Gas volume (L)')
    end
end

%% B4 B)
Y0 = [5 0.5 0.5 2.6519e-04 0.2095 0.0004 9.5];
[t,Y] = ode15s(@Ex_B4_B, [0 36], Y0);

figure('name','B')
for i=1:7
    subplot(3,3,i)
    plot(t,Y(:,i))
        if i==1
        title('[S]')
        xlabel('Time (h)')
        ylabel('Koncentration (g/L)')
    end
    if i==2
        title('[X]')
        xlabel('Time (h)')
        ylabel('Koncentration (g/L)')
    end
    if i==3
        title('[V]')
        xlabel('Time (h)')
        ylabel(' Liquid volume (L)')
    end
    if i==4
        title('[O2]')
        xlabel('Time (h)')
        ylabel('Concentration (M)')
    end
    if i==5
        title('[O2gas]')
        xlabel('Time (h)')
        ylabel('Mole fraction (%)')
    end
    if i==6
        title('[CO2gas]')
        xlabel('Time (h)')
        ylabel('Mole fraction (%)')
    end
    if i==7
        title('[Vgas]')
        xlabel('Time (h)')
        ylabel('Gas volume (L)')
    end
end

%% B4 C)
Y0 = [5 5 0.5 2.6519e-04 0.2095 0.0004 9.5];
[t,Y] = ode15s(@Ex_B4_C, [0 36], Y0);

figure('name','C')
for i=1:7
    subplot(3,3,i)
    plot(t,Y(:,i))
                if i==1
        title('[S]')
        xlabel('Time (h)')
        ylabel('Koncentration (g/L)')
    end
    if i==2
        title('[X]')
        xlabel('Time (h)')
        ylabel('Koncentration (g/L)')
    end
    if i==3
        title('[V]')
        xlabel('Time (h)')
        ylabel(' Liquid volume (L)')
    end
    if i==4
        title('[O2]')
        xlabel('Time (h)')
        ylabel('Concentration (M)')
    end
    if i==5
        title('[O2gas]')
        xlabel('Time (h)')
        ylabel('Mole fraction (%)')
    end
    if i==6
        title('[CO2gas]')
        xlabel('Time (h)')
        ylabel('Mole fraction (%)')
    end
    if i==7
        title('[Vgas]')
        xlabel('Time (h)')
        ylabel('Gas volume (L)')
    end
end

%% B4 D)
Y0 = [5 0.5 0.5 2.6519e-04 0.2095 0.0004 9.5];
[t,Y] = ode15s(@Ex_B4_D, [0 36], Y0);

figure('name', 'D')
for i=1:6
    subplot(3,2,i)
    plot(t,Y(:,i))
            if i==1
        title('[S]')
        xlabel('Time (h)')
        ylabel('Koncentration (g/L)')
    end
    if i==2
        title('[X]')
        xlabel('Time (h)')
        ylabel('Koncentration (g/L)')
    end
    if i==3
        title('[V]')
        xlabel('Time (h)')
        ylabel(' Liquid volume (L)')
    end
    if i==4
        title('[O2]')
        xlabel('Time (h)')
        ylabel('Concentration (M)')
    end
    if i==5
        title('[O2gas]')
        xlabel('Time (h)')
        ylabel('Mole fraction (%)')
    end
    if i==6
        title('[CO2gas]')
        xlabel('Time (h)')
        ylabel('Mole fraction (%)')
    end
    if i==7
        title('[Vgas]')
        xlabel('Time (h)')
        ylabel('Gas volume (L)')
    end
end

