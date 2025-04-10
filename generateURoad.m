%% generateURoad.m 
%% 用于生成仿真用的的U型路径x、y、theta坐标表
%% 作者：HPC2H2
%% 日期：20240506

clc
clear
close all
%% 定义U型路径的区线路段参数
% 设定拖拉机最大转向角为20°，最小转弯半径计算
% L = 1.9;% 车辆轴距
% max_delta_rad = 20*pi/180;
% min_radius = L/2/sin(max_delta_rad);  % 圆半径
% radius = ceil(min_radius) + 1;

radius = 9; % 半径9m, 农工楼花坛U路半径十米左右
start_angle = 0;  % 起始角度（弧度）
end_angle = pi;  % 结束角度（弧度）
A = 1; % 纵向放缩参数
B = 1; % 横向放缩参数

%% 构建采样点数量 
% 点间距2.5cm左右，最多900点
num_points = 800; % 采样点数量
% 构建角度向量
theta = linspace(start_angle, end_angle, num_points);

% 计算路径笛卡尔坐标
str_length = 2;
x = (radius * B * sin(theta) + str_length)';
y = (radius * A * cos(theta) + radius)';

path = [x, y];

% 按y从小到大排序
sorted_path = sortrows(path, 2);
ref_x = sorted_path(:,1);
ref_y = sorted_path(:,2);

%% 定义U型路中直线路径参数
num_points = 50; % 采样点数量
str_points_x1 = linspace(0,str_length,num_points)';
str_points_x2 = linspace(str_length,0,num_points)';
str_points_y1 = zeros(num_points,1);
str_points_y2 = ones(num_points,1)*2*radius;

%% 合并曲线路和直线路
ref_x = [str_points_x1; ref_x; str_points_x2];
ref_y = [str_points_y1; ref_y; str_points_y2];

%% 生成路径航向角
% 差分路径
diff_x = diff(ref_x);
diff_x = [diff_x; diff_x(end)];

diff_y = diff(ref_y);
diff_y=[diff_y; diff_y(end)];

% 生成航向角
ref_yaw = atan2(diff_y , diff_x);

%% 生成最终路径
x_y_yaw_path = [ref_x,ref_y,ref_yaw];

%% 将路径信息写入文本文件
filename = 'u.txt';
fid = fopen(fullfile(pwd, filename), 'w'); 

for i = 1:length(ref_x)
    fprintf(fid, '%f %f %f\n',x_y_yaw_path(i,:));
end
fclose(fid); 

%% 可视化
figure('Color','White');
scatter(ref_x,ref_y, 'LineWidth',2);
xlabel('\itx');
ylabel('\ity');
set(gca,"FontName","Times New Roman"); % 设置全局字体为华文中宋

figure(2);
scatter(1:length(ref_x), ref_x, 'LineWidth',2);
figure(3);
scatter(1:length(ref_y), ref_y, 'LineWidth',2);
figure(4);
scatter(1:length(ref_yaw), ref_yaw*180/pi, 'LineWidth',2);