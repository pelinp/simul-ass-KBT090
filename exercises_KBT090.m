%% B2
%t1=15 t2=24 t3=24 t4=38 t5=48
%ddtc1_o2=((5.0*10^-2)-(1.6*10^-1))/(24-0);
r0_o2=0.9*(0.23-1.6*10^-1);
r1_o2=0.9*(0.23-6.0*10^-2);
r2_o2=0.9*(0.23-5.0*10^-2);
r3_o2=0.9*(0.23-3.2*10^-2);
r4_o2=0.9*(0.23-3.0*10^-2);

q0_o2=(r0_o2)/(2.0*10^8); %vi tar cellantalet per L inte mL
q1_o2=(r1_o2)/(4.5*10^8); 
q2_o2=(r2_o2)/(6.0*10^8);
q3_o2=(r1_o2)/(7.7*10^8);
q4_o2=(r1_o2)/(3.0*10^8);

time = [0;15;24;38;48];
r_o2 = [r0_o2;r1_o2;r2_o2;r3_o2;r4_o2];
q_o2 = [q0_o2;q1_o2;q2_o2;q3_o2;q4_o2];
answerB2 = table(time,r_o2,q_o2)

%Subtstratet kanske börjar ta slut. Viskositeten blir större när man har
%mer celler--> kan påverka q. Cellerna kanske börjar dö...

%% B3
