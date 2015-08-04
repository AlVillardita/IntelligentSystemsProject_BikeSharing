function month_intervals = dataSetMonthIntervals( dataSet )
% dataSetMonthIntervals.m: explores the given dataset and for each month
% records its starting and ending index (i.e. the indexes corresponding to
% the recording order of the dataset). As result, all the indexes found
% will be used to apply sub-sampling over all the dataset, but on a monthly
% base.

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

%Sets dimension setting
data_set_size = numel(dataSet(:,1));

start_idx = 1;
end_idx = 1;
month = dataSet(1,5);

intervals = zeros(24, 2);
intervals_row_index = 1;

for row = 2:data_set_size
    row_month = dataSet(row,5);
    if (row_month == month)
        end_idx = end_idx + 1;
    else
        if( row_month == 1 || row_month == (month + 1))
            month = row_month;
        else
            fprintf('Unexpected error: end index = %0.0f\n', end_idx);
        end
        % saving start and end indexes
        intervals(intervals_row_index, 1) = start_idx;
        intervals(intervals_row_index, 2) = end_idx;
        intervals_row_index = intervals_row_index + 1;
        % resetting indexes
        start_idx = end_idx + 1;
        end_idx = start_idx;
    end
end

intervals(intervals_row_index, 1) = start_idx;
intervals(intervals_row_index, 2) = end_idx;

month_intervals = intervals;
end

