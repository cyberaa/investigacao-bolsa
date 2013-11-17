%%%%
%% Function that generates a random signal, used as an input for a given system. This function returns the system's output for the generated input
%%  number_data is the amount of data to generate
%%%%
function [y,t,u]=teste_gera_series(number_data)
    load sys.mat
    
    step = 0.1;
    limit = (number_data-1)*step;%So we generate "number_data" elements
    random_number = rand(1,number_data);
    
    temp = find(random_number>0.5);
    %Y(find(Y<3)) = rand(length(find(Y<3)),1);
    random_number(temp) = rand(length(temp),1);%This should work....

    t = 0:step:limit;
    u = sin(0.01*t) + random_number*0.05;%input
    y = lsim(sys,u,t);
    
    
    figure(1);
    plot(t,u,'b');
    hold on;
    plot(t,y,'r');
    legend('Generated System Input','System Output');
    
end