function [y]=pcatransform(color_struct,a)
[m,n,l]=size(color_struct);
colordata_adjust=data_adjust(color_struct,m,n);
[pca_coefficients,mx]=pca(colordata_adjust);
y_p1=pca_coefficients(:,1)*colordata_adjust(1,:);
y_p1=0.8*1*(2/pi)*atan(a*y_p1);
y_p1x=pca_coefficients(:,1)'*y_p1;
y_p2=pca_coefficients(:,1)*colordata_adjust(2,:);
y_p2=(1.6/pi).*atan(a.*y_p2);
y_p2x=pca_coefficients(:,1)'*y_p2;
y_p3=pca_coefficients(:,1)*colordata_adjust(3,:);
y_p3=(1.6/pi).*atan(a.*y_p3);
y_p3x=pca_coefficients(:,1)'*y_p3;

y=reconstruct_data(y_p1x,y_p2x,y_p3x,m,n);
end


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



