function [eeg] = eegfilter(signal,band)
%This function is essentially the preproccesing portion 
%Select the appropriate Frequency Band
if(band == 1) %Delta
    fc1 = 4;
    fc2 = 0.5;
elseif(band == 2) %Theta
    fc1 = 8;
    fc2 = 4;
elseif(band == 3) %alpha
    fc1 = 14;
    fc2 = 8;
elseif(band == 4) %beta
    fc1 = 30;
    fc2 = 14;
else %Appropriate band for Seizures
    fc1 = 30;
    fc2 = 0.5;
end

fs = 256; %Sampling Freq

eegraw = signal;

%Normalize the signal
eeg0 = eegraw - mean(eegraw); 
eegnorm = eeg0./max(eeg0);

%Create the Bandpass with the specified Frequencies
[b1,a1] = butter(4,fc1/(fs/2),'low');
[b2,a2] = butter(4,fc1/(fs/2),'high');

%Pass the inputted Signal through the Bandpass filter
eegfilthold = filter(b1,a1,eegnorm);
eegfilt = filter(b2,a2,eegfilthold);
eeg = eegfilt;
end