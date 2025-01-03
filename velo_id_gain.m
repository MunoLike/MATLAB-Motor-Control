%% velo_id_gain.m

%% initialize
clear all
close all

%% parameters
ts = 1/50;
u_ini = 1.5; 

%% define input voltage list
u_ref_list = 0.5:0.25:2;

%% open simulink model
open_system('velo_id_gain_sl');
open_system('velo_id_gain_sl/Output');

%% parameter identification
y_mean_list = [];
for i = 1:length(u_ref_list)
    u_ref = u_ref_list(i);
    set_param('velo_id_gain_sl', 'SimulationCommand', 'start')
    %% wait
    t = yout.time;
    y = yout.signals.values(1, 1, :);
    y_mean = mean(y(250:end));
    fprintf('y_mean = %f\n', y_mean);
    y_mean_list(i) = y_mean;
    % plot figure
    figure(1)
    plot(t, y, t, ones(size(y))*y_mean,'r');
    xlabel('Time [s]'), ylabel('Velocity [V]')
    axis([0 10 0 3])
    drawnow
end

%% plot data
figure(2)
plot(u_ref_list, y_mean_list, 'bo')
xlabel('Input voltage [V]')
ylabel('Velocity [V]')
axis([0 3 0 3])

%% calculate parameters
while(1)
    disp('please input Umin and Umax for fit')
    umin = input('Umin = ');
    umax = input('Umax = ');
    sidx = min(find(u_ref_list >= umin));
    eidx = min(find(u_ref_list <= umin));
    P = polyfit(u_ref_list(sidx:eidx), y_mean_list(sidx:eidx), 1);
    Pin = 0:3;
    Pout = P(1) * Pin + P(2);
    u_offset = -P(2) / P(1);
    fprintf('***Motor parameters***\n')
    fprintf('K        = %f\n', P(1))
    fprintf('u_offset = %f\n', u_offset)

    figure(2)
    plot(u_ref_list, y_mean_list, 'o', ...
        u_ref_list(sidx:eidx), y_mean_list(sidx:eidx), 'ro', ...
        Pin, Pout, 'r-')
    Xlabel('Input voltage [V]')
    ylabel('Velocity [V]')
    axis([0 3 0 3])

    sw = input('OK? (1:Quit, 2:Retry) = ');
    switch sw
        case 1;
            break;
        case 2;
            continue;
    end
end

%% EOF of velo_id_gain.m