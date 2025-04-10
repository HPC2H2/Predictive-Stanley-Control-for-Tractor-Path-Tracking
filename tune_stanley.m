%% tune_stanley_str.m
%% 作者：HPC2H2
%% 日期：20240424
%% 直线调ky, kv

clear
clc
warning off
load_system('stanley.slx');
% range_k_v = 100;
% range_k_y = 10;
% cross_RMSs = zeros(range_k_v,range_k_y);
% yaw_RMSs = zeros(range_k_v,range_k_y);

% 初始位置（-1，-1,30°），跟踪45°（0,0）出发直线
% for k_v = 1:100
%     for k_y = 1:10
% 最好结果：k_v = 1; k_y = 41; 0.1061540.347886
% 然而，当k_y=1，k_v = 1,0.1111000.371535
% 当k_y = 1, k_v = 10, 0.1242110.487555
k_v = 1;
k_y = 41;
%
        set_param('stanley/Stanley算法','k_v', num2str(k_v),...
            'k_y', num2str(k_y),'c', num2str(0));
        sim('stanley');
        RMS_yerror_cur = sqrt(mean(yaw_error_whole_process.^2));
        RMS_cerror_cur = sqrt(mean(cross_error_whole_process.^2));
%         cross_RMSs(k_v, k_y) = RMS_cerror_cur;
%         yaw_RMSs(k_v, k_y) = RMS_yerror_cur;
        fprintf("%d %d\n%f%f",k_v,k_y,RMS_yerror_cur,RMS_cerror_cur)
% %     end
% % end
% 
% save stanley_str.mat cross_RMSs yaw_RMSs



