function Y = DataFitting(data,time)
    Ns = length(data);
    S_t = sum(time(1:Ns));
    S_z = sum(data(1:Ns));
    S_tt = sum(time(1:Ns).^2);
    S_zt = sum(data(1:Ns) .* time(1:Ns));

    Y = (1 / (S_tt + (S_t*S_t) ) )*[S_tt -S_t;-S_t 1];
    Y = Y * [S_z;S_zt];
end