%%%%
%% Function that generates a random signal, used as an input for a given system. This function returns the system's output for the generated input
%%  number_data is the amount of data to generate
%%%%
function y=teste_gera_series(number_data)
    load sys.mat
    
    signal = rand();
    random_number = rand();
    
    if (signal > 0.5)
       random_number = random_number + signal;
    else
        random_number = random_number - signal;
    end     

    t = 0:0.01:number_data-1;
    u = sin(0.01*rand()*t) + random_number;%input
    y = lsim(sys,u,t);
    
    figure(1);
    plot(t,u,'b');
    hold on;
    plot(t,y,'r');
    legend('Generated System Input','System Output');
end