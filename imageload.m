function [airplane_images, car_images] = imageload()

%paths to the images
airplane_path = './images/airplanes/';
car_path = './images/car_side/';

airplane_files = dir([airplane_path '*.jpg']);
car_files = dir([car_path '*.jpg']);

%size of resized images
rows = 159;
cols = 240;

%number of images that should be used (1 for testing purposes)
image_count = 122;

%load all images (resized,converted to grayscale and normalized contrast)
airplane_images = zeros(rows, cols, image_count, 'uint8');
car_images = zeros(rows, cols, image_count, 'uint8');

for i=1:image_count
    %load airplanes
    img = imread([airplane_path, airplane_files(i).name],'JPG');
    img = imresize(img, [rows cols]);
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    img = uint8((double(img)-double(min(min(img))))*(255/double(max(max(img))-min(min(img))))); % normalize contrast
    airplane_images(:,:,i) = img;
    
    %load cars
    img = imread([car_path, car_files(i).name],'JPG');
    img = imresize(img, [rows cols]);
    if size(img, 3) == 3
        img = rgb2gray(img);
    end
    img = uint8((double(img)-double(min(min(img))))*(255/double(max(max(img))-min(min(img))))); % normalize contrast
    car_images(:,:,i) = img;
end