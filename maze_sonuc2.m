function [a,b,last,dgm_sys] = maze_sonuc2(res,a,b,last,dgm_sys,yonlerim)


%sht=imread('myMAZE.png');
    %      k2

    %   k1  x k3
    %      k4
   
   i=0;
    k1 = res(a,b-1);
    if a-1>0         % en ustte başlıyosa 
    k2 = res(a-1,b); % a-1< 1 olacağından hata veerecek dolayısyla if islemi var
    else
        k2=0;
    end
    k3 = res(a,b+1);
    k4 = res(a+1,b);
    
    K = [k1 k2 k3 k4]
   
    dgm_yon=[0 0 0 0];
    
    if sum(K)>2
        
        dgm_yon = yonlerim(dgm_sys,:)
        dgm_sys=dgm_sys+1;
        
    end
        
     if ((k1==1 && last ~=1 ) || dgm_yon(1)==1) && sum(dgm_yon(2:1:end))==0
        
        last=3;
        new_a=a;
        new_b=b-1;
    elseif ((k2==1 && last ~=2) || dgm_yon(2)==1) && sum(dgm_yon(3:1:end))==0
        
        last=4;
        new_a=a-1;
        new_b=b;
    elseif ((k3==1 && last ~=3) || dgm_yon(3)==1) && sum(dgm_yon(4:1:end))==0
        
        last=1;
        new_a=a;
        new_b=b+1;
    elseif (k4==1 && last ~=4) || dgm_yon(4)==1 
        
        last=2;
        new_a=a+1;
        new_b=b;    
     end
     
     a=new_a;
     b=new_b;
        
   
end

