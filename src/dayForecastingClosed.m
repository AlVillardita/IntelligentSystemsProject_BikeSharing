function [ net, mse ] = dayForecastingClosed (dataset, target, selectedFeatures, delays, hiddenLayerSize, numIt, daysAhead)
% dayForecastingClosed.m: computes and plots the MSE of a forecasting
% system in relation to the given setup (delays, hidden layer size, features),
% data set and target. 
% The script finally returns a plot of all the MSEs in relation to the
% different forecasts.
%
% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

%data setting
inputSeries = dataset(:,selectedFeatures);
targetSeries = target(:);

numDaysAhead = numel(daysAhead);

% Here, when numIt > 1, a new NTS system is created and evaluated, so that
% a MSE can be computed in order to have a rough idea of the prediction
% errors coming from a specific setup of the system.
errors = zeros(numDaysAhead,numIt);
for i = 1:numIt
    [errors(:,i), results, net] = ntsDayClosed(inputSeries, targetSeries, 1:delays, hiddenLayerSize, daysAhead);
end

mse = zeros(numDaysAhead,1);

for i = 1:numDaysAhead
    mse(i,1) = mean(errors(i, :));
end

figure;
plot(daysAhead, mse, 'r', daysAhead, results,'b');
end