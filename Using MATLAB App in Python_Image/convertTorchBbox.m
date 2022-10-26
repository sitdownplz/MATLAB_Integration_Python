function torch_bounding_box = convertTorchBbox(Bbox_tbl)
%% Convert MATLAB ImageLabeler Bounding Box output into pyTorch Format
% MATLAB using format [xmin, ymin, width, height] for bounding box
% PyTorch is using format [xmin, ymin, xmax, ymax] for bounding box

torch_bounding_box = varfun(@(x) cellfun(@sub,x,'UniformOutput',false),Bbox_tbl);

% Keep the original column name
torch_bounding_box.Properties.VariableNames  = Bbox_tbl.Properties.VariableNames;  

% Helper Function
    function input = sub(input)
        % Check if there is any bounding box and not a char (file name)
        if ~isempty(input) & isa(input,'double')
            input(:,3:4) = input(:,1:2) + input(:,3:4); % [xmin, ymin, xmin+W, ymin+H]
        end
    end

end