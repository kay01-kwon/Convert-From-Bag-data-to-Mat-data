function [] = Execution_func(bag_data_folder_name,save_folder_name)

current_path_dir = pwd;
current_path_dir = strcat(current_path_dir,'/');


% path revision
path_of_file=strcat(current_path_dir,bag_data_folder_name);
path_of_file=strcat(path_of_file,'/');

path_to_save=strcat(current_path_dir,save_folder_name);


file_ = dir(fullfile(path_of_file,'*.bag'));

file_num = length(file_);

    for i = 1:file_num
        fprintf("Progress : %f percent",i/file_num*100);
        
        bag_to_mat_files(file_(i).name,path_of_file,path_to_save);
    end

end