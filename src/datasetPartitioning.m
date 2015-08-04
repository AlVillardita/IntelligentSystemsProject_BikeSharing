function [ anfis_day_tr, anfis_day_tst, anfis_day_chk ] = datasetPartitioning(dataset, p_tr, p_tst, p_chk, features)
% datasetPartitioning.m: divides the given data set into three subsets
% each one with a size proportional to its respective percentage. The
% 'features' input refers to the list of indexes that have to be used to
% select the columns for the final subsets.
% In order to have equal proportion of samples coming from the two years in
% the three data sets, the partitioning process is done twice, one for each
% year.
% Returns three matrices representing the training, testing and checking
% subsets.

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

[ idx_tr_1y, idx_tst_1y, idx_chk_1y ] = dividerand(numel(dataset(1:365,1)), p_tr, p_tst, p_chk);
[ idx_tr_2y, idx_tst_2y, idx_chk_2y ] = dividerand(numel(dataset(366:731,1)), p_tr, p_tst, p_chk);
anfis_day_tr = dataset([idx_tr_1y idx_tr_2y], features);
anfis_day_tst = dataset([idx_tst_1y idx_tst_2y], features);
anfis_day_chk = dataset([idx_chk_1y, idx_chk_2y], features);

end