% Feature extraction from IFCB raw data and blob output
% ----------------------------------------------------
% 1) Run setup_ifcb_analysis
% 2) Make sure blob_extraction.m has already been completed
% 3) Set your project name below
% 4) Run this script
% 5) Enable parallel computing after testing for faster processing

% ==== USER INPUT (edit only this) ====
project_name = '03_Tonanmaru_Om_2025';  % folder name inside 'Data'
enable_parallel = true;       % set to true after testing
% ====================================

% Automatically detect project root (ifcb-analysis folder)
project_root = fileparts(fileparts(fileparts(mfilename('fullpath'))));

% Build paths
data_dir = fullfile(project_root, 'Data', project_name);
raw_data_dir = [fullfile(data_dir, 'RAW_data') filesep];
blob_output_dir = [fullfile(data_dir, 'blob_output') filesep];
feature_output_dir = [fullfile(data_dir, 'feature_output') filesep];

% ---- Checks ----
fprintf('\nProject: %s\n', project_name)
fprintf('RAW_data:       %s\n', raw_data_dir)
fprintf('Blob output:    %s\n', blob_output_dir)
fprintf('Feature output: %s\n\n', feature_output_dir)

if ~exist(raw_data_dir, 'dir')
    error('RAW_data folder not found:\n%s', raw_data_dir);
end

if ~exist(blob_output_dir, 'dir')
    error('blob_output folder not found. Run blob_extraction.m first:\n%s', blob_output_dir);
end

if ~exist(feature_output_dir, 'dir')
    mkdir(feature_output_dir);
    fprintf('Created folder: %s\n\n', feature_output_dir)
end

if isempty(which('ModHausdorffDistMex'))
    error('ModHausdorffDistMex not found. Compile ModHausdorffDistMex.cpp first.');
end

if isempty(which('invmoments'))
    error('DIPUM invmoments.m not found. Run setup_ifcb_analysis and check DIPUM installation.');
end

% ---- Run extraction ----
start_feature_batch_user_training(raw_data_dir, blob_output_dir, feature_output_dir, enable_parallel);