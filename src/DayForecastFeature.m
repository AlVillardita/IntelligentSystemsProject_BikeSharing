function [ mse_values ] = DayForecastFeature (dataset, target, features, delays, hiddenLayerSize, data_day_labels)
% DayForecastFeature: computes the mse values of different nets, each with 
% a different feature as input. Esch of those networks is evaluated with
% different delay, and their MSE is stored in a vector. Plots the averaged
% (over a number of iterations defined as a constant inside the script)
% MSE values of each feature for each delay within the limit.
%
% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

NUM_IT = 30;

%Data setup
inputSeries = dataset(1:365,:);
targetSeries = target(1:365);

num_features = numel(features);

fprintf('Training with %d features FIXED.\n', num_features);

mse_values = zeros(num_features,delays);

% iterate for each feature
for j = 1:num_features
    fprintf('Training with %s.\n', char(data_day_labels(features(j))));
    for i = 1:delays
        temp = 0;
        for it = 1:NUM_IT
            temp = temp + NTSDay(inputSeries(:,features(j)), targetSeries, 1:i, hiddenLayerSize);
        end
        mse_values(j, i) = temp / NUM_IT;
    end
end

% plot with different colours
plot_legend = cell(num_features, 1);
color_map = hsv(num_features);
clf;
hold on;
for i = 1:num_features
    plot(1:delays,mse_values(i,:), 'color', color_map(i, :));
    plot_legend{i} = char(data_day_labels(features(i)));
end
legend(plot_legend);
hold off;

end