%%%%
%% Function that generates a random input signal to a system, with "number_data" values
%%%%
function teste_gera_series(number_data)
    load sys.mat

    random_number = rand() + 10;%Random offset

    t = 0:number_data-1;
    u = sin(0.05*t) + random_number;
    figure(1);
    y = lsim(sys,u,t);
    plot(t,y);


    figure(2);
    plot(t,u);
end