concentration=[0,2,1,0.5,0.2,0.1,0.05,0.02,0.01,0.005,0.002,0.001];
T2=[19,16,23,21,26,31,29,23,25,19,23,24];
T2_lower=[18,15,22,20,25,30,28,22,24,18,22,22];
T2_upper=[20,16,23,21,27,32,29,24,26,20,25,25];

T1=[1467,90,151,281,537,819,1208,1624,1773,1918,2058,1908];
T1_lower=[1431,85,146,271,523,802,1156,1590,1737,1828,1955,1830];
T1_upper=[1503,94,156,290,550,835,1260,1658,1809,2007,2162,1986];

figure(1)
errorbar((concentration),T1,T1-T1_lower,T1_upper-T1,'r*')
ylabel('T1 (ms)','Fontsize',16)
xlabel('concentration','Fontsize',16)

figure(2)
errorbar((concentration),T2,T2-T2_lower,T2_upper-T2,'r*')
ylabel('T2 (ms)','Fontsize',16)
xlabel('concentration','Fontsize',16)

figure(3)
errorbar((concentration),1./T1,(T1-T1_lower)./((T1).^2),(T1_upper-T1)./((T1).^2),'r*')
ylabel('R1 (ms^{-1})','Fontsize',16)
xlabel('concentration','Fontsize',16)

figure(4)
errorbar((concentration),1./T2,(T2-T2_lower)./((T2).^2),(T2_upper-T2)./((T2).^2),'r*')
ylabel('R2 (ms^{-1})','Fontsize',16)
xlabel('concentration','Fontsize',16)