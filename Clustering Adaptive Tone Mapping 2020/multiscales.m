clc;
clear all;
close all;

 hdr=single(hdrread('11.hdr'));
 figure;
 imshow(hdr);
 max_size=512;
 hdr_comp=image_compress(hdr,max_size);
hdr_log=log_transform((hdr_comp));
figure;
imshow(hdr_log);
hdr_log=hdr_log./max(max(hdr_log));
[m,n,l]=size(hdr_log);
a=6;
b=4;
stride=2;
w=0.8;
reconstruct_image=zeros(m,n,l);
count=zeros(m,n,l);

pm=ones((m-4)/2,(n-4)/2);
x=1;
y=1;
for j=1:2:m-7+1
    y=1; 
     for k=1:2:n-7+1
         patch=hdr_log(j:j+7,k:k+7,:);
         patch_mean=pmean(patch);
         pm(x,y)=patch_mean;
         y=y+1;
     end
     x=x+1;
end



imshow(pm);
[q1,q2]=size(pm);
c=zeros(q1,q2);
pm_c=zeros(q1,q2);
for j=1:2:q1-7+1
    for k=1:2:q2-7+1
        p_1=pm(j:j+7,k:k+7,:);
        [p2,color_struct]=patch_decomp(p_1);
        [pca_transform]=pcatrans(color_struct,a);
        p_c=pca_transform+ones(8,8)*p2*w;
        pm_c(j:j+7,k:k+7,:)=pm_c(j:j+7,k:k+7,:)+p_c;
        c(j:j+7,k:k+7,:)=c(j:j+7,k:k+7,:)+ones(8,8);
    end
end
p_mean=pm_c./c;

%  L_out1=p_mean;
% maxL1=MaxQuart(L_out1(:),0.99);
% minL1=MaxQuart(L_out1(:),0.01);
% L_out1(L_out1>maxL1)=maxL1;
% L_out1(L_out1<minL1)=minL1;
% p_mean=mat2gray(L_out1);
figure;
imshow(p_mean);

    
x=1;
    for j=1:2:m-7+1
        y=1;
        for k=1:2:n-7+1
            patch=hdr_log(j:j+7,k:k+7,:);
            [patch_mean,color_struct,color_variation]=patch_decomposition(patch); 
            [pca_transform]=pcatransform(color_struct,a);
            m_b=adjust_cv(color_variation,b);
            patch_c=reconstruct(pca_transform,m_b,w,p_mean(x,y));
            reconstruct_image(j:j+7,k:k+7,:)=reconstruct_image(j:j+7,k:k+7,:)+patch_c; 
            count(j:j+7,k:k+7,:)=count(j:j+7,k:k+7,:)+ones(8,8,3);
            y=y+1;
        end
        x=x+1;
    end

L_1=reconstruct_image./(count+eps);
L_out=L_1;
figure;
imshow(L_out); 
maxL=MaxQuart(L_out(:),0.99);
minL=MaxQuart(L_out(:),0.01);
L_out(L_out>maxL)=maxL;
L_out(L_out<minL)=minL;
C_out=mat2gray(L_out);
figure;
imshow(C_out);




 
  
