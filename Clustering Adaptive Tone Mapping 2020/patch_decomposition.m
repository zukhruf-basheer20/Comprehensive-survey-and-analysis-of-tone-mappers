function [patch_mean,color_struct,color_variation]=patch_decomposition(patch)


[k,n,l]=size(patch(:,:,:));
color_struct=zeros(k,n,l);
m=zeros(1,3);
for i=1:3
    m(i)=mean(mean(patch(:,:,i)));
    color_struct(:,:,i)=patch(:,:,i)-ones(k,n).*m(i);
end

mean_c=mean(m);
color_variation=m-ones(1,3).*mean_c;
patch_mean=mean_c;

    