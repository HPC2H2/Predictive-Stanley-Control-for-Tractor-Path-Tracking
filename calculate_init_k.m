%% calculate_init_k.m
%% 计算初始直线跟踪参数
%% 作者：HPC2H2
%% 日期：20240501

e_y = 0.1;
ts = 0.1;
% v = 1.98/3.6;
% v = 3/3.6;
% v= 4.71/3.6;
v = 1;

k_y = 1;
k_v = 1;
c = 1;
L = 1.9;
delta = atan2(k_y*e_y,k_v*v + c) - 1/180*pi;

if delta > pi/9
    delta = pi/9;
end

delta*180/pi
dx = v*cos(delta)*ts;
dy = v*sin(delta)*ts;
dyaw = tan(delta)/L *ts;
sqrt(dx^2 + dy^2)
e_y = e_y - sqrt(dx^2 + dy^2)


for i = 1:3
    dx = dx + v*cos(dyaw + delta)*ts;
    dy = dy + v*sin(dyaw + delta)*ts;
    dyaw = dyaw + tan(delta)/L*ts;
    sqrt(dx^2 + dy^2)
    e_y = e_y - sqrt(dx^2 + dy^2)
    e_h = (0- dyaw);
    delta = atan2(k_y*e_y,k_v*v + c) + e_h;
    if delta > pi/9
    delta = pi/9;
    end
    if delta < -pi/9
    delta = -pi/9;
    end
    delta_a = delta*180/pi;
    e_h_a = e_h*180/pi;
end
    

% x_predict(i) = x_predict(i-1) + ...
%                vd1*cos(yaw_predict(i-1) + delta_predict(i-1))*Ts;
%          y_predict(i) = y_predict(i-1) + ...
%                vd1*sin(yaw_predict(i-1) + delta_predict(i-1))*Ts;
%            yaw_predict(i) = yaw_predict(i-1) +...
%                vd1*tan(delta_predict(i-1))/L*Ts;