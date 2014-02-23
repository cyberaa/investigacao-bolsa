function [status,t,data] = get_data_from_file (path)        
    [status, filedata] = parse_file(path);
    
    if status == 0
        t = 0; data = 0; return
    end
    
    [numrows, numcols] = size(filedata);            
    
    if numrows == 2
        t = filedata(1,:)';
        data = filedata(2,:)';
        status = 1;
    elseif numcols == 2
        t = filedata(:,1);
        data = filedata(:,2);
        status = 1;
    else
        status = 0; t=0; data=0;
    end
end

function [status,filedata] = parse_file(path)
    [ignored1, ignored2, ext] = fileparts(path);
    if strcmp(ext,'.csv')        
        filedata = csvread(path);
        status = 1;
    elseif strcmp(ext,'.xls') 
        [filedata,ingored1,ignored2] = xlsread(path);
        status = 1;
    elseif strcmp(ext,'.xlsx') 
        [filedata,ingored1,ingored2] = xlsread(path);
        status = 1;
    else
        status = 0;
    end    
end