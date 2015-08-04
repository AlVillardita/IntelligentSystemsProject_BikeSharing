function performance = fitFeatureSize( input, target, hiddenLayerSize )
% fitFeatureSize.m: Create a NN for the given input and target with the
% specified hidden layer size. Returns the MSE computed with the test set.

% @Authors: Alessio Villardita [villardita.alessio@gmail.com]
%           Sara Egidi [egidi.sara@gmail.com]

inputs = input';
targets = target';

% Create a Fitting Network
net = fitnet(hiddenLayerSize);

% Setup Division of Data for Training, Validation, Testing
net.divideParam.trainRatio = 70/100;
net.divideParam.valRatio = 15/100;
net.divideParam.testRatio = 15/100;

% Train the Network
[net,tr] = train(net,inputs,targets);

% Test the Network
outputs = net(inputs);
% errors = gsubtract(targets,outputs);
performance = perform(net,targets,outputs);
end
