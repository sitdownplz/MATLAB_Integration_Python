%% Main Script for MTK Day Demo - Use Image Labler in Python

% Create datastore from folder
sds = signalDatastore(folder,"SignalVariableNames","ecgSignal","SampleRateVariableName","Fs");

% Subset datastore
subsds = subset(sds,1:20);
lss = labeledSignalSet(subsds);