function [res_2] = thin_saglamlastirma_3(res)

[r,c] = size(res);
    
res_2=res;
for i=2:1:r-1  
    for j=2:1:c-1
        if res_2(i,j)==1
             k1 = res_2(i,j-1);
             k2 = res_2(i-1,j); 
             k3 = res_2(i,j+1);
             k4 = res_2(i+1,j);
             K = [k1 k2 k3 k4];
             
             ka = res_2(i-1,j-1);
             kb = res_2(i-1,j+1); 
             kc = res_2(i+1,j+1);
             kd = res_2(i+1,j-1);
             K2 = [ka kb kc kd];
             
             kx = [k1 kd k4 kc k3];
             %   ka k2 kb
             %   k1  x k3
             %   kd k4 kc
             
             if kx == [0 1 0 0 0] 
                 res_2(i+1,j)=1; % k4 =1
                 
             elseif kx == [0 0 0 1 0] 
                 res_2(i+1,j)=1; % k4 =1    
             
             elseif kx == [0 1 0 1 0]
                 res_2(i+1,j)=1; % k4 =1
             
             elseif kx == [0 1 0 1 1]
                 res_2(i,j-1)=1; % k1 =1
             
             elseif kx == [1 1 0 1 0]
                 res_2(i,j+1)=1; % k3 =1
                 
             elseif kx == [1 0 0 1 0]
                 res_2(i+1,j)=1; % k4 =1 
            
             elseif kx == [0 1 0 0 1]
                 res_2(i+1,j)=1; % k4 =1 
             end
             
        end
    end
%end
%figure
%subplot(1,2,1)
%imshow(res)
%subplot(1,2,2)
%imshow(res_2)



end
end
