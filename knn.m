function mdl = knn()
%Machine Learning
gtrue = []; %Initilize GT matrix of all samples
features = []; %Initilize features matrix for all samples
for subject = 0:20    %Iterate through each patient
    
    [EEG,seizureGT] = loadfile(subject);  %Load the specific patient
    
   for channel = 1:23 %Iterate through each channel 
    band = 5; %All 0.5- 30Hz range
    window = 500; %Fast Processing (Could change later) (took ~20 min)
    
    %Extract 3 features (RMS, MedFreq,Entropy)
    [ftemp] = eegmeasure(EEG(channel).ch,band,window); 
    %Extract the segmented GT of specific subject
    [gtemp] = truthsegment(seizureGT,window);
    
    %Add the specific subject features to the GLOBAL feature matrix
    features = [features;ftemp];
    %Add the specific subject GT to the GLOBAL GT matrix
    gtrue = [gtrue;gtemp]; 
  end    
end

%Finally Train the KNN model with the created GLOBAL feature & GT marixs 
mdl = fitcknn(features,gtrue,'NumNeighbors',5,'Standardize',1);
end