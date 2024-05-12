 hdr=single(hdrread('snowman.hdr'));
 imshow(hdr);
 %hdr=getpfmraw('church.pfm');
 
max_size=512;
hdr_comp=image_compress(hdr,max_size);
hdr_log=log_transform((hdr_comp));

hdr_log=hdr_log./max(max(hdr_log));
[m,n,l]=size(hdr_log);
figure;
imshow(hdr_log,'Border','tight');
a=3;
b=3;
stride=2;
w=0.8;
reconstruct_image=zeros(m,n,l);
count=zeros(m,n,l);

    for j=1:2:m-7
        
        for k=1:2:n-7
           
            patch=hdr_log(j:j+7,k:k+7,:);
            [patch_mean,color_struct,color_variation]=patch_decomposition(patch); 
            [pca_transform]=pcatransform(color_struct,a);
            m_b=adjust_cv(color_variation,b);
            patch_c=reconstruct(pca_transform,m_b,w,patch_mean);
            reconstruct_image(j:j+7,k:k+7,:)=reconstruct_image(j:j+7,k:k+7,:)+patch_c; 
            count(j:j+7,k:k+7,:)=count(j:j+7,k:k+7,:)+ones(8,8,3);
            
        end
        
    end

L_1=reconstruct_image./(count+eps);
L_out=L_1;
figure;
imshow(L_out,'Border','tight'); 
maxL=MaxQuart(L_out(:),0.99);
minL=MaxQuart(L_out(:),0.01);
L_out(L_out>maxL)=maxL;
L_out(L_out<minL)=minL;
C_out=mat2gray(L_out);
figure;
imshow(C_out,'Border','tight');

[q,q1,q2]=FSITM_TMQI(hdr_comp,C_out,3)
disp('TMQI','border','tight')
disp(q2)
disp('FSITM');
disp(q1)
disp('avg of both');
disp(q)
  
