function [bestEpsilon bestF1] = selectThreshold(yval, pval)
%SELECTTHRESHOLD Find the best threshold (epsilon) to use for selecting
%outliers
%   [bestEpsilon bestF1] = SELECTTHRESHOLD(yval, pval) finds the best
%   threshold to use for selecting outliers based on the results from a
%   validation set (pval) and the ground truth (yval).
%

bestEpsilon = 0;
bestF1 = 0;
F1 = 0;

stepsize = (max(pval) - min(pval)) / 1000;
for epsilon = min(pval):stepsize:max(pval)
    
    % ====================== YOUR CODE HERE ======================
    % Instructions: Compute the F1 score of choosing epsilon as the
    %               threshold and place the value in F1. The code at the
    %               end of the loop will compare the F1 score for this
    %               choice of epsilon and set it to be the best epsilon if
    %               it is better than the current choice of epsilon.
    %               
    % Note: You can use predictions = (pval < epsilon) to get a binary vector
    %       of 0's and 1's of the outlier predictions
    TP = 0 ;
    FP = 0 ;
    TN = 0 ;
    FN = 0 ;
	F1 = 0 ;
	predictions = (pval < epsilon);
	FP = sum((predictions == 1) & (yval == 0));
	TP = sum((predictions == 1) & (yval == 1));
	TN = sum((predictions == 0) & (yval == 0));
	FN = sum((predictions == 0) & (yval ==1)) ;
    pre = 0 ;
    re = 0 ;
    if(TP > 0 || FP > 0)
      pre = TP / (TP + FP) ;
    end
    if(TP > 0 || FN > 0)
		re = TP /(TP + FN);
	end
	
	
	
	if(re>0 || pre >0)
		F1 = 2*((pre*re)/(pre+re));
	end 
   
    
    if F1 > bestF1
       bestF1 = F1;
       bestEpsilon = epsilon;
    end
end

end
