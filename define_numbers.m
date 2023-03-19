%Number defination
one=imread("1.png");  two=imread("2.png");
three=imread("3.png");four=imread("4.png");
five=imread("5.png"); six=imread("6.png");
seven=imread("7.png");eight=imread("8_.png");
nine=imread("9.png"); zero=imread("0.png");

%Multidimensional Arrays
nums={[one] [two] [three] [four] [five] [six] [seven] [eight] [nine] [zero]};

%Numbers in gray level 
for i=1:10
    nums{i}=im2gray(nums{i});
    nums{i}=imadjust(nums{i});%white and black only
    nums{i}=(nums{i}<100);%flip white to black and black to white
end;







