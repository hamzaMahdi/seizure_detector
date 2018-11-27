function [seize] = truthsegment(truth,w)
%This function is exclusivly for the GT files
modulus = mod(length(truth),w); %Remainder total size when divided by window size
truth = truth(1:(length(truth) - modulus)); 
truthwin = zeros(w,length(truth)/w);%Make matrix: Row=window size col=specific window

for i = 1:(length(truth)/w) %iterate through each window 
    truthwin(:,i) = (truth(1+(i-1)*w:i*w)); %segment signal into the specific segments
end

seize = zeros(length(truthwin(1,:)),1); %Check if there is a seizure in the window 
for i = 1:(length(truthwin(1,:)))
    for j = 1:w
        if (truthwin(j,i) == 1)
            seize(i,1) = 1;
            break;
        end
    end
end


end