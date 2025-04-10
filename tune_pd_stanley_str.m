%% tune_pd_stanley_str.m
%% 作者：HPC2H2
%% 日期：20240424
%% 直线调ky, kv, k0, Np

clear
clc
warning off
load_system('predictive_stanley.slx');
% range_k_v = 100;
% range_k_y = 10;
% cross_RMSs = zeros(range_k_v,range_k_y);
% yaw_RMSs = zeros(range_k_v,range_k_y);

% 初始位置（-1，-1,30°），跟踪45°（0,0）出发直线
% for k_v = 1:100
%     for k_y = 1:10
% k_v = 1; k_y = 41; k0 = 1;Np = 0; 0.1061540.347886 与Stanley一样
k_v = 1;
k_y = 41;
k0 = 0.90;
Np = 5;
%
        set_param('predictive_stanley/Stanley算法','k_v', num2str(k_v),...
            'k_y', num2str(k_y),'c', num2str(0),'k0', num2str(k0),...
            'Np', num2str(Np));
        sim('predictive_stanley');
        RMS_yerror_cur = sqrt(mean(yaw_error_whole_process.^2));
        RMS_cerror_cur = sqrt(mean(cross_error_whole_process.^2));
%         cross_RMSs(k_v, k_y) = RMS_cerror_cur;
%         yaw_RMSs(k_v, k_y) = RMS_yerror_cur;
        fprintf("%d %d %d %d\n%f%f",k_v,k_y,k0,Np,RMS_yerror_cur,RMS_cerror_cur)
% %     end
% % end
% 
% save stanley_str.mat cross_RMSs yaw_RMSs



