function accomodated=accomodation_linear(t,w,detected)    
    accomodated=zeros(length(t),1);    
    
    Y = DataFitting(w,t);
    a = Y(1);
    b = Y(2);
    
    for i=1:length(w)
        if detected(i) == 1
                accomodated(i) = a-b* (t(i));
        end
    end
    
    accomodated(detected==0) = w(detected==0);
end