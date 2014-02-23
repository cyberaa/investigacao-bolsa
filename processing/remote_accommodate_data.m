function [accommodated_file,plot_name,number_outliers] = remote_accommodate_data(filePath,w_size,w_overlap,model,accommodation_type,param1)
    
    [status,t,data] = get_data_from_file(filePath);
    
    [data_fix, detected, dL, dH] = accomodate_outliers(t,data,w_size,w_overlap,model,accommodation_type,param1);
    
    %Plot the file
    f = figure(1);
    set(f,'Visible','Off');
    
    if ( sum(abs(dL)) ~= 0 && sum(abs(dH)) ~= 0)
        plot(t,dL,'k',t,dH,'k',t,data,'r-.',t,data_fix,'b');
        legend('Lower Bound','Upper Bound','Original Data','Accommodated Data');
        title('Outlier Accommodation Output');
    else
        plot(t,data,'r-.',t,data_fix,'b');
        legend('Original Data','Accommodated Data');
        title('Outlier Accommodation Output');
    end
    
    [ignored1, filename, ext] = fileparts(filePath);
     
    plot_name = strcat(filename,'_graphic');
    filename = strcat(filename,'_accommodated');
    accommodated_file = strcat(filename,'.csv');
    
    plot_name = strcat(plot_name,'.png');
    saveas(1,plot_name);%Same number as in f=figure(1);
    
    csvwrite(accommodated_file,[t,data_fix]);
    
    number_outliers=sum(detected);
    number_outliers=num2str(number_outliers);
end

