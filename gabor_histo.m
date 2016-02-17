%clear;
%gabor orientation increments in degrees
orientation_inc = 15;
num_angles = 360/orientation_inc;

%load images
[airplane_images, car_images] = imageload();
image_count = size(airplane_images,3);

%calculate histograms
%for each orientation save the number of pixels that have maximum intensity
%at that orientation
%last value indicates wheter image is airplane or car
airplane_histograms = zeros(image_count, num_angles+1);
car_histograms = zeros(image_count, num_angles+1);
airplane_energies = zeros(rows, cols, num_angles,'uint8');
car_energies = zeros(rows, cols, num_angles,'uint8');
orientation = pi/num_angles;

for j=1:image_count
    for i=1:num_angles
        [g_even, g_odd] = GaborD(15,10,10, i*orientation, 2,0,0); 
        
        conv_even = conv2(double(airplane_images(:,:,j)),g_even,'same');  % 2D convolution even
        conv_odd = conv2(double(airplane_images(:,:,j)),g_odd,'same'); % 2D convultion odd
        airplane_energies(:,:,i) = sqrt(conv_even.^2 + conv_odd.^2);
        conv_even = conv2(double(car_images(:,:,j)),g_even,'same');  % 2D convolution even
        conv_odd = conv2(double(car_images(:,:,j)),g_odd,'same'); % 2D convultion odd
        car_energies(:,:,i) = sqrt(conv_even.^2 + conv_odd.^2);
    end

    for y=1:rows
        for x=1:cols
            max_a_intensity = 0.0;
            max_a_angle = 1;
            max_c_intensity = 0.0;
            max_c_angle = 1;
            
            for a=1:num_angles
                a_intensity = airplane_energies(y,x,a);
                c_intensity = car_energies(y,x,a);
                if (a_intensity > max_a_intensity)
                    max_a_intensity = a_intensity;
                    max_a_angle = a;
                end
                if (c_intensity > max_c_intensity)
                    max_c_intensity = c_intensity;
                    max_c_angle = a;
                end                
            end
            airplane_histograms(j,max_a_angle) = airplane_histograms(j,max_a_angle) + 1;
            car_histograms(j,max_c_angle) = car_histograms(j,max_c_angle) + 1;
        end
    end
    airplane_histograms(j,num_angles+1) = 1;
    car_histograms(j,num_angles+1) = -1;
end

rng('shuffle');
p=randperm(size(airplane_histograms,1));
data = cat(1,airplane_histograms(p,:), car_histograms(p,:));
ControlData = data(1:2:end,:);
TrainData = data(2:2:end,:);
dlmwrite('trainData.txt',TrainData);
dlmwrite('testData.txt',ControlData);