t=(0:500)';

%data=generate_series(t);
data = generate_time_series(-1,1,length(t),-5,5);  data = data';
%data = generate_time_series2(501);

data_miss = add_missing(data, 0.10);

data_fix = fix_missing(t,data_miss);


figure(1);
plot(t,data,t,data_miss,t,data_fix,'--');
legend('Original', 'Missing', 'Fixed');
title('Filling missing data');

[data_outliers,outlier_locations]=add_outliers(data, 0.15,std(data)*1.15,std(data)*1.15);

[data_fix_outliers,outliers,dL,dH] = accomodate_outliers(t,data_outliers,round(0.01*length(t)),round(0.01*length(t))-1,0.8,0);

fprintf('Inserted %d outliers, found %d.\n', sum(outlier_locations), sum(outliers));

TP = length(find(outliers==1 & outlier_locations==1));
TN = length(find(outliers==0 & outlier_locations==0));
FP = length(find(outliers==1 & outlier_locations==0));
FN = length(find(outliers==0 & outlier_locations==1));

recall=TP/(TP+FN);
fprintf('True Positive Rate (recall): %.2f%%\n', 100.0*recall);
fprintf('True Negative Rate: %.2f%%\n', 100.0*TN/(FP+TN));

precision = TP/(TP+FP);
fprintf('Positive Predictive Rate (precision): %.2f%%\n', 100.0*precision);
fprintf('Negative Predictive Rate: %.2f%%\n', 100.0*TN/(TN+FN));

fprintf('F-Measure: %f\n', 2*precision*recall / (precision+recall));

[diffseries, quaddiff,complexdiff] = compare_series(data_fix, data_fix_outliers);

fprintf('-------------------- ACCOMODATED --------------------\n');
fprintf('Euclidian Distance: %.2f\n', quaddiff);
fprintf('Complex Invariant Distance: %.2f\n', complexdiff);


figure(2);
plot_outlier_data(t,data_fix,data_outliers,outlier_locations,data_fix_outliers,dL,dH);
[diffseries_o, quaddiff_o,complexdiff_o] = compare_series(data_fix, data_outliers);

fprintf('------------------- WITH OUTLIERS -------------------\n');
fprintf('Euclidian Distance (with Outliers): %.2f\n', quaddiff_o);
fprintf('Complex Invariant Distance (with Outliers): %.2f\n', complexdiff_o);

figure(3);
plot(t,diffseries,t,diffseries_o);
legend('Data - Accomodated', 'Data - Outliers');
title('Filling missing data');

figure(4);
plot(t,data_fix, t,data);
legend('Accomodated Data', 'Original data');
title('Accomodated versus Original data');