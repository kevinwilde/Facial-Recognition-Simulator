function [image] = readImage(imgName)

image=imread(imgName);
if ndims(image) > 2
    image=rgb2gray(image);
end

image = im2double(image);

end

