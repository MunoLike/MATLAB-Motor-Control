%% sim_init.m

%% Initialize & load data
clear all; close all;

%% Common parameters
ts = 1/50; % Sampling time
s = tf('s'); % Laplace variable

%% PID Gain
Kp = 0.0; % Proportional gain
Ki = 0.0; % Integral gain
Kd = 0.0; % Derivative gain

%% Reference parameters
r = 40;
r_cyc = 4;
dist = 0;
Ncyc = 2;
tfinal = r_cyc * Ncyc;

%% save data
save sim_param

%% EOF of sim_init.m