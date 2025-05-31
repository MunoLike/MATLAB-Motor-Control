%% pos_id_step.m

%% Initialize
close all;clear all;clc;
load sim_param

%% Parameters for identification
r = 40;
r_cyc = 2;
Kp_id = 0.079;
Ncyc = 5
tfinal = r_cyc * Ncyc;

%% ID Experiment
model_name = "pos_id_step_sl";
open_system(model_name);
open_system(model_name+"/Out1");
set_param(model_name, 'SimulationMode', 'normal');
set_param(model_name,'ConnectedIO','on');
sim(model_name);

%% Data processing
y = yout.signals.values(:, 2);
t = yout.time;

NN = length(y);
N = r_cyc/ts;
yy = reshape(y(2:NN),N,(NN-1)/N); % y(2:NN)をN行×(繰り返し回数)列に分割
yf = yy(1:N/2,2:end); % 

% 平均化と正規化処理
ym = mean(yf')';
y0 = ym(1); yN = ym(end);
ym = (ym-y0)/(yN-y0); % 初期値を0に、最終値を1に正規化

%% Plot figures
t = (0:N/2-1)*ts;
figure(1);
subplot(2,1,1), grid;
plot(t, yf);
xlabel('Time [s]'),ylabel('Output [deg]');
subplot(2,1,2);
plot(t, ym), grid;
xlabel('Time [s]'),ylabel('Normalized output [deg]');

%% EOF of pos_id_step.m