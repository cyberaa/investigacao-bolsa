%%%%
% Plot the original data, outlier data and accomodated data in a pretty
% fashion.
%%%%
function plot_outlier_data(t,data,outlier_data,outliers,data_fixed, dL, dH)
    hold off;            
    
    n = outliers==1;
    outlier_data = outlier_data(n);
    t_outlier = t(n);
    
    plot(t_outlier,outlier_data,'r.');
    hold on;
    plot(t,data, 'b');
    plot(t,data_fixed, 'g-.');
    plot(t,dL,'k');
    plot(t,dH,'k');
    hold off;
    legend('Outliers', 'Original', 'Accomodated');
    title('Outlier Detection and Accomodation');
end