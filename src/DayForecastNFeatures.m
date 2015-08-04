function [ mse_values ] = DayForecastNFeatures (dataset, target, features, delays, hiddenLayerSize, data_day_labels)
% Day_ForecastingNFeatures.m: computes and plots the MSE of a forecast
% system in relation to different delays and to each subset of features
% on the given data set and target, with the specified set of fixed
% features and number of neurons. 
% The script finally returns a plot of all the features subsets in relation 
% to the different delay values 
%
% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]


NUM_IT = 30;

%data partitioning
inputSeries = dataset(1:365,:);
targetSeries = target(1:365);

num_features = numel(features);

fprintf('Training with %d features FIXED.\n', num_features);

mse_values = zeros(num_features,delays);

plot_legend = cell(num_features, 1);

selectedFeatures = [9 10 12];

k = 1; 
for i = 1:num_features
    fprintf('Training WEATHERSIT and TEMP with %s \n', char(data_day_labels(features(i))));
    for d = 1:delays
        temp = 0;
        for it_num = 1:NUM_IT
            temp = temp + NTSDay(inputSeries(:,[features(i) selectedFeatures]), targetSeries, 1:d, hiddenLayerSize);
        end;
        mse_values(k, d) = temp / NUM_IT;
    end
    plot_legend{k} = strcat('weather-temp + ',char(data_day_labels(features(i))));
    k = k + 1;
end;


color_map = hsv(num_features);

hold on;
for i = 1:num_features
    plot(1:delays,mse_values(i,:), 'color', color_map(i, :));
end
legend(plot_legend);
hold off;

end