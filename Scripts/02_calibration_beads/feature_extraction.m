raw_data_dir = '/Users/jorge/Documents/MATLAB/calibration/data/';
blob_output_dir = '/Users/jorge/Documents/MATLAB/calibration/blob_output/';
feature_output_dir = '/Users/jorge/Documents/MATLAB/calibration/feature_output/';
enable_parallel = false; % Set to true for faster processing once everything works

start_feature_batch_user_training(raw_data_dir, blob_output_dir, feature_output_dir, enable_parallel);