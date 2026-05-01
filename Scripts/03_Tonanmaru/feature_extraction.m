raw_data_dir = '/Users/jorge/myPlanktoNET/Image_datasets/2_Tonanmaru2025/IFCB_RAW_data/';
blob_output_dir = '/Users/jorge/myPlanktoNET/Image_datasets/2_Tonanmaru2025/blob_output/';
feature_output_dir = '/Users/jorge/myPlanktoNET/Image_datasets/2_Tonanmaru2025/feature_output/';
enable_parallel = true; % Set to true for faster processing once everything works

start_feature_batch_user_training(raw_data_dir, blob_output_dir, feature_output_dir, enable_parallel);