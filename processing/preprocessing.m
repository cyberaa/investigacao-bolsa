function [filename] = preprocessing(filePath,method,ts)

    [status,t,data] = get_data_from_file(filePath);
    
    if nargin == 4
        [t,data] = fix_missing(t,data,method,ts);
    else
        [t,data] = fix_missing(t,data,method);
    end
    
    [ignored1, filename, ext] = fileparts(filePath);
    
    filename = strcat(filename,'_fixed');
    filename = strcat(filename,'.csv');
    csvwrite(filename,[t,data]);
end

