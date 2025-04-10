# Predictive-Stanley-Control-for-Tractor-Path-Tracking
本科毕设，《拖拉机路径跟踪的预测 Stanley 控制方法》的仿真部分。

`stanley.slx`是Simulink的模型文件（内含已注释掉的CarSim模块的废案），里面有S-Function模块（PStanley和Stanley），分别连接着对应的S-Function模块 m代码文件`predictiveStanleyControlSFunction.m`和`stanleyControlSFunction.m`。这两个m文件里可以导入`u.txt`或`str.txt`两种路径，在每一个离散时间通过当前车辆离目标位置和航向角的偏差，来算横向误差和航向误差，运用预测Stanley或者Stanley控制方法来输出轮转角以及计算的误差。在模型文件中，可以设置这两个S-Function模块的参数。在仿真结束时，还会输出各类数据到MATLAB基础工作区中，以及存到以方法和路径缩写为前缀后跟多个参数并用下划线分隔为名的mat文件中。

`generateStrRoad.m`是输出`str.txt`的代码文件，`generateURoad.m`是输出`u.txt`的代码文件。

`measureControllerPerformance.m`是根据仿真后得到的mat文件做的数据可视化。

以`tune_`开头的文件是以一定步长遍历参数运行模型，找最优参数的代码。

以`test_`开头的文件是根据输出的数据是否有问题，来判断函数编写是否有误的代码。

以`illustrate_`或`add_`开头的文件，是生成论文示意图的辅助代码。

`caculate_init_k.m`是计算初始直线跟踪参数的代码。

另外，为什么笔者有些代码文件命名使用小驼峰，有些采用下划线命名法呢？这是因为，笔者平时python编多了，就习惯用下划线命名法了；但是笔者发现小黎的《路径规划和轨迹跟踪》系列学习视频的代码名字用的都是小驼峰，所以也照猫画虎一下，对于路径跟踪相关的算法文件就沿用这种命名方式了。
