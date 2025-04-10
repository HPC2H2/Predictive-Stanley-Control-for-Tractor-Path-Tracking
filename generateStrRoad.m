%% generateStrRoad.m 
%% 用于生成仿真用的参考路径x、y、theta坐标表
%% 作者：HPC2H2
%% 日期：20240506

clc
clear
close all
%% 定义直线路径参数
% 直线长度恒为 40
length_straight_line = 40;
slope_straight_line = 0;
start_point = [0, 0]; 

%% 计算路径终点
% 直线斜率非0用如下代码
% end_points = start_point + ...
%     [length_straight_line * cos(atan(slope_straight_line)) ...
%     length_straight_line * sin(atan(slope_straight_line))];

end_points = start_point + ...
    [length_straight_line * cos(atan(slope_straight_line)) ...
    length_straight_line * sin(atan(slope_straight_line))];
%% 构建采样点数量
% 车速度计1m/s
num_points = 900; % 采样点数量

%% 生成路径点
% 直线斜率非0用如下代码
% path = [linspace(start_point(1), end_points(1), num_points)', ...
%    linspace(start_point(2), end_points(2), num_points)'];

path = [linspace(start_point(1), end_points(1), num_points)', ...
   zeros(num_points, 1)];
% 导入到单片机上的
ref_poses = [path, atan(slope_straight_line)*ones(num_points,1)];

%% 将路径信息写入文本文件
filename = 'str.txt';
fid = fopen(fullfile(pwd, filename), 'w'); 

for i = 1:num_points
    fprintf(fid, '%f %f %f\n', ref_poses(i, 1), ref_poses(i, 2), ...
        ref_poses(i,3));
end
fclose(fid); 