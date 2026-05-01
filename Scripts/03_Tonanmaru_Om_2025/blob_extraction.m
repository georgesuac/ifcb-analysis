% Blob extraction from IFCB raw data
% ---------------------------------
% 1) Run setup_ifcb_analysis
% 2) Set your project name below
% 3) Run this script
% 4) Enable parallel computing after testing for faster processing

% ==== USER INPUT (select) ====
project_name = '03_Tonanmaru_Om_2025';  % folder name inside 'Data'
enable_parallel = true;       % set to true after testing
% ====================================

% Automatically detect project root (ifcb-analysis folder)
project_root = fileparts(fileparts(fileparts(mfilename('fullpath'))));

% Build paths
data_dir = fullfile(project_root, 'Data', project_name);
raw_data_dir = [fullfile(data_dir, 'RAW_data') filesep];
blob_output_dir = [fullfile(data_dir, 'blob_output') filesep];

% ---- Checks ----
fprintf('\nProject: %s\n', project_name)
fprintf('RAW_data: %s\n', raw_data_dir)
fprintf('Output:   %s\n\n', blob_output_dir)

if ~exist(raw_data_dir, 'dir')
    error('RAW_data folder not found:\n%s', raw_data_dir);
end

if ~exist(blob_output_dir, 'dir')
    mkdir(blob_output_dir);
    fprintf('Created folder: %s\n\n', blob_output_dir)
end

% ---- Run extraction ----
start_blob_batch_user_training(raw_data_dir, blob_output_dir, enable_parallel);