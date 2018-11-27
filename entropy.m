function ent  = entropy(signal)
% Generate the histogram 
nbins = 25;
[n x] = hist(signal,nbins); 

% Normalize the area of the histogram to make it a pdf 
n = n / sum(n); 

% Calculate the entropy 
indices = n ~= 0; 
ent = -sum(n(indices).*log2(n(indices))); 
end