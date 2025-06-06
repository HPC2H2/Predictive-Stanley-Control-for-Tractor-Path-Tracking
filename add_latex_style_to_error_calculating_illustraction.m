%% add_latex_style_to_error_calculating_illustraction.m
%% 用于在visio画的直线跟踪误差解释图上增加公式样式的字母
%% 用于在visio画的曲线跟踪误差解释图上增加公式样式的字母
%% 作者：HPC2H2
%% 日期：20240424

clc
clear
close all
% I = imread('直线跟踪.png');
% imtool(I);
% 
% figure;
% imshow(I, 'InitialMagnification', 'fit');
% x1 = 45; 
% y1 = 765; 
% x2 = 45;
% y2 = 120;
% x3 = 860;
% y3 = 765;
% x4 = 133;
% y4 = 715;
% x5 = 615;
% y5 = 715;
% x6 = 828;
% y6 = 155;
% x7 = 564;
% y7 = 486;
% x8 = 524;
% y8 = 389;
% x9 = 683;
% y9 = 480;
% angle_degree = 0; 
% fontsize = 10; 
% % 
% text(x1, y1, '$O$', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree, ...
%     'Color', 'black'); 
% % 
% text(x2, y2, '$Y$', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree, ...
%     'Color', 'black'); 
% % 
% text(x3, y3, '$X$', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree, ...
%     'Color', 'black'); 
% 
% text(x4, y4, '$\varphi $', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree, ...
%     'Color', 'black'); 
% 
% text(x5, y5, '$\varphi_r $', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree, ...
%     'Color', 'black'); 
% 
% text(x6, y6, '$e_h $', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree, ...
%     'Color', 'red'); 
% 
% text(x7, y7, '$e_y $', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree - 10, ...
%     'Color', 'red'); 
% 
% text(x8, y8, '$(x,y) $', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree, ...
%     'Color', 'black'); 
% 
% text(x9, y9, '$(x_r,y_r) $', ...
%     'Interpreter', 'latex', ...
%     'FontSize', fontsize, ...
%     'Rotation', angle_degree, ...
%     'Color', 'black'); 
% 
% print('-dpng', 'str_error_illustraction.png');

I = imread('曲线跟踪.png');
imtool(I);

figure;
imshow(I, 'InitialMagnification', 'fit');
x1 = 40; 
y1 = 810; 
x2 = 40;
y2 = 100;
x3 = 1010;
y3 = 810;
x4 = 133;
y4 = 760;
x5 = 960;
y5 = 724;
x6 = 635;
y6 = 315;
x7 = 580;
y7 = 390;
x8 = 400;
y8 = 460;
x9 = 670;
y9 = 370;
angle_degree = 0; 
fontsize = 10; 
% % 
text(x1, y1, '$O$', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 

text(x2, y2, '$Y$', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 
% 
text(x3, y3, '$X$', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 

text(x4, y4, '$\varphi $', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 

text(x5, y5, '$\varphi_r $', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 

text(x6, y6, '$e_h $', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'red'); 

text(x7, y7, '$e_y $', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree + 45, ...
    'Color', 'red'); 

text(x8, y8, '$(x,y) $', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 

text(x9, y9, '$(x_r,y_r) $', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 

print('-dpng', 'cur_error_illustraction.png');
