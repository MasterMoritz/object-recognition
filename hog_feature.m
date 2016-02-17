%load images
%clear;
[airplane_images, car_images] = imageload();
image_count = size(airplane_images,3);

hog = hog_feature_vector (airplane_images(:,:,1));

airplane_features = zeros(image_count,size(hog,2)+1);
car_features = zeros(image_count,size(hog,2)+1);

airplane_features(1,:) = cat(2,hog,1);
car_features(1,:) = cat(2,hog_feature_vector (car_images(:,:,1)),-1);

for i=2:image_count
    airplane_features(i,:) = cat(2,hog_feature_vector (airplane_images(:,:,i)),1);
    car_features(i,:) = cat(2,hog_feature_vector (car_images(:,:,i)),-1);
end

data = cat(1,airplane_features, car_features);
ControlData = data(1:2:end,:);
TrainData = data(2:2:end,:);
dlmwrite('trainData_hog.txt',TrainData);
dlmwrite('testData_hog.txt',ControlData);