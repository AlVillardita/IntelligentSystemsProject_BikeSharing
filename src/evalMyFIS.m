function [ mse ] = evalMyFIS( fis, input, target )
%EvalMyFIS: computes the MSE given FIS, inputs and targets. A FIS must be
%created prior to call evalMyFIS using the "fuzzy" tool.

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

fis_output = evalfis(input, fis);
se = (fis_output - target).^2;

mse = sum(se) / numel(se);

end
