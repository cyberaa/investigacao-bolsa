function file_name = untitled(file_name)
%%%
%% Test-function to save a Matlab plot to a file, without actually ploting it to the user.
%% Receives the name of the file as an input
%% For test-purposes the graphs to be ploted are hard-coded but this works if we pass then as input
%%%

    t=(0:5)';
    data = t*2;
    data_miss = t*6;
    data_fix = t*3;

    f = figure(1);
    set(f,'Visible','Off');
    
    plot(t,data,t,data_miss,t,data_fix,'--');
    legend('Original', 'Missing', 'Fixed');
    title('Filling missing data');
    
    file_name = strcat(file_name,'.png');
    saveas(1,file_name);%%Same number as in f=figure(1);
end