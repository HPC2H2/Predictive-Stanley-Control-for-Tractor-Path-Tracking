%% illustrate_curve_rate_difference_to_delta.m
%% 绘制曲率变化对Stanley模型转角的影响
%% 作者：HPC2H2
%% 日期：20240427

clc
clear
close all
warning off
p1 = [10, 10];
radius = 10;
p2_horizontal = [p1(1)+radius p1(2)];
p2_test = [15 -sqrt(radius^2 - (15-p1(1))^2) + p1(2)];

f1 = figure(1);
f1.MenuBar = "none"; % 关闭菜单栏
viscircles(p1,radius,'Color','k');
axis equal
hold on
scatter(p2_horizontal(1),p2_horizontal(2),[100],...
    'MarkerFaceColor',"#000000",'MarkerEdgeColor','#000000');
scatter(p2_test(1),p2_test(2),[100],...
    'MarkerFaceColor',"#000000",'MarkerEdgeColor','#000000');
scatter(p1(1),p1(2),[100],...
    'MarkerFaceColor',"#000000",'MarkerEdgeColor','#000000');
figure_size = 40;
xlim([p1(1) - figure_size/2 p1(1) + figure_size/2]); 
ylim([p1(2) - figure_size/2 p1(2) + figure_size/2]); 
% axis off

annotation('textarrow', ([p1(1) + 10.5 p2_horizontal(1) + 7])/figure_size,...
    ([p1(2) + 11 p2_horizontal(2) + 11])/figure_size,'LineWidth',3);

% 向量 -4，9.1603
annotation('textarrow', ([p1(1) + 10.5 p2_test(1) + 9.5 - 4/5])/figure_size,...
    ([p1(2) + 11 p2_test(2) + 10.5 + 9.1603/5])/figure_size,'LineWidth',3);
% exportgraphics(f1,'raw_curve_rate_illustration.eps',...
%     "ContentType","vector",'BackgroundColor','none'); % 无损高清矢量图

exportgraphics(f1, 'raw_curve_rate_illustration.png',...
    "Resolution",600, 'BackgroundColor','none'); % 600DPI PNG格式

I = imread('raw_curve_rate_illustration.png');
imtool(I);

figure(2);
imshow(I, 'InitialMagnification', 'fit');
x1 = 1250; 
y1 = 1009; 
x2 = 1850; 
y2 = 1030; 
x3 = 1575; 
y3 = 1660; 
x4 = 1520; 
y4 = 1230; 
angle_degree = 0; 
fontsize = 15; 

text(x1, y1, '$P_1(L_i)$', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 
text(x2, y2, '$P_2$', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 
text(x3, y3, '$P_2^\prime$', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'black'); 
text(x4, y4, '$\delta^\prime$', ...
    'Interpreter', 'latex', ...
    'FontSize', fontsize, ...
    'Rotation', angle_degree, ...
    'Color', 'red'); 

print('-dpng', 'curve_rate_difference.png');