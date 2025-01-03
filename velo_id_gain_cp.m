%% velo_id_gain.m

%% initialize
clear all
close all

%% parameters
ts = 1/50;
u_ini = 1.5; 
r_const = 0.7; % offset voltage
p_const = 0.5; % step input voltage
s_time = 10; % step time
w_time = 4; % wait time

%% define input voltage list
u_ref_list = 0.5:0.25:2;

%% open simulink model
open_system('velo_id_gain.slx');
open_system('velo_id_gain.slx/Output');

%% start experiment
sim('velo_id_tc_sl');

%% parameter identification
y = yout.signals.values;


y_mean_list = [];