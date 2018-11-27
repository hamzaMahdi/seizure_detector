function [EEG,seizureGT] = loadfile(subject)
 n = num2str(subject);  %Convert the number into a string
 
  %If statement corrects the numbering notations for subjects larger than 10
   if subject < 10 
    file = strcat('EEG_subject00',n,'.mat'); %Create the name of the subject file
    truthfile = strcat('seizureGT_subject00',n,'.mat'); %Create the name of subject's GT file
    else
    file = strcat('EEG_subject0',n,'.mat'); %Create the name of the subject file
    truthfile = strcat('seizureGT_subject0',n,'.mat'); %Create the name of subject's GT file
   end
   
    EEG = load(file);  %Input the subject file
    EEG = EEG.EEG;  %Input the subject file
    seizureGT = load(truthfile); %Input the GT file
    seizureGT = seizureGT.seizureGT; %Input the GT file
end