% setup_ifcb_analysis.m
% Clean MATLAB path setup for ifcb-analysis

restoredefaultpath
rehash toolboxcache

% Detect ifcb-analysis root automatically
ifcb_root = fileparts(mfilename('fullpath'));

% Add ifcb-analysis
addpath(genpath(ifcb_root))

% Try to find DIPUM automatically
dipum_root = '';

home_dir = getenv('HOME');

candidate_roots = {
    fullfile(home_dir, 'Library', 'Application Support', 'MathWorks', 'MATLAB Add-Ons', 'Toolboxes')
    fullfile(userpath, 'Add-Ons', 'Toolboxes')
};

for i = 1:numel(candidate_roots)
    if exist(candidate_roots{i}, 'dir')
        candidates = dir(fullfile(candidate_roots{i}, '*DIPUM*'));
        if ~isempty(candidates)
            dipum_root = fullfile(candidates(1).folder, candidates(1).name);
            break
        end
    end
end

% Add DIPUM if found
if ~isempty(dipum_root) && exist(dipum_root, 'dir')
    addpath(genpath(dipum_root))

    % Avoid DIPUM's old kmeans shadowing MATLAB's Statistics Toolbox kmeans
    dipum_kmeans = fullfile(dipum_root, 'ThirdPartyUtilityFunctions', 'kmeans', 'kmeans');
    if exist(dipum_kmeans, 'dir')
        rmpath(dipum_kmeans)
    end
else
    warning('DIPUM Toolbox was not found automatically. Feature extraction may fail.');
end

rehash toolboxcache

fprintf('\nifcb-analysis root:\n%s\n', ifcb_root)

fprintf('\nDIPUM invmoments:\n')
which invmoments

fprintf('\nMATLAB kmeans:\n')
which kmeans

fprintf('\nModHausdorffDistMex:\n')
which ModHausdorffDistMex

fprintf('\nSetup complete.\n\n')