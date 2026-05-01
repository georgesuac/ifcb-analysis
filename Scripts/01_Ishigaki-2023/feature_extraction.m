raw_data_dir = '/Users/jorge/myPlanktoNET/ifcb-analysis/Data/2023_Microcosms-Ishigaki/RAW_data/';
blob_output_dir = '/Users/jorge/myPlanktoNET/ifcb-analysis/Data/2023_Microcosms-Ishigaki/blob_output/';
feature_output_dir = '/Users/jorge/myPlanktoNET/ifcb-analysis/Data/2023_Microcosms-Ishigaki/feature_output/';
enable_parallel = true; % Set to true for faster processing once everything works

start_feature_batch_user_training(raw_data_dir, blob_output_dir, feature_output_dir, enable_parallel);

% raw_data_dir is the path to the folder containing the subdirectories containing the raw files
% blob_dir is the path to the folder containing the newly generated blob .zip files
% feature_output_dir is the path to the output folder