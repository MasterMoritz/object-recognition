%sift feature extraction
%load images
%clear;
[airplane_images, car_images] = imageload();
image_count = size(airplane_images,3);

num_features = 50;
airplane_features = zeros(image_count,4*num_features+1);
car_features = zeros(image_count,4*num_features+1);

for i=1:image_count
    [f,d] = vl_sift(single(airplane_images(:,:,i)));
    f = f(1:4,1:num_features);
    f = reshape(f,1,size(f,1)*size(f,2));
    airplane_features(i,:) = cat(2,f,1);
end
for i=1:image_count
    [f,d] = vl_sift(single(car_images(:,:,i)));
    f = f(1:4,1:num_features);
    f = reshape(f,1,size(f,1)*size(f,2));
    car_features(i,:) = cat(2,f,-1);
end

%shuffle histogram rows
rng('shuffle');
p=randperm(size(airplane_features,1));
data = cat(1,airplane_features(p,:), car_features(p,:));

%write half images as train data and the other half as test data
ControlData = data(1:2:end,:);
TrainData = data(2:2:end,:);
dlmwrite('trainData_sift.txt',TrainData);
dlmwrite('testData_sift.txt',ControlData);