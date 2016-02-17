% Step1: reading Data from the file
file_data1 = load('trainData_sift.txt');
file_data2 = load('testData_sift.txt');
TrainData = file_data1(:,1:end-1)';
TrainLabels = file_data1(:, end)';
ControlData = file_data2(:,1:end-1)';
ControlLabels = file_data2(:, end)';

MaxIter = 200; % boosting iterations

% Step2: constructing weak learner
weak_learner = tree_node_w(3); % pass the number of tree splits to the constructor

% Step3: initilize
RLearners = [];
RWeights = [];

% Step4: training real adaboost
[RLearners, RWeights] = RealAdaBoost(weak_learner, TrainData, TrainLabels, 1, RWeights, RLearners);

% Step5: evaluating on control set
ResultR = sign(Classify(RLearners, RWeights, ControlData));
%disp(ResultR);

% Step6: calculating error
ErrorR = sum(ControlLabels ~= ResultR);

% Step7: compare labels of test set to labels of step5
GaborResult = (ResultR == TrainLabels);
hit = 0;
for i = 1:numel(GaborResult)
    element = GaborResult(i);
    if element == 1
        hit = hit + 1;
    end
end

%display amount of images
disp(numel(GaborResult));
%display amount of hits
disp(hit);
%display successrate in percentages of our system
disp(hit/(numel(GaborResult)/100));