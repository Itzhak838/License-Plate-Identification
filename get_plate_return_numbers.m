
%processing the image
plate_workon=im2gray(plate);
plate_workon = imadjust(plate_workon);
plate_workon = (plate_workon<100); 

%Filters components that are less than 1000 pixels from the image
plate_workon = bwareaopen(plate_workon,1000);
%get properties of the plate image
prop_plate=regionprops(plate_workon,'all','image');
%get the num of objects from image
bw=bwconncomp(plate_workon);
numobj=bw.NumObjects;

%defination of assist arrays and multidimensional arrays 
plate_idx=[];
someSame=[];
num_of_plate={};
count=1;
%the for loop run all the objects (including the plate), crop, and compare
%to known objects (the numbers)
for i=1:numobj
    obj=prop_plate(i).BoundingBox;
    num=imcrop(plate_workon, [obj(1) obj(2) obj(3) obj(4)]);
    %calculate correlation to nums
    for j=1:10
        num=imresize(num,size(nums{j}));
        someSame(j)=max(max(abs(normxcorr2(num,nums{j}))));
    end
    
    %the index number is the number that we want
    %bigger from 1 because 1 is corr with the plate
    %we dont care from M because M is the value of corr and we use in max
    %function
    if i>1
    [M,plate_idx(i-1)]=max(someSame);
    
    end
end

%if idx=10 change to 0, by nums defination
for i=1:size(plate_idx,2)
    if plate_idx(i)==10
        plate_idx(i)=0;
    end
end

%show the numbers in command window
disp("the plate numbers is: ");
disp(plate_idx);

%write to txt file
a='the plate numbers is: ';
fileID = fopen('plate_numbers.txt','w');
fprintf(fileID,'%s\n',a);
fprintf(fileID,'%d ',plate_idx);
fclose(fileID);




















