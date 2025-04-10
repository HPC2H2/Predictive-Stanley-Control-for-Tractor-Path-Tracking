%% stanleyControlSFunction.m
%% 用于stanley.slx模型的S-Function，实现stanley控制器功能
%% 作者：HPC2H2
%% 日期：20240507

function [sys, x0, str, ts] = stanleyControlSFunction(t, x, u, flag,...
                                                        k_y, k_v, c)
switch flag
    case 0
        [sys, x0, str, ts] = mdlInitializeSizes;
    case 2
        sys = mdlUpdates(t, x, u);
    case 3
        sys = mdlOutputs(t, x, u, k_y, k_v, c);
    case {1, 4, 9}
        sys = [];
    otherwise
        error(['unhandled flag = ', num2str(flag)]);
end
%%
    function[sys, x0, str, ts] = mdlInitializeSizes
        sizes = simsizes;
        sizes.NumContStates = 0;
        sizes.NumDiscStates = 3;
        sizes.NumOutputs = 9; % inputs errors refs stops
        sizes.NumInputs = 3; % 当前车辆的x、y、yaw
        % sizes.NumInputs = 4; % 当前车辆的x、y、yaw、vx
        sizes.DirFeedthrough = 1;
        sizes.NumSampleTimes = 1;
        sys = simsizes(sizes);
        x0 = [0.0001; 0.0001; 0.0001]; % 初始状态，与车初始位姿无关
        str = [];
        ts = 0.1; % 控制时间（采样时间）
    end
%%
    function sys = mdlUpdates(~, x, ~)
        sys = x;
    end
%%
    function sys = mdlOutputs(~, ~, u, k_y, k_v, c)
        %% 导入路径
        % ref_poses = load('str.txt');
        ref_poses = load('u.txt');

        %% 输入：车当前位姿和速度
        pose = zeros(1, 3);
        pose(1) = u(1);
        pose(2) = u(2);
        pose(3) = u(3);
        % cur_v = u(4);
        
        % 速度控制
        % vx = 1.98/3.6; % 前进挡一档
        % vx = 3/3.6; % 前进挡二档
        vx = 4.71/3.6; % 前进挡三档
        % vx = 6.49/3.6; % 前进挡四档
        cur_v = vx;

        %% 输出：转角、速度；横向误差、航向误差；参考路径；停止条件
        % 计算控制输出
        [output_delta, crossing_error, heading_error, pre_point, path_length] = ...
            computeDeltaErrorsAndPathInfo(pose, ref_poses, cur_v, k_y, k_v, c);

        inputs = zeros(1,2);
        inputs(1) = vx; 
        inputs(2) = output_delta;

        errors = zeros(1,2);
        errors(1) = crossing_error;
        errors(2) = heading_error;

        refs = zeros(1,3);
        refs(1) =  ref_poses(pre_point,1);
        refs(2) =  ref_poses(pre_point,2);
        refs(3) =  ref_poses(pre_point,3);

        stops = zeros(1,2);
        stops(1) = pre_point;
        stops(2) = path_length;

        sys = [inputs errors refs stops];
    end

%% 求最近点索引
    function min_ind = findLastMinInd(pose, ref_poses)
        path_length = size(ref_poses, 1);
        min_dist = norm(ref_poses(1, 1:2) - pose(1:2));
        min_ind = 1;
        % 找最后一个最近点
        for i = 1:path_length
            %计算当前车辆距离路径点的位置
            dist = norm(ref_poses(i, 1:2) - pose(1:2));
            if min_dist >= dist
                min_dist = dist;
                min_ind = i;
            end
        end
    end

%% 输出转角及计算误差
    function [delta, e_y, eh_yaw, pre_point, path_length] = ...
            computeDeltaErrorsAndPathInfo(pose, ref_poses, cur_v, k_y, k_v, c)

        % 当当前参考路径最近点为参考路径终点，下列标志置1，返回正确prepoint值用
        is_moved_forward_re_point = 0;
        %% 产生横向误差对应的转角
        % 找最近的两个路径点
        pre_point = findLastMinInd(pose, ref_poses);
        % pre_point = pre_point;
        path_length = size(ref_poses,1);
        % if pre_point > path_length
        %     pre_point = path_length;
        % end
        
        % 当前参考路径最近点为参考路径终点
        if pre_point == path_length
            pre_point = pre_point - 1;
            is_moved_forward_re_point = 1;
        end

        % e_y = norm(ref_poses(pre_point, 1:2) - pose(1:2));
        %
        % % 判断横向误差方向
        % % 转换为车身平面坐标系，看x是否大于0。
        % % 如果大于0，就要右转，横向误差符号取反。
        % dx = ref_poses(pre_point, 1) - pose(1);
        % dy = ref_poses(pre_point, 2) - pose(2);
        % is_path_right = dx*sin(pose(3))- dy*cos(pose(3));
        %
        % if is_path_right > 0
        %     e_y = -e_y;
        % end
        
        deno = ref_poses(pre_point + 1, 1) - ref_poses(pre_point, 1);
        % 防inf限制
        if deno > 0 && deno <= 1e-3
            deno = 1e-3;
        end
        if deno <= 0 && abs(deno)<= 1e-3
            deno = -1e-3;
        end
        Ar = (ref_poses(pre_point + 1, 2) - ref_poses(pre_point, 2))/deno;
        Br  = (ref_poses(pre_point + 1, 1)*ref_poses(pre_point, 2) - ...
            ref_poses(pre_point, 1)*ref_poses(pre_point + 1, 2))/deno;
        e_y = abs(Ar * pose(1) - pose(2) + Br)/sqrt(Ar^2 + 1);
        is_path_right = (ref_poses(pre_point, 1) - pose(1))*...
            (ref_poses(pre_point + 1, 2) - pose(2)) -...
            (ref_poses(pre_point, 2) - pose(2))*...
            (ref_poses(pre_point + 1, 1) - pose(1));
        if is_path_right > 0
            e_y = -e_y;
        end


        % 产生控制量
        ey_yaw = atan2(k_y * e_y, k_v*cur_v + c);

        %% 产生航向误差对应的转角,范围 -pi 到 pi
        if pre_point >= path_length
            eh_yaw = ref_poses(pre_point, 3) - pose(3);
        else
            eh_yaw = atan2((ref_poses(pre_point + 1, 2) - ...
                ref_poses(pre_point, 2)), ...
                (ref_poses(pre_point + 1, 1) - ...
                ref_poses(pre_point, 1))) - pose(3);
        end

        % 角度限制
        if eh_yaw > pi
            eh_yaw = eh_yaw - 2*pi;
        end
        if eh_yaw < -pi
            eh_yaw = eh_yaw + 2*pi;
        end

        %% 输出转角，限定在±20°
        delta = eh_yaw + ey_yaw;

        if delta > pi/9
            delta = pi/9;
        end
        if delta < -pi/9
            delta = -pi/9;
        end
    
        if is_moved_forward_re_point == 1
            pre_point = path_length;
        end
    end
end