function[patch_mean]=pmean(patch)
m=zeros(1,3);
for i=1:3
    m(i)=mean(mean(patch(:,:,i)));
end
patch_mean=mean(m);