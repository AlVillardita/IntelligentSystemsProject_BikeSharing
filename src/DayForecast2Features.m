function [ mse_values ] = DayForecast2Features (dataset, target, features, delays, hiddenLayerSize, data_day_labels)
% DayForecast2Features.m: computes and plots the MSE of a forecast
% system in relation to different delays and to all the possible pairs of features.
% The number of neurons is fixed. 
% The number of iterations is defined in the script and it stands for the
% number of times the mse will be calculated for the same settings.
% The overall MSE for each layer size is then calculated taking the
% averages of the multiple runs.
% The script finally returns a plot of all the features pairs in relation to the
% different delay values 

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

NUM_IT = 30;

%data setup
inputSeries = dataset(1:365,:);
targetSeries = target(1:365);

num_features = numel(features);
num_couples = (num_features-1)*num_features/2;

fprintf('Training with %d features FIXED.\n', num_features);

mse_values = zeros(num_couples,delays);

plot_legend = cell(num_couples, 1);

k = 1; 
for i = 1:num_features
    for j = i+1:num_features
        fprintf('Training with %s and %s.\n', char(data_day_labels(features(i))), char(data_day_labels(features(j))));
        for d = 1:delays
            temp = 0;
            for it_num = 1:NUM_IT
                temp = temp + NTSDay(inputSeries(:,[features(i) features(j)]), targetSeries, 1:d, hiddenLayerSize);
            end;
            mse_values(k, d) = temp / NUM_IT;
        end
        fprintf('%0.2f%% Features: (%s,%s)\n',(k * 100)/num_couples, char(data_day_labels(features(i))), char(data_day_labels(features(j))));
        plot_legend{k} = strcat(char(data_day_labels(features(i))),'-',char(data_day_labels(features(j))));
        k = k + 1;
    end;
end;

%plot with different colours
color_map = hsv(num_couples);

hold on;
for i = 1:num_couples
    plot(1:delays,mse_values(i,:), 'color', color_map(i, :));
end
legend(plot_legend);
hold off;

end