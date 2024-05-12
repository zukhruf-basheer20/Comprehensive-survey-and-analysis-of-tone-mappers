%hdr = double(hdrread('snowman.hdr'));
hdr = getpfmraw('doll_doll.pfm');
%imshow(hdr);

ldr = ATT_TMO(hdr);
figure; 
imshow(hdr);
imshow(ldr,'Border','tight');

