raw_data_dir = '/Users/jorge/myPlanktoNET/ifcb-analysis/Data/2023_Microcosms-Ishigaki/RAW_data/';
blob_output_dir = '/Users/jorge/myPlanktoNET/ifcb-analysis/Data/2023_Microcosms-Ishigaki/blob_output/';
enable_parallel = true; % Set to true for faster processing once everything works

start_blob_batch_user_training(raw_data_dir, blob_output_dir, enable_parallel);