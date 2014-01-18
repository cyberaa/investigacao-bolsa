function data = generate_series (t)
    
    %Componente periódica (período 100, 41 e 21), com pesos 2.5, 1.5 e 1
    d=2.5*sin(2*pi*t/100)+1.5*sin(2*pi*t/41)+1*sin(2*pi*t/21);
    
    %Randomness
    dn=d+0.5*randn(size(d));
    
    %Tendência 3/500*t
    dnt=dn+9/500*(t);
    
    data = dnt;               
end