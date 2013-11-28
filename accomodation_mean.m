function accomodated=accomodation_mean(t,w,detected)
    accomodated=zeros(length(t),1);
    accomodated(detected==1) = mean(w);
    accomodated(detected==0) = w(detected==0);
end