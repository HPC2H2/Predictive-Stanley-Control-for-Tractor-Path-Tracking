%% measureControllerPerformance.m
%% 用于运行完Stanley模型和预测Stanley模型后的评估
%% 作者：HPC2H2
%% 日期：20240508

clear
clc
close all
%% 读取数据和改变量名
%% 读取预测Stanley和Stanley模型结束后保存的mat，遍历每个MATLAB并加上标识用前缀
prefix = {'pu', 'su', 'pstr', 'sstr'};
is_found = zeros(1,4);
files = dir('*.mat');
matched_mats_names = {};

for i = 1: length(prefix)
    for j = 1:length(files)
        filename = files(j).name;
        if strcmpi(filename(1:length(prefix{i})), prefix{i})
            matched_mats_names{end+1} = filename(1:end);
        end
    end
end

for ind = 1:length(matched_mats_names)
    cur_file_name = matched_mats_names{ind};
    data = load(cur_file_name);
    for field_name = fieldnames(data)'
        original_var = data.(field_name{1});

        new_var_name = [prefix{ind}, '_', field_name{1}];
        assignin('base', new_var_name, original_var);
    end
end
%% 图片展示和指标运算

% 配色定义
color = [91 206 201;
    140 215 122;
    250 159 66;
    243 83 59]/255;

%%%%%%%%%%%%%%%%%%%%%%% k_y   k_v   c   Np   k0  %%%%%%%%%%%%%%%%%%%%%%%%
% Stanley 直线路径参数    1     2    2   
% Stanley U型路径参数
% PStanley 直线路径参数
% PStanley U型路径参数

% Stanley 和 预测Stanley 直线路径对比
% 横向误差
sstrt = [sstr_tout(1); sstr_tout(6:end)];
sstrcerro = sstr_cross_error_whole_process;
f1 = figure('Color', 'white');
f1.Units = "inches"; % 设置单位为英寸
f1.Position = [100  400 4*1.5 3*1.5];
set(gcf, "Name", "Cross Error", "NumberTitle", "off"); %设置figure的名称
f1.MenuBar = "none"; % 关闭菜单栏
p1 = plot(sstrt, sstrcerro,  "Marker", "diamond", "MarkerIndices", ...
    1:10:length(sstrcerro),'Color',color(1,:),'LineWidth', 1.5); 
p1.LineWidth = 1.5; % 设置线宽
xlabel('跟踪时间（s）'); % 设置X轴标签
ylabel('横向误差（m）'); % 设置Y轴标签
xlim([min(sstrt)*1.1 max(sstrt)]); % 设置X轴显示范围
ylim([min(sstrcerro)*1.1 max(sstrcerro)*1.1]); % 设置Y轴显示范围，根据数据修改
hold on
pstrt = [pstr_tout(1); pstr_tout(6:end)];
pstrcerro = pstr_cross_error_whole_process;
plot(pstrt, pstrcerro, "Marker", "diamond", "MarkerIndices", ...
    1:10:length(pstrcerro),'Color',color(2,:),'LineWidth', 1.5);
sps_legend = {"\fontname{Time New Roman}Stanley",...
    "预测\fontname{Time New Roman}Stanley"};
legend(sps_legend,'Location', 'northeast'); % 设置图例
movegui(f1,"center"); % 移动图片至屏幕中心
set(gca,"FontName","华文中宋"); % 设置全局字体为华文中宋
set(gca,"FontSize",10); % 设置全局字号10
exportgraphics(f1,["str_cross.emf"],"ContentType","vector"); % 无损高清矢量图
sstrcerro_RMS = sqrt(mean(sstr_cross_error_whole_process.^2));
pstrcerro_RMS = sqrt(mean(pstr_cross_error_whole_process.^2));
sstrcerro_max = max(abs(sstr_cross_error_whole_process));
pstrcerro_max = max(abs(pstr_cross_error_whole_process));


% 航向误差
sstrherro = sstr_heading_error_whole_process *180/pi;
f1 = figure('Color', 'white');
f1.Units = "inches"; % 设置单位为英寸
f1.Position = [100  400 4*1.5 3*1.5];
set(gcf, "Name", "Heading Error", "NumberTitle", "off"); %设置figure的名称
f1.MenuBar = "none"; % 关闭菜单栏
p1 = plot(sstrt, sstrherro,  "Marker", "diamond", "MarkerIndices", ...
    1:10:length(sstrherro),'Color',color(1,:),'LineWidth', 1.5); 
p1.LineWidth = 1.5; % 设置线宽
xlabel('跟踪时间（s）'); % 设置X轴标签
ylabel('航向误差（Deg）'); % 设置Y轴标签
xlim([min(sstrt)*1.1 max(sstrt)]); % 设置X轴显示范围
ylim([min(sstrherro)*1.1 max(sstrherro)*1.1]); % 设置Y轴显示范围，根据数据修改
hold on
pstrt = [pstr_tout(1); pstr_tout(6:end)];
pstrherro = pstr_heading_error_whole_process *180/pi;
plot(pstrt, pstrherro, "Marker", "diamond", "MarkerIndices", ...
    1:10:length(pstrherro),'Color',color(2,:),'LineWidth', 1.5);
