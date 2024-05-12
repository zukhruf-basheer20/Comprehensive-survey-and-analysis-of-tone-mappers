clc;
clear all;
close all;
k=zeros(3,3,3);
for i=1:3
    k(:,:,i)=[1,2,3;4,5,6;7,8,9];
end
y=data_adjust(k,3,3);
y1=reconstruct_data(y(1,:),y(2,:),y(3,:),3,3);


function [y]=data_adjust(color_struct,m,n)

y=zeros(m*n,1,3);
y1=reshape(color_struct(:,:,1),[1,m*n]);
y2=reshape(color_struct(:,:,2),[1,m*n]);
y3=reshape(color_struct(:,:,3),[1,m*n]);

y=[y1;y2;y3];
end

function [clone]=reconstruct_data(y_p1,y_p2,y_p3,m,n)
clone=zeros(m,n,3);
clone(:,:,1)=reshape(y_p1,[m,n]);
clone(:,:,2)=reshape(y_p2,[m,n]);
clone(:,:,3)=reshape(y_p3,[m,n]);
end
