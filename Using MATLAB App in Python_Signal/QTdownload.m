function folder = QTdownload

dataURL = 'https://www.mathworks.com/supportfiles/SPT/data/QTDatabaseECGData1.zip';
datasetFolder = fullfile(tempdir,'QTDataset');
zipFile = fullfile(tempdir,'QTDatabaseECGData.zip');
if ~exist(datasetFolder,'dir')
    websave(zipFile,dataURL);
    unzip(zipFile,tempdir);
end
folder = datasetFolder;

end