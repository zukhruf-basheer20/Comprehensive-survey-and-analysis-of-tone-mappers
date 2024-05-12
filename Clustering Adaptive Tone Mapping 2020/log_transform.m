function [y]=log_transform(input_image)

y=input_image;
for c=1:3
    y(:,:,c)=log(input_image(:,:,c)*10^6+1);
end
