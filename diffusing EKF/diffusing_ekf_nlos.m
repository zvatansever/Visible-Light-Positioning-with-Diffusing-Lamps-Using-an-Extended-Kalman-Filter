clc;clear all;close all;
tic
print_figures=0;
MCruns=100;

load diffusing
power=cat(3,abs(P_floor1+P_floor_diffu_1),abs(P_floor2+P_floor_diffu_2),...
    abs(P_floor3+P_floor_diffu_3),abs(P_floor4+P_floor_diffu_4));
fingerprint_map=cat(3,abs(P_floor1+P_floor_diffu_1),abs(P_floor2+P_floor_diffu_2),...
    abs(P_floor3+P_floor_diffu_3),abs(P_floor4+P_floor_diffu_4));

load curvy_decimeters X X1 dt
dt=0.01;
qx=0.1;
r=[1.50E-12 4.50E-13 1.50E-13 4.50E-14 1.50E-14 4.50E-15 1.50E-15 4.50E-16];

[mean_rmse1,CI1]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(1),MCruns);

[mean_rmse2,CI2]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(2),MCruns);

[mean_rmse3,CI3]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(3),MCruns);

[mean_rmse4,CI4]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(4),MCruns);

[mean_rmse5,CI5]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(5),MCruns);

[mean_rmse6,CI6]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(6),MCruns);

[mean_rmse7,CI7]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(7),MCruns);

[mean_rmse8,CI8]=...
    ekf_ver_2(fingerprint_map,power,X,X1,dt,qx,r(8),MCruns);


dif_mean_ekf_los_nlos=[mean_rmse1 mean_rmse2 mean_rmse3 mean_rmse4...
                     mean_rmse5 mean_rmse6 mean_rmse7 mean_rmse8];

dif_ci_nlos=[CI1; CI2; CI3; CI4; CI5; CI6; CI7; CI8];
                 
save diffusing_lamp_decimeters_ekf_los_nlos dif_mean_ekf_los_nlos dif_ci_nlos

figure
set(gca,'fontsize',14)
hold on
SNR=[25 30 35 40 45 50 55 60];

plot(SNR,dif_mean_ekf_los_nlos,'-*',...
     'linewidth',2,'Markersize',10)
%title('Diffusing, EKF, LOS ')
xlabel('SNR (dB)')
ylabel('RMSE (dm)')
legend('True RMSE')
toc