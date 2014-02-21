%%%%
% Detect and fix outliers using a windowing scheme (with or without
% overlap)
%
% INPUT:
%      t: Time values
%      data: Input series (with possible outliers)
%      w_size: Window size (in samples)
%      w_overlap: Window overlap (in samples)
%      snd: Standard Normal Deviation used for the methods (Typical values: 1.5,
%      2.0, 2.5, 3.0...)
%      model: 1 --> Linear Model; 0 --> Mean/Average model, 2 --> IQR
%      model, 3 --> Grubb's Model, 4 --> Modified Z-Score,5 -> MADe method
%
% OUTPUT:
%      data_fix: Output time series, with accomodated/fixed values
%      detected: Vector which indicates where outliers were found (and
%      accomodated). 0 means not found, 1 means found
%      dL, dH: Lower and Higher values of the bands used in the detection
%      of the outliers. Use this for plotting the bands.
%
%
% This uses a window of size w_size with overlap w_overlap. It then models
% the data in the window either with a constant model (model=0) or linear
% one (linear regression, model=1) and compares all the values in that
% window to their expected values. It admits differences in a range give by
% the SND (Standard Normal Deviation). Note that if there are many
% outliers, or if they are very significant (very 'outliery'), our models
% are skewed and may thus not only fail to detect the outlier, but also
% treat legitimate data as outliers. This happens because we aren't using
% robust methods.
%
%%%%
function [data_fix, detected, dL, dH]=accomodate_outliers(t,data,w_size,w_overlap,model,accomodation_type,param1)
    data_fix=zeros(length(data),1);
    dL=zeros(length(data),1);
    dH=zeros(length(data),1);
    detected=zeros(length(data),1);   
    step = w_size-w_overlap;   
    
    for i=1 : step : length(data)-w_overlap+1
        %%%%
        %% Perform linear regression on the window
        %%%%
        n=i : min(i+(w_size),length(data));
        w = data( n );
        wnd_t = t(n);
        
        if model == 0
            [detectedw, dLw, dHw] = stdMethod(wnd_t,w,param1);
        elseif model == 1
            [detectedw, dLw, dHw] = linearMethod(wnd_t,w,param1);            
        elseif model == 2
            [detectedw, dLw, dHw] = iqrMethod(wnd_t,w,param1);            
        elseif model == 3
            [detectedw, dLw, dHw] = grubbsMethod(wnd_t,w,param1);
        elseif model == 4
            [detectedw, dLw, dHw] = modZScore(wnd_t,w,param1);
        elseif model == 5
            [detectedw, dLw, dHw] = MADMethod(wnd_t,w,param1);
        end
        
        detected(n)=detectedw;
        dL(n) = dLw;
        dH(n) = dHw;
        
        if accomodation_type == 1
            data_fix(n) = accomodation_linear(wnd_t,w,detectedw);
        else
            data_fix(n) = accomodation_mean(wnd_t,w,detectedw);
        end
        
        continue;        

        %[val sample]        
    end
end