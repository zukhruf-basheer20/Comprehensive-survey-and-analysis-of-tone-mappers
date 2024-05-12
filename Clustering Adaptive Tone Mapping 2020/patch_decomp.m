function [m,color_struct]=patch_decomp(patch)
[k,n]=size(patch);
color_struct=zeros(k,n);
m=zeros(1,3);
m=mean(mean(patch));
color_struct=patch-ones(k,n).*m;
end