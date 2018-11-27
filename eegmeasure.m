function [features,modulus] = eegmeasure(signal,band,w)
[eeg] = eegfilter(signal,band); %Filter the inputted signal

fs = 256;

modulus = mod(length(eeg),w); %Remainder total size when divided by window size
eeg = eeg(1:(length(eeg) - modulus));

eegwin = zeros(w,length(eeg)/w); %Make matrix: Row=window size col=specific window

for i = 1:(length(eeg)/w) %iterate through each window
    eegwin(:,i) = (eeg(1+(i-1)*w:i*w)); %segment signal into the specific segments
end

%Measure each feature

%RMS
eegmean = zeros(length(eegwin(1,:)),1);
for i = 1:length(eegmean)
    eegmean(i,1) = rms(eegwin(:,i));
end

%Medium Freq
eegfreq = zeros(length(eegwin(1,:)),1);
for i = 1:length(eegfreq)
    eegfreq(i,1) = medfreq(eegwin(:,i),fs);
end

%Entropy
eegent = zeros(length(eegwin(1,:)),1);
for i = 1:length(eegent)
    eegent(i,1) = entropy(eegwin(:,i));
end

features = [eegmean,eegfreq,eegent]; %Output all 3 features together

end


