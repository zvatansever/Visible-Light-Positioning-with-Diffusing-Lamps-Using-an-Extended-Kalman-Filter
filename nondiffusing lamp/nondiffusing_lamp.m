%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% This program is to simulate the indoor VLC channel
%
% written by Jie Lian & modified by Zafer Vatansever
% University of Virginia
% USA
% 12/2/2012
%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc;
clear;
close all;
%% basic conditions setting

tic
x=50;% the size of the room
y=50;
z=30;

c=3*10^8;
FOV_LED=pi/2;
semi=60;
P_LED=0.0025;

P_power=ones(100,1)*P_LED;

%% The position of the LED source
% LED_x=[x/2,x-x/4,x-x/4,x/4];
% LED_y=[y/2,y-y/4,y/4,y-y/4];
% LED_z=[z,z,z,z];
% LED_pos=[x/2,x-x/4,x-x/4,x/4;y/2,y-y/4,y/4,y-y/4;z,z,z,z];

LED_x=[x/4,x-x/4,x-x/4,x/4];
LED_y=[y/4,y-y/4,y/4,y-y/4];
LED_z=[z,z,z,z];
LED_pos=[x/4,x-x/4,x-x/4,x/4;y/4,y-y/4,y/4,y-y/4;z,z,z,z];

norm_rec=[0;0;1];
norm_wall_1=[0,1,0];
norm_wall_2=[0,-1,0];
norm_wall_3=[1,0,0];
norm_wall_4=[-1,0,0];


LED_number=length(LED_x(1)); %calculate only first LED


% spherical coordinates
r=1;

% theta=linspace(pi/2,pi,N)
angle_phi=10/180*pi;

theta_3=[pi-angle_phi*2];
theta_2=[pi-angle_phi];
theta_1=[pi];

N=17; % 
phi_3=linspace(0,2*pi,N);

N=9; % 
phi_2=linspace(0+pi/4,2*pi+pi/4,N);

N=2;
phi_1=linspace(0,2*pi,N);

f=1;

for j=1:length(phi_3)-1
    vector_beam(:,f)=[r*sin(theta_3)*cos(phi_3(j));r*sin(theta_3)*sin(phi_3(j));r*cos(theta_3)];
    f=f+1;
end

for j=1:length(phi_2)-1
    vector_beam(:,f)=[r*sin(theta_2)*cos(phi_2(j));r*sin(theta_2)*sin(phi_2(j));r*cos(theta_2)];
    f=f+1;
end

for j=1:length(phi_1)-1
    vector_beam(:,f)=[r*sin(theta_1)*cos(phi_1(j));r*sin(theta_1)*sin(phi_1(j));r*cos(theta_1)];
    f=f+1;
end

[a N_led]=size(vector_beam);
%%
P_floor=zeros(x,y); %% received power in the room
P_wall_1=zeros(x,z);
P_wall_2=zeros(x,z);
P_wall_3=zeros(y,z);
P_wall_4=zeros(y,z);
P_F_1=0;
P_F_2=0;
P_F_3=0;
P_F_4=0;

P_floor_diffu=zeros(x,y);

%% incidence & irradiance angles matrix of floor and four walls
Incid_angle_floor=zeros(x,y);
Irrad_angle_floor=zeros(x,y);

Incid_angle_wall_1=zeros(x,z);
Irrad_angle_wall_1=zeros(x,z);

Incid_angle_wall_2=zeros(x,z);
Irrad_angle_wall_2=zeros(x,z);

Incid_angle_wall_3=zeros(y,z);
Irrad_angle_wall_3=zeros(y,z);

Incid_angle_wall_4=zeros(y,z);
Irrad_angle_wall_4=zeros(y,z);

%% calculate the floor incidence angles & irradiance angles
f=0;

for k=1:LED_number
    for m=1:N_led
    f=f+1;
    for i=1:x
        for j=1:y
            
               vector_ray=[i;j;0]-LED_pos(:,k);
                Incid_angle_floor(i,j)=angle(-vector_ray,norm_rec);
                Irrad_angle_floor(i,j)=angle(vector_ray,vector_beam(:,m));

                % distance between transmitter and receiver
                d_t_r=sqrt((i-LED_x(k))^2+(j-LED_y(k))^2+z^2);
                d_z=z;
          
                  
                if abs(Incid_angle_floor(i,j)-pi/3)<=FOV_LED
                    P(i,j)=P_power(f)*0.01*RO(Irrad_angle_floor(i,j),d_t_r/10,semi)*cos(Incid_angle_floor(i,j));
                else
                    P(i,j)=0;
                end

                P_floor(i,j)=P_floor(i,j)+P(i,j);
            end
        end
    end
end

Incid_angle_floor=zeros(x,y);
Irrad_angle_floor=zeros(x,y);
P=zeros(x,z);

f=0;

P_floor1=abs(P_floor);
P_floor2=abs(rot90(P_floor1));
P_floor3=abs(rot90(P_floor2));
P_floor4=abs(rot90(P_floor3));

figure
surf(P_floor1)
hold on
surf(P_floor2)
surf(P_floor3)
surf(P_floor4)





