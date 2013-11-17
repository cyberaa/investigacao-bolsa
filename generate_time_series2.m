%%%%
% Generate a random time series with n samples
% This is METHOD 1
%%%%
function series=generate_time_series2(n) 

    % Get random numbers between 0 and 15
    x = 15*rand(n,1); 
    
    % Sort them, so they form an X axis
    x = sort(x);
    
    % Calculate their sine and add [-0.5,0.5( "noise"
    series = sin(x) + 0.5*(rand(size(x))-0.5);
end
