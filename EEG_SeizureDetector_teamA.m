function gmarker = EEG_SeizureDetector_teamA(eeg)
%The following is training of KNN clarification model with the EEG data 
%given by Professor online

features = load('features.mat'); %Importing already created feature matrix
features = features.X; %access the matrix from struct
gtrue = load('GT.mat');  %Importing already created GT marix
gtrue = gtrue.Y; %access the matrix from struct
%}
%Finally Train the KNN model with the created GLOBAL feature & GT marixs 
mdl = fitcknn(features,gtrue,'NumNeighbors',11,'Standardize',1);
%mdl = load('mdl500.mat');

%mdl = knn(); %This is creating the KNN model from scratch...20min for 1000
%width...suggest not to do it.

band = 5; %0.5-30 Hz
window = 500; %Fast Processing

%Extract the features from the testing signal (Also the remainder after
%windowing
[features,modulus] = eegmeasure(eeg,band,window); 

%Run the test signal's features through the KNN clasification model
result = predict(mdl,features); 

%Reconstruct a full sized auto GT vector from the windowed version
gmarker = [];
for i = 1:length(result)
    %If value is 0, then add 'window' number of 0 to the full sized version
    if result(i) == 0 
        gmarker = [gmarker;zeros(window,1)];
    %If value is 1, then add 'window' number of 1 to the full sized version
    else 
        gmarker = [gmarker;ones(window,1)];
    end
end
%Add zeros to fill the spaces that were cut when the signal was windowed
gmarker = [gmarker;zeros(modulus,1)]; %The remainder that was removed (Better FP than FN) that is why it is zero
end
