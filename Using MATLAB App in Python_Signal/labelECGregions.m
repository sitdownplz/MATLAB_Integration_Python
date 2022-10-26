function [labelVals,labelLocs] = labelECGregions(x,t,parentLabelVal,parentLabelLoc,varargin)

labelVals = cell(2,1);
labelLocs = cell(2,1);

if nargin<5
    Fs = 250;
else
    Fs = varargin{1};
end

% Download the pretrained networks
netURL = 'https://ssd.mathworks.com/supportfiles/SPT/data/QTDatabaseECGSegmentationNetworks.zip'; %#ok<*UNRCH>
modelsFolder = fullfile(tempdir,'QTDatabaseECGSegmentationNetworks');
modelsFile = fullfile(modelsFolder,'trainedNetworks.mat');
zipFile = fullfile(tempdir,'QTDatabaseECGSegmentationNetworks.zip');
    if ~exist(modelsFolder,'dir')
        websave(zipFile,netURL);
        unzip(zipFile,fullfile(tempdir,'QTDatabaseECGSegmentationNetworks'));
    end
load(modelsFile)
    
    for kj = 1:size(x,2)
    
        sig = x(:,kj)';
    
        predTest = classify(rawNet,sig,'MiniBatchSize',50);
        
        msk = signalMask(predTest);
        msk.SpecifySelectedCategories = true;
        msk.SelectedCategories = find(msk.Categories ~= "n/a");
        
        labels = roimask(msk);
        labelVals{kj} = labels.Value;
        labelLocs{kj} = labels.ROILimits/Fs;
    end

labelVals = vertcat(labelVals{:});
labelLocs = cell2mat(labelLocs);

end