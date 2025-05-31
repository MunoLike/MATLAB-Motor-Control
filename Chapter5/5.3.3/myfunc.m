function J = myfunc(x, y, t, ts, Kp_id)
% myfunc - Objective function for parameter identification
% Inputs:
%   x - [K, T]'
%   y - step response data obtained by experiment
%   t - time vector
%   ts - sampling time
%   Kp_id - feedback gain for identification
% Output:
%   J - cost function value

K = x(1);  % Gain
T = x(2);  % Time constant
P = tf([0, 0, K], [T, 1, 0]);
Pd = c2d(P, ts, 'zoh');  % Discretize the transfer function
Ld = Pd*Kp_id;  % Apply feedback gain
Gd = feedback(Ld, 1);  % Closed-loop system
ysim = step(Gd, t);
J = norm(y-ysim, 2);  % Calculate the error norm
end