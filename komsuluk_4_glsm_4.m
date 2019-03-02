function [K,new_a,new_b,last,nodus,yol,yonlerim,all_nodus] = komsuluk_4_glsm_4(src,a,b,last,nodus,yol,yonlerim,all_nodus)

    %      k2
    %   k1  x k3
    %      k4
   
    k1 = src(a,b-1);
    if a-1>0         % en ustte başlıyosa 
    k2 = src(a-1,b); % a-1< 1 olacağından hata veerecek dolayısyla if islemi var
    else
        k2=0;
    end
    k3 = src(a,b+1);
    k4 = src(a+1,b);
    
    K = [k1 k2 k3 k4];
    
    
    
     flag=0; 
     cikmaz_yol=0;
     flg_any=0;
    yon=[0 0 0 0];
    if sum(K)<2  || any(all_nodus==a*10000+b)        % tek yol var ise ki oda geldigi yol oluyor
        a = nodus(end,1); % dolayisiyla onceki dogume doner
        b = nodus(end,2);
        yon = yol(end,3:6); % en son bu dugumdeyken hangi yone gittigini hatirla ve gitme
        last=nodus(end,3); % onceden gittigi yonlerin bilgisidir
        nodus(end,5)=nodus(end,5)+1;
        yonlerim=yonlerim(1:end-1,:);
        cikmaz_yol=1;
        flg_any=1;
        
        while nodus(end,5)>nodus(end,4)
              nodus=nodus(1:end-1,:);
              yol=yol(1:end-1,:);
              yonlerim=yonlerim(1:end-1,:);
              nodus(end,5)=nodus(end,5)+1;
              a = nodus(end,1); % dolayisiyla onceki dogume doner
              b = nodus(end,2);
              yon = yol(end,3:6);
              last=nodus(end,3);
        end
        k1 = src(a,b-1);   % yeni geldigin dogumde yeni k degerlerini al
        k2 = src(a-1,b);
        k3 = src(a,b+1);
        k4 = src(a+1,b);
    end
    
    
    if sum(K) >2  && flg_any==0               % 2 dene (biri geldigi yol) cok yol var
        nodus = [nodus;a b last sum(K)-1 1]; % sum(k)-1 cunku bitanesi 
        all_nodus = [all_nodus;a*10000+b];
        cikmaz_yol=1;                        %geldigi yoldur, 1 --> o
                                              %dugume birdefa girdigi
                                              %bilgisidir
        flag=1;                  % dugumden sonraki gittigi noktayi kaydet
    end
    
    % last ve yon arasındaki fark
    % last --> mesela 1 yonune gitmissem yeni gittigin noktada geldigim yer
    % 3 yonu olarak gorulur, dolayisiyla geri gitmemi engelleyen seydir
    % yon her dongude 0'a esitlenir ama olurda cıkmaz yola girerse onceki
    % dogume geri doner ve o dogume nerden geldiginin bilgisini tutar yani
    % geri gitmesini engeller
    if k1==1 && last ~=1 && yon(1)~=1 % yon~=1 kafani karistirmasi surekli sifirlaniyor
        
        yon=[1 0 0 0];
        last=3;
        new_a=a;
        new_b=b-1;
    elseif k2==1 && last ~=2 && yon(2)~=1
        yon=[0 1 0 0];
        last=4;
        new_a=a-1;
        new_b=b;
    elseif k3==1 && last ~=3 && yon(3)~=1
        yon=[0 0 1 0];
        last=1;
        new_a=a;
        new_b=b+1;
    elseif k4==1 && last ~=4 && yon(4)~=1
        yon=[0 0 0 1];
        last=2;
        new_a=a+1;
        new_b=b;    
    end
  
    
    if cikmaz_yol==1
        yonlerim=[yonlerim; yon];
    end
    if nodus(end,4)==3 && nodus(end,5)==2 && a==nodus(end,1) && b==nodus(end,2) % 4 yol oldugunda birlestir
        yol(end,3:6)= yol(end,3:6) | yon;
     %  yonlerim(end,:)=yonlerim(end-1,:);
     %  yonlerim=yonlerim(1:end-1,:);
    end
    
    if flag==1
    yol = [yol;new_a new_b yon]; % yon son dugumden hangi yone gittigidir, son dugume hangi yonden geldigidir
    end
    
end