sps_legend = {"\fontname{Time New Roman}Stanley",...
    "预测\fontname{Time New Roman}Stanley"};
legend(sps_legend,'Location', 'northeast'); % 设置图例
movegui(f1,"center"); % 移动图片至屏幕中心
set(gca,"FontName","华文中宋"); % 设置全局字体为华文中宋
set(gca,"FontSize",10); % 设置全局字号10
exportgraphics(f1,["str_heading.emf"],"ContentType","vector"); % 无损高清矢量图
sstrherro_RMS = sqrt(mean(sstr_heading_error_whole_process.^2));
pstrherro_RMS = sqrt(mean(pstr_heading_error_whole_process.^2));
sstrherro_max = max(abs(sstr_heading_error_whole_process));
pstrherro_max = max(abs(pstr_heading_error_whole_process));

% Stanley 和 预测Stanley U型路径对比
% 横向误差
sut = [su_tout(1); su_tout(6:end)];
sucerro = su_cross_error_whole_process;
f2 = figure('Color', 'white');
f2.Units = "inches"; % 设置单位为英寸
f2.Position = [100  400 4*1.5 3*1.5];
set(gcf, "Name", "Cross Error", "NumberTitle", "off"); %设置figure的名称
f2.MenuBar = "none"; % 关闭菜单栏
p2 = plot(sut, sucerro, "Marker", "diamond", "MarkerIndices", ...
    1:10:length(sucerro),'Color',color(1,:),'LineWidth', 1.5); 
p2.LineWidth = 1.5; % 设置线宽
p2.Color = color(1,:); % 设置自定义颜色
xlabel('跟踪时间（s）'); % 设置X轴标签
ylabel('横向误差（m）'); % 设置Y轴标签
xlim([min(sut)*1.1 max(sut)]); % 设置X轴显示范围
ylim([min(sucerro)*1.1 max(sucerro)*1.1]); % 设置Y轴显示范围，根据数据修改
hold on
put = [pu_tout(1); pu_tout(6:end)];
pucerro = pu_cross_error_whole_process;
plot(put, pucerro, "Marker", "diamond", "MarkerIndices", ...
    1:10:length(pucerro),'Color',color(2,:),'LineWidth', 1.5); 
legend(sps_legend,'Location', 'northeast'); % 设置图例
movegui(f2,"center"); % 移动图片至屏幕中心
set(gca,"FontName","华文中宋"); % 设置全局字体华文中宋
set(gca,"FontSize",10); % 设置全局字号10
exportgraphics(f2,["u_cross.emf"],"ContentType","vector"); % 无损高清矢量图
sucerro_RMS = sqrt(mean(su_cross_error_whole_process.^2));
pucerro_RMS = sqrt(mean(pu_cross_error_whole_process.^2));
sucerro_max = max(abs(su_cross_error_whole_process));
pucerro_max = max(abs(pu_cross_error_whole_process));

% 航向误差
suherro = su_heading_error_whole_process *180/pi;
f1 = figure('Color', 'white');
f1.Units = "inches"; % 设置单位为英寸
f1.Position = [100  400 4*1.5 3*1.5];
set(gcf, "Name", "Heading Error", "NumberTitle", "off"); %设置figure的名称
f1.MenuBar = "none"; % 关闭菜单栏
p1 = plot(sut, suherro,  "Marker", "diamond", "MarkerIndices", ...
    1:10:length(suherro),'Color',color(1,:),'LineWidth', 1.5); 
p1.LineWidth = 1.5; % 设置线宽
xlabel('跟踪时间（s）'); % 设置X轴标签
ylabel('航向误差（Deg）'); % 设置Y轴标签
xlim([min(sut)*1.1 max(sut)]); % 设置X轴显示范围
ylim([min(suherro)*1.1 max(suherro)*1.1]); % 设置Y轴显示范围，根据数据修改
hold on
put = [pu_tout(1); pu_tout(6:end)];
puherro = pu_heading_error_whole_process *180/pi;
plot(put, puherro, "Marker", "diamond", "MarkerIndices", ...
    1:10:length(puherro),'Color',color(2,:),'LineWidth', 1.5);
sps_legend = {"\fontname{Time New Roman}Stanley",...
    "预测\fontname{Time New Roman}Stanley"};
legend(sps_legend,'Location', 'northeast'); % 设置图例
movegui(f1,"center"); % 移动图片至屏幕中心
set(gca,"FontName","华文中宋"); % 设置全局字体为华文中宋
set(gca,"FontSize",10); % 设置全局字号10
exportgraphics(f1,["u_heading.emf"],"ContentType","vector"); % 无损高清矢量图
suherro_RMS = sqrt(mean(su_heading_error_whole_process.^2));
puherro_RMS = sqrt(mean(pu_heading_error_whole_process.^2));
suherro_max = max(abs(su_heading_error_whole_process));
puherro_max = max(abs(pu_heading_error_whole_process));
