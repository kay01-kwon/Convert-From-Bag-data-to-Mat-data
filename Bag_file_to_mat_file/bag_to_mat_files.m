function [] = bag_to_mat_files(bag_name,path_of_file,path_to_save)

% Bag Data folder directory

bag_dir = strcat(path_of_file,bag_name)

bag = rosbag(bag_dir);

% Bag selection2020-03-17-17-44-42
odom_select= select(bag,'Topic','/odom');
wheel_odom_select= select(bag,'Topic','/wheel_odom');
slam_pose_select = select(bag,'Topic','/slam_pose');
input_select = select(bag,'Topic','/input_msg');
% error_select = select(bag,'Topic','/error_msg');
traj_select = select(bag,'Topic','/des_traj');
% motorvel_select = select(bag,'Topic','/measure');

% Timeseries

odom_ts = timeseries(wheel_odom_select,'Pose.Pose.Position.X',...
                'Pose.Pose.Position.Y',...
                'Twist.Twist.Linear.X','Twist.Twist.Linear.Y',...                
                'Pose.Pose.Orientation.W','Pose.Pose.Orientation.X',...
                'Pose.Pose.Orientation.Y','Pose.Pose.Orientation.Z');
                         
wheel_odom_ts = timeseries(wheel_odom_select,'Pose.Pose.Position.X',...
                'Pose.Pose.Position.Y',...
                'Twist.Twist.Linear.X','Twist.Twist.Linear.Y',...                
                'Pose.Pose.Orientation.W','Pose.Pose.Orientation.X',...
                'Pose.Pose.Orientation.Y','Pose.Pose.Orientation.Z');
            
slam_pose_ts = timeseries(slam_pose_select,'Pose.Pose.Position.X',...
                 'Pose.Pose.Position.Y',...
                 'Twist.Twist.Linear.X','Twist.Twist.Linear.Y',...                
                 'Pose.Pose.Orientation.W','Pose.Pose.Orientation.X',...
                 'Pose.Pose.Orientation.Y','Pose.Pose.Orientation.Z');
             
input_ts = timeseries(input_select,'Omega1','Omega2','Omega3','Omega4');

% error_ts = timeseries(error_select,'Pose.Pose.Position.X',...
%                 'Pose.Pose.Position.Y',...
%                 'Twist.Twist.Linear.X','Twist.Twist.Linear.Y');

traj_ts = timeseries(traj_select,'Pose.Pose.Position.X',...
                'Pose.Pose.Position.Y',...
                'Twist.Twist.Linear.X','Twist.Twist.Linear.Y',...
                'Twist.Twist.Angular.Z');

% motorvel_ts = timeseries(motorvel_select);

% Data storage
odom_data(:,1) = odom_ts.Time;
odom_data(:,2) = odom_ts.Data(:,1); % x
odom_data(:,3) = odom_ts.Data(:,2); % y
odom_data(:,4) = odom_ts.Data(:,3); % vx
odom_data(:,5) = odom_ts.Data(:,4); % vy
odom_data(:,6) = odom_ts.Data(:,5); % qw
odom_data(:,7) = odom_ts.Data(:,6); % qx
odom_data(:,8) = odom_ts.Data(:,7); % qy
odom_data(:,9) = odom_ts.Data(:,8); % qz

wheel_odom_data(:,1) = wheel_odom_ts.Time;
wheel_odom_data(:,2) = wheel_odom_ts.Data(:,1); % x
wheel_odom_data(:,3) = wheel_odom_ts.Data(:,2); % y
wheel_odom_data(:,4) = wheel_odom_ts.Data(:,3); % vx
wheel_odom_data(:,5) = wheel_odom_ts.Data(:,4); % vy
wheel_odom_data(:,6) = wheel_odom_ts.Data(:,5); % qw
wheel_odom_data(:,7) = wheel_odom_ts.Data(:,6); % qx
wheel_odom_data(:,8) = wheel_odom_ts.Data(:,7); % qy
wheel_odom_data(:,9) = wheel_odom_ts.Data(:,8); % qz
 
slam_pose_data(:,1) = slam_pose_ts.Time;
slam_pose_data(:,2) = slam_pose_ts.Data(:,1); % x
slam_pose_data(:,3) = slam_pose_ts.Data(:,2); % y
slam_pose_data(:,4) = slam_pose_ts.Data(:,3); % vx
slam_pose_data(:,5) = slam_pose_ts.Data(:,4); % vy
slam_pose_data(:,6) = slam_pose_ts.Data(:,5); % qw
slam_pose_data(:,7) = slam_pose_ts.Data(:,6); % qx
slam_pose_data(:,8) = slam_pose_ts.Data(:,7); % qy
slam_pose_data(:,9) = slam_pose_ts.Data(:,8); % qz

input_data(:,1) = input_ts.Time;
input_data(:,2) = input_ts.Data(:,1); % omega1
input_data(:,3) = input_ts.Data(:,2); % omega2
input_data(:,4) = input_ts.Data(:,3); % omega3
input_data(:,5) = input_ts.Data(:,4); % omega4

% error_data(:,1) = error_ts.Time;
% error_data(:,2) = error_ts.Data(:,1); % x_err
% error_data(:,3) = error_ts.Data(:,2); % y_err
% error_data(:,4) = error_ts.Data(:,3); % vx_robot(Moving Average)
% error_data(:,5) = error_ts.Data(:,4); % vy_robot(Moving Average)

traj_data(:,1) = traj_ts.Time;
traj_data(:,2) = traj_ts.Data(:,1); % x_des
traj_data(:,3) = traj_ts.Data(:,2); % y_des
traj_data(:,4) = traj_ts.Data(:,3); % vx_des
traj_data(:,5) = traj_ts.Data(:,4); % vy_des
traj_data(:,6) = traj_ts.Data(:,5); % vphi_des

% N = length(motorvel_ts.Time);
% motorvel_cell = motorvel_select.readMessages;
% for i = 1:N
%     for j = 1:4
%         if j==1
%             motorvel_data(i,j) = motorvel_ts.Time(i);
%         end
%         motorvel_data(i,j+1) = motorvel_cell{i}.RealVel(j);
%     end
% end

bag_name = strrep(bag_name,'.bag','.mat');
path_to_save = strcat(path_to_save,'/');
bag_name = strcat(path_to_save,bag_name);

save(bag_name,'wheel_odom_data','slam_pose_data','input_data','traj_data','odom_data');
        
clear all;

end