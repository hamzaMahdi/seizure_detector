
subject = input('\nEnter Subject #:\n');    %Input the patient #
channel = input('\nEnter Channel #:\n');    %Input the channel to test

[EEG,seizureGT] = loadfile(subject);  %Load the EEG and GT files of the subject

seizureMarker_auto = EEG_SeizureDetector_teamA(EEG(channel).ch); %Produce GT_auto

performanceMetrics = validation(seizureMarker_auto, seizureGT); %Output the metrics (tp,fp,fn,tn,accuracy)

performanceMetrics(5)
fs = 256; %Sampling Frequency
t = (0:1:length(EEG(channel).ch)-1)/fs;   % create time variable
%Plot binary seizure variable on top of EEG.ch data
%Note scaling of SeizureGT to make visible in plot
figure; plot(t, EEG(channel).ch); 
hold on; 
plot(t,(max(EEG(channel).ch))*seizureGT, 'r');
plot(t,seizureMarker_auto*(max(EEG(channel).ch)), 'k')
xlabel('Time(s)');
ylabel('Amplitude');
legend('EEG Signal','GT','Auto');