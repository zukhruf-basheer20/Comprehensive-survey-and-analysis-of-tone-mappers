function [y]=image_compress(hdr,maxsize)

if(max(size(hdr))>maxsize)
    ratio=(max(size(hdr)))/maxsize;
    y=imresize(hdr,1/ratio,'bilinear');
else
    y=hdr
end
