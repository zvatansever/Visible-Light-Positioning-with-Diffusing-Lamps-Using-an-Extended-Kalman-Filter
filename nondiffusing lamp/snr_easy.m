clc;clear all;close all;

load decimeter_los_nlos_map
snr_levels=[2.50E-15
7.50E-16
2.50E-16
7.50E-17
2.50E-17
7.50E-18
2.50E-18
7.50E-19];
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
