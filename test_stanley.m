%% test_stanley.m
%% 对Stanley S-Function进行测试
%% 作者：HPC2H2
%% 日期：20240425

close all
%% 测试1：e_y
% is_path_right 是否正确,且正确作用于 e_y 的赋值
% e_y的输出转角是否正确
is_path_right = zeros(length(xref_whole_process),1);
for i = 1:length(xref_whole_process)
    dx = xref_whole_process(i) - x_whole_process(i);
    dy = yref_whole_process1(i) - y_whole_process(i);
    is_path_right(i) = dx*sin(yaw_whole_process(i)) - ...
        dy*cos(yaw_whole_process(i));
end
% figure(1)
% plot(t_out,is_path_right);

e_ys =  zeros(length(xref_whole_process),1);
for i = 1:length(xref_whole_process)
    e_ys(i) = norm([xref_whole_process(i), yref_whole_process1(i)]- ...
        [x_whole_process(i),y_whole_process(i)]);
end
% figure(3)
% plot(t_out,cross_error_whole_process,t_out,e_ys);
k_y = 1e3;
k_v = 1;
c = 100;
ey_yaws = zeros(length(cross_error_whole_process),1);
for i = 1:length(ey_yaws)
    ey_yaws(i) = atan2(k_y*cross_error_whole_process(i),k_v*vx(i)+c);
end
% figure(4)
% plot(t_out,ey_yaws*180/pi);

% %% 测试2：e_h
% % e_y的输出转角是否正确
% figure(5)
eh_yaws = -yaw_error_whole_process;
% plot(t_out,eh_yaws*180/pi);

%% 测试3： e_y 和 e_h 共同作用
calulated_deltas = eh_yaws + ey_yaws;
limited_deltas = zeros(length(calulated_deltas),1);
for i = 1:length(calulated_deltas)
    if calulated_deltas(i) > pi/9
     limited_deltas(i) = pi/9;
    elseif calulated_deltas(i) < -pi/9
     limited_deltas(i) = -pi/9;
    else
        limited_deltas(i) = calulated_deltas(i);
    end
end
% 
% figure(6)
% plot(t_out,calulated_deltas*180/pi,t_out,limited_deltas*180/pi);

% figure(7)
% plot(t_out,limited_deltas*180/pi,t_out,delta*180/pi)

%% 测试4：偏航率计算
yaws = zeros(length(yawref_whole_process1),1);
yaws(2) = yaw_whole_process(2);
L = 2.91;
Ts = 0.02;
for i = 3:length(yawref_whole_process1)
    yaws(i) = yaws(i-1) + vx(i)*tan(limited_deltas(i-1))/L*Ts;
end
figure(8)
plot(t_out,yaws*180/pi,t_out,yaw_whole_process*180/pi)

figure(9)
plot(t_out,limited_deltas*180/pi,t_out,delta*180/pi)
