
%RGB to HSV
HSV_car=rgb2hsv(car);
figure(1), imshow(HSV_car); title("HSV image");
disp("press any key to continue"), pause

%Separation into HUE parts
H=HSV_car(:,:,1);%Getting HUE (colors scale) image
S=HSV_car(:,:,2);%Getting SATURATION image
V=HSV_car(:,:,3);%Getting VALUE image
figure(1), imshow(H); title("HUE in gray map");
disp("press any key to continue"), pause

%Segmentation in hsv to find the licence plate
assist=(H>0.05&H<0.15)& (S>0.5&S<0.9)&(V>0.4);
figure(1), imshow(assist); title("Segmentation image");
disp("press any key to continue"), pause


%filtering small objects
%removing all white pixel connctors with area less then 10000 pixels
assist=bwareaopen(assist, 10000);
figure(1), imshow(assist); title("Segmentation without small objects");
disp("press any key to continue"), pause

%calculate white objects properties
data = bwconncomp(assist);% Getting the data about all objects.
N_ob = data.NumObjects;% Getting of objects numbers.
prop = regionprops(assist,'All','Image')% Getting (calculation)of all objects properties

% Get size and location of object bounding box 
    BBX = prop.BoundingBox;
    X=BBX(3);   % Getting length of the bounding box.
    Y=BBX(4);   % Getting width of the bounding box.
% Get Angle between the x-axis and the major axis of the object(in degrees) 
    Teta=prop.Orientation; % Angle between the x-axis and the major axis of the object.
    car=imrotate(car,-Teta,"bilinear");
    assist=imrotate(assist,-Teta,"bilinear");
    prop = regionprops(assist,'All','Image');% Getting (calculation)of all objects properties
    % Get size and location of object bounding box 
    BBX = prop.BoundingBox;
   
 % Object cropping from image I according the bounding box  
    % Cropping the picture “plate” by the bounding borders of the object
  plate = imcrop(car, [BBX(1) BBX(2) BBX(3) BBX(4)]);
  figure (1), imshow(plate), title('DETECTED REGION of INTEREST ');  
 disp("press any key to continue"), pause

 
   


