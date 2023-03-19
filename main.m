clear all;% Erase all existing variables.
close all;% Close all figures (except those of imtool.)
clc; % Clear the command window. 

%Read car image
[ f, p ] = uigetfile ( '*.jpg' , 'Select the image file');  % GUI to choose image file
car = imread ( fullfile ( p, f) );			% Reading the image selected by the user
figure (1), imshow(car); title('Image in RGB colormap');
disp('Press any key'), pause


%Call to code that get car image and return the plate
get_car_return_plate;

%call to code that initialize the numbers
define_numbers;

%call to code that print the plate numbers and get in to txt file
get_plate_return_numbers;
