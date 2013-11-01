if ( false )
    oversampling_samples=100;
    target_num_samples=1000;

    num_outliers=100;
    outlier_min=0.25;
    outlier_max=0.5;

    snd=1.5;


    ns=(oversampling_samples+1)*target_num_samples+1;
    series=generate_time_series2(ns);
    %series=generate_time_series(ns,-1,1,ns,-0.25,0.25);


    outliers=add_outliers(series,oversampling_samples, target_num_samples, num_outliers,outlier_min,outlier_max);
    [Y,band_low,band_high]=detect_outliers_linear(outliers,oversampling_samples,target_num_samples,snd, 1:length(outliers));
    no_outliers=Y(1,:);
    hold off;
    plot(get_series_from_oversampled_data(outliers,oversampling_samples,target_num_samples));
    hold on;
    plot(no_outliers,'r');
    plot(get_series_from_oversampled_data(series,oversampling_samples,target_num_samples),'g');
    plot(band_low);
    plot(band_high);
    legend('Série c/ outliers', 'Série sem outliers', 'Série original');
else

    ns=100;
    num_outliers=17;
    outlier_min=0.5;
    outlier_max=1.5;
    snd=1.5;
    window_size=10;

    series=generate_time_series2(ns);
    outliers=general_add_outliers(series, num_outliers,outlier_min,outlier_max);
    
    [Y,band_low,band_high]=general_detect_outliers_linear(outliers,window_size,snd,1, 1:length(outliers));
    no_outliers=Y(1,:);
    [Ymedia,band_lowmedia,band_highmedia]=general_detect_outliers_linear(outliers,window_size,snd,0, 1:length(outliers));
    no_outliers_media=Ymedia(1,:);    
    
    hold off;
    plot(outliers,'b');
    hold on;
    plot(no_outliers,'--r');
    plot(no_outliers_media,'-.y');
    plot(series,'g');
    plot(band_low, 'r');
    plot(band_high, 'r');
    plot(band_lowmedia, 'black');
    plot(band_highmedia, 'black');
    legend('Série c/ outliers', 'Série sem outliers', 'Série sem outliers (c/ média)', 'Série original');
    
    pause
    hold off
    series=series';
    outliers=outliers';
    plot(no_outliers-series);
    hold on
    plot(outliers-series, 'r');
    plot(no_outliers_media-series, 'g');
    fprintf('Distância quadrática outliers-series: %f\n', sum((outliers-series).^2));
    fprintf('Distância quadrática filtrado-series: %f\n', sum((no_outliers-series).^2));
    fprintf('Distância quadrática filtrado (média)-series: %f\n', sum((no_outliers_media-series).^2));
    legend('Filtrado-original', 'Outliers-original', 'Filtrado (média)-original');
end