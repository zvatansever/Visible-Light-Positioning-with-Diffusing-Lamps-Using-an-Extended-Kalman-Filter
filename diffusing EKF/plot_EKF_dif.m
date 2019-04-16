load('diffusing_lamp_decimeters_ekf_los.mat')
load('diffusing_lamp_decimeters_ekf_los_nlos.mat')

figure
set(gca,'fontsize',18)
hold on
SNR=[25 30 35 40 45 50 55 60];

plot(SNR,dif_Mean_ekf_ROUND_los,'-*',...
     SNR,dif_Mean_ekf_ROUND_los_nlos,'-h',...
    'linewidth',2,'Markersize',10)
   
    xlabel('SNR (dB)')
    ylabel('RMSE (dm)')
    legend('Diffusing, EKF, LOS','Diffusing, EKF, LOS and 1^{st} bounce. ')