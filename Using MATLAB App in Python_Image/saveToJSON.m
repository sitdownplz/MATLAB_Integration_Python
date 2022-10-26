function saveToJSON(Bbox_tbl, filename)
%% Encoding Output Table from ImageLabeler to JSON File
% Encode table variable to json format and save into file

% Encode table to json format
Bbox_encoded = jsonencode(Bbox_tbl);

switch nargin 
    case 1
        fid = fopen('BboxFromMATLAB.json','w');
    otherwise
        fid = fopen(filename,'w');
end
fprintf(fid,'%s',Bbox_encoded);
fclose(fid);





