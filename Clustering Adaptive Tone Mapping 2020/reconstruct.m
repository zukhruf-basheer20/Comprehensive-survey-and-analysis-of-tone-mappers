function [y]= reconstruct(y_a,m_b,w,m)

y1=y_a(:,:,1)+m_b(1).*ones(8,8)+ones(8,8).*(w*m);
y2=y_a(:,:,2)+m_b(2).*ones(8,8)+ones(8,8).*(w*m);
y3=y_a(:,:,3)+m_b(3).*ones(8,8)+ones(8,8).*(w*m);

y=reconstruct_data(y1,y2,y3,8,8);
end

function [clone]=reconstruct_data(y_p1,y_p2,y_p3,m,n)
clone=zeros(m,n,3);
clone(:,:,1)=imresize(y_p1,[m,n]);
clone(:,:,2)=imresize(y_p2,[m,n]);
clone(:,:,3)=imresize(y_p3,[m,n]);
end
