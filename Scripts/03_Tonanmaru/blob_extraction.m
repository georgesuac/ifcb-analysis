raw_data_dir = '/Users/jorge/myPlanktoNET/Image_datasets/2_Tonanmaru2025/IFCB_RAW_data/';
blob_output_dir = '/Users/jorge/myPlanktoNET/Image_datasets/2_Tonanmaru2025/blob_output1/';
enable_parallel = false; % Set to true for faster processing once everything works

start_blob_batch_user_training(raw_data_dir, blob_output_dir, enable_parallel);