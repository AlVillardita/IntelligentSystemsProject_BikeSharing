function [ predictionErrors, results, net ] = ntsDayClosed (inputSeriesTotal, targetSeriesTotal, inputDelays, hiddenLayerSize, daysAhead)
% ntsDayClosed.m: computes and plots the MSE of a forecasting
% system in relation to the given setup (delays, hidden layer size, features),
% data set and target. 
% The script finally returns a plot of the forecasted values for the 2nd year
% and the real measured values of the same year, all the MSEs in relation to the
% different forecasts computed in two ways: predictionErrors contains the
% forecasting errors computed on the first days of January 2012, results
% contains the forecasting MSEs computed on 30 dates sampled at random.
%
% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]


inputSeries = tonndata(inputSeriesTotal(1:365,:),false,false);
targetSeries = tonndata(targetSeriesTotal(1:365),false,false);

inputSeriesClosed = tonndata(inputSeriesTotal(366:731,:),false,false);
targetSeriesClosed = tonndata(targetSeriesTotal(366:731),false,false);

feedbackDelays = inputDelays;
net = narxnet(inputDelays,feedbackDelays,hiddenLayerSize);

[inputs,inputStates,layerStates,targets] = preparets(net,inputSeries,{},targetSeries);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,inputs,targets,inputStates,layerStates);

% Closed Loop Network
% Use this network to do multi-step prediction.

netc = closeloop(net);
netc.name = [net.name ' - Closed Loop'];
%view(netc);
[xc,xic,aic,tc] = preparets(netc,inputSeriesClosed,{},targetSeriesClosed);
yc = netc(xc,xic,aic);

TS = size(tc,2);
outputClosed = cell2mat(yc);
outputTarget = cell2mat(tc);
plot(1:TS,outputTarget,'b',1:TS,outputClosed,'r')

% computing prediction squared errors for the first days of January 2012
 predictionErrors = zeros(numel(daysAhead),1);
j = 1;
for i = daysAhead
    predictionErrors(j,1) = (outputClosed(i) - outputTarget(i))^2;
    j = j + 1;
end

% Computing forecasts and errors by sampling 30 dates at random
delay = max(inputDelays);
maxForecast = max(daysAhead);
dates = datasample((366:(731-maxForecast))', 30, 1, 'Replace', false); % indeces

% Column vector with MSEs, one for each of the forecasts requested
 results = zeros(numel(daysAhead),1);
for j = 1:numel(daysAhead)
    sum = 0;
    for i = 1:30
        inputSeriesClosed = tonndata(inputSeriesTotal((dates(i)-delay):(dates(i)+daysAhead(j)-1),:),false,false);
        targetSeriesClosed = tonndata(targetSeriesTotal((dates(i)-delay):(dates(i)+daysAhead(j)-1)),false,false);
        [xc,xic,aic,tc] = preparets(netc,inputSeriesClosed,{},targetSeriesClosed);
        yc = netc(xc,xic,aic);
        outputClosed = cell2mat(yc);
        outputTarget = cell2mat(tc);
       
        % interested in the last element, the only interesting forecast
        sum = sum + (outputClosed(daysAhead(j)) - outputTarget(daysAhead(j)))^2;
    end
    results(j,1) = sum/30;
end
end