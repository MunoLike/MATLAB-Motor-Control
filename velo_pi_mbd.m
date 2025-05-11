%% velo_pi_mbd.m

%% Initialize & load data
close all; clear all;
load model_data

%% PI design by pole placement
p1 = input('Enter desired pole 1: ');
p2 = p1;
% p2 = input('Enter desired pole 2: ');

Kp = - (T*(p1+p2)+1)/K;
Ki = p1*p2*T/K;

%% Display PI parameters
disp('>>> PI controller parameters <<<');
fprintf('Kp = %.4f\n', Kp);
fprintf('Ki = %.4f\n', Ki);

%% Open simulink model
open_system('velo_pi_mbd_sl');
open_system('velo_pi_mbd_sl/Out1');
set_param('velo_pi_mbd_sl', 'SimulationMode', 'normal')
set_param('velo_pi_mbd_sl','ConnectedIO','on')
fprintf('start running... \n');

%% Experiment
ts = 1/50;
sim('velo_pi_mbd_sl');
