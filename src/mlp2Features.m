function [ day_results_2f ] = mlp2Features( dataSet, target, featuresIndexes, neurons, it, featuresLabels )
% mlp2Features.m: compute the performance MSE for each couple of features
% on the given data set and target, with the specified set of features and
% number of neurons. 'it' specifies how many times the same couple of
% features must be evaluated, i.e. how many samples to compute.
% 'featuresLabels' contains the labels created in the 'init.m' script.
% Returns all the computed MSEs and prints the best couple found.

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

fprintf('Training with all the possible couples of features\n');

data_day = dataSet;
cnt_day = target;
indexes = featuresIndexes;
numIt = it;
data_day_labels = featuresLabels;

numFeat = numel(indexes);


% upper triangular matrix expected, fix 1 feature and couple with the remaining 11; 11*12 / 2 = 66 couples
day_results_2f = zeros(numFeat-1,numFeat-1);

progress = 0;

k = 1; %used to properly set j's values
for i = indexes
    l = k;
    jIndexes = indexes;
    jIndexes(1:k) = []; % removing first k elements
    for j = jIndexes
        sum = 0;
        for it_num = 1:numIt
            day_performance = fitFeatureSize(data_day(:,[i j]), cnt_day, neurons);
            sum = sum + day_performance;
        end;
        day_results_2f(k, l) = sum/numIt;
        progress= progress + 1;
        %printing like "10% Feature (YR,MONTH) with error = 1.0001e5"
        fprintf('%0.2f%% Features: (%s,%s)\n',(progress * 100)/((numFeat-1)*numFeat/2), char(data_day_labels(i)), char(data_day_labels(j)));
        l = l + 1;
    end;
    k = k + 1;
end;

bestFeatA = indexes(1);
bestFeatB = indexes(2);
bestPerf = day_results_2f(1,1);

for i = 1:numFeat-1
    for j = i:numFeat-1
        if(day_results_2f(i,j) < bestPerf)
            bestPerf = day_results_2f(i,j);
            bestFeatA = indexes(i); %retrieving best feature index
            bestFeatB = indexes(j+1); %retrieving best feature index
        end
    end;
end;
fprintf('\nBest couple of features: (%s,%s) with error = %0.3e\n', char(data_day_labels(bestFeatA)), char(data_day_labels(bestFeatB)), bestPerf);
end
