%% velo_id_verify.m

%% set identified parameters
K = 0.625269;
T = 0.26;
u_offset = 1.15936;

%% open simulink model
open_system('velo_id_verify_sl');
open_system('velo_id_verify_sl/Out1');

%% start experiment
set_param('velo_id_verify_sl', 'SimulationMode', 'normal')
set_param('velo_id_verify_sl','ConnectedIO','on')
fprintf('start running... \n');
sim('velo_id_verify_sl');

%% save parameters
save model_data K T u_offset


%% EOF