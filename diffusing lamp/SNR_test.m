clc;clear all;close all;

load diffusing_decimeter_los_nlos_map
snr_levels=[1.50E-12
4.50E-13
1.50E-13
4.50E-14
1.50E-14
4.50E-15
1.50E-15
4.50E-16];
New=P_floor1;
noise=sqrt(snr_levels(2));
snr=10*log10((New.^2)./noise^2);
% snr(snr==-inf) = 0;
[m n]=size(New);
x=1:m;y=1:n;
[xx yy]=meshgrid(x,y);
figure
surfc(real(snr))
h=colorbar
ylabel('Width of the room (cm)')
xlabel('Length of the room (cm)')
zlabel('SNR in dB')
max(real(snr(:)))
figure
surfc(P_floor1)
colorbar
