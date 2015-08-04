function [ day_results_nf ] = mlpNFeatures( dataSet, target, fixedFeatures, featuresIndexes, neurons, it, featuresLabels )
% mlpNFeatures.m: compute the performance MSE for each subset of features
% on the given data set and target, with the specified set of fixed
% features, number of neurons and by adding the given features in 
% 'featuresIndexes' one by one to the base features set. 
% 'it' specifies how many times the same subset of features must be
% evaluated, i.e. how many samples to compute. 'featuresLabels' contains
% the labels created in the 'init.m' script.
% Returns all the computed MSEs and prints the best subset found.

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

fprintf('Training with %d features FIXED:', numel(fixedFeatures));
for i = fixedFeatures
    fprintf('%s\t', char(featuresLabels(i)));
end
fprintf('\n');

numFeat = numel(featuresIndexes);

day_performance = 0;
day_results_nf = zeros(numFeat,1);

j = 1;
for i = featuresIndexes
        sum = 0;
        for it_num = 1:it
            day_performance = fitFeatureSize(dataSet(:,[fixedFeatures i]), target, neurons);
            sum = sum + day_performance;
        end;
        day_results_nf(j) = sum/it;
        fprintf('%0.2f%% Feature: %s with error = %0.3e\n',(j * 100/numFeat), char(featuresLabels(i)), day_results_nf(j));
        j = j + 1;
end;

bestFeat = featuresIndexes(1);
bestPerf = day_results_nf(1);

for j = 2:numFeat
    if(day_results_nf(j) < bestPerf)
        bestPerf = day_results_nf(j);
        bestFeat = featuresIndexes(j); %retrieving best feature index
    end
end;

fprintf('\nBest feature: %s with error = %0.3e\n', char(featuresLabels(bestFeat)), bestPerf);
end