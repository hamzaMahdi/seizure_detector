function  [metrics] = validation(auto,gt)
window = 100;
auto = truthsegment(auto,window);
gt = truthsegment(gt,window);

tp = 0; fp = 0; fn = 0; tn = 0;
for i = 1:length(auto)
   if  (gt(i) == 1) && (auto(i) == 1)   %TP
       tp = tp+1;
   elseif (gt(i) == 0) && (auto(i) == 1)    %FP
       fp = fp+1;
   elseif (gt(i) == 1) && (auto(i) == 0)    %FN
       fn = fn+1;
   else %TN
       tn = tn+1;
   end
end
    accuracy = ((tp+tn)/(tp+tn+fp+fn))*100;
    metrics = [tp,fp,fn,tn,accuracy];
end