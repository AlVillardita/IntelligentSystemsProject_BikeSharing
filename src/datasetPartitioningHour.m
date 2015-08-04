function [ anfis_day_tr, anfis_day_tst, anfis_day_chk ] = datasetPartitioningHour(dataset, p_tr, p_tst, p_chk, features)
% datasetPartitioningHour.m: see "datasetPartitioning.m"; just row indeces
% change.

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

[ idx_tr_1y, idx_tst_1y, idx_chk_1y ] = dividerand(numel(dataset(1:8645,1)), p_tr, p_tst, p_chk);
[ idx_tr_2y, idx_tst_2y, idx_chk_2y ] = dividerand(numel(dataset(8646:17379,1)), p_tr, p_tst, p_chk);
anfis_day_tr = dataset([idx_tr_1y idx_tr_2y], features);
anfis_day_tst = dataset([idx_tst_1y idx_tst_2y], features);
anfis_day_chk = dataset([idx_chk_1y, idx_chk_2y], features);

end
