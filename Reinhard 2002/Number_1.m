%I = hdrread("doll_doll.hdr");
I = getpfmraw('doll_doll.pfm');
imshow(I);

%IR = cf_reinhard(I,I1);
IR = apply_reinhard_global_tonemap(I, 0.55);

figure;
imshow(IR,'Border','tight');