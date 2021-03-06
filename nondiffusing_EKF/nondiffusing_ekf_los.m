clc;clear all;close all;
tic
print_figures=0;
MCruns=50;

load nondiffusing
power=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));
fingerprint_map=cat(3,abs(P_floor1),abs(P_floor2),...
    abs(P_floor3),abs(P_floor4));

load curvy_decimeters X X1 dt
dt=0.01;
qx=0.1;
r=[2.5e-15 7.5e-16 2.5e-16 7.5e-17 2.5e-17 7.5e-18 2.5e-18 7.5e-19];

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


nondif_ekf_los=[mean_rmse1 mean_rmse2 mean_rmse3 mean_rmse4...
                     mean_rmse5 mean_rmse6 mean_rmse7 mean_rmse8];
non_dif_ci_los=[CI1; CI2; CI3; CI4; CI5; CI6; CI7; CI8];

save nondiffusing_lamp_decimeters_ekf_los nondif_ekf_los non_dif_ci_los

figure
set(gca,'fontsize',20)
hold on
SNR=[25 30 35 40 45 50 55 60];

plot(SNR,nondif_ekf_los,'-*',...
    'linewidth',2,'Markersize',10)
 title('Nondiffusing, EKF, LOS')
xlabel('SNR (dB)')
ylabel('RMSE (dm)')
legend('True RMSE')
grid on;
% axis equal
toc