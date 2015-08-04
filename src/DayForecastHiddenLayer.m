function [ mse_values ] = DayForecastHiddenLayer (dataset, target, delays, hiddenLayerSizeLimit)
% Day_ForecastingHiddenLayer.m: computes and plots the MSE of a forecast
% system in relation to different neuron numbers. The delays are fixed as
% well as the features are.
% The number of iterations is defined in the script and it stands for the
% number of times the MSE will be calculated for the same neuron number.
% The overall MSE for each layer size is then calculated taking the
% averages of the multiple runs.
%
% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

NUM_IT = 30;

%data partitioning
inputSeries = dataset(1:365,:);
targetSeries = target(1:365);

mse_values = zeros(hiddenLayerSizeLimit,1);

selectedFeatures = [7 9 10 12];

for i = 1:hiddenLayerSizeLimit
    temp = 0;
    for it_num = 1:NUM_IT
        temp = temp + NTSDay(inputSeries(:, selectedFeatures), targetSeries, 1:delays, i);
    end;
    mse_values(i) = temp / NUM_IT;
end

plot(mse_values);

end