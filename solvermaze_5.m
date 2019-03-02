%%
%resim = 'result01.png';
resim = 'myMAZE.png';
res = thin(1,resim);
imshow(res)
tt=8000000;

res2=thin_saglamlastirma_3(res);
res=res2;


%%
bit_A=745;
bit_B=1322;
bas_A=32;
bas_B=31;

    %      k2
    %   k1  x k3
    %      k4
last_X=2; % baslangicta gitmemesini istedigin yondur


a=bas_A;
b=bas_B;
last=last_X; % gitmesni istemedigin yon, geldigi yola girmemesi icin, bu maze icin 2 ,cunku cozume baslad??g??nda ukar?? gitmemesi icin

yol=[a b 0 0 0 0]
nodus=[a b 0 0 0]
all_nodus=[0]
yonlerim=[0 0 0 0]
sahte=imread(resim);

a2=a;
b2=b;
last2=last;
yol2=yol;
nodus2=nodus;
all_nodus2=all_nodus;
yonlerim2=yonlerim;


for i=1:1:tt
    
if ~(a==bit_A && b==bit_B)    
[K,a,b,last,nodus,yol,yonlerim,all_nodus] = komsuluk_4_glsm_4(res,a,b,last,nodus,yol,yonlerim,all_nodus);
end

if ~(a2==bit_A && b2==bit_B)
[K2,a2,b2,last2,nodus2,yol2,yonlerim2,all_nodus2] = komsuluk_4_glsm_4_B(res2,a2,b2,last2,nodus2,yol2,yonlerim2,all_nodus2);
end

sahte(nodus2(end,1),nodus2(end,2),1)=0;
sahte(nodus2(end,1),nodus2(end,2),2)=255;
sahte(nodus2(end,1),nodus2(end,2),3)=0;

sahte(nodus(end,1),nodus(end,2),1)=255;
sahte(nodus(end,1),nodus(end,2),2)=0;
sahte(nodus(end,1),nodus(end,2),3)=0;

sahte(a2,b2,1)=255;
sahte(a2,b2,2)=0;
sahte(a2,b2,3)=0;

sahte(a,b,1)=0;
sahte(a,b,2)=0;
sahte(a,b,3)=255;


%nodus
%yol
%yonlerim

%all_nodus
if mod(i,500)==0

imshow(sahte)

end
if (a==bit_A && b==bit_B) && (a2==bit_A && b2==bit_B)
    tt=10000000
    break
end

end

imshow(sahte)




%%

close all
a=bas_A;
b=bas_B;
last=last_X;
sht=imread(resim);
dgm_sys=2;

a2=a;
b2=b;
last2=last;
dgm_sys2=dgm_sys;
   i=0;
   while ~((a == bit_A && b==bit_B) || (a2 == bit_A && b2==bit_B))
   
       [a,b,last,dgm_sys] = maze_sonuc(res,a,b,last,dgm_sys,yonlerim);
       
       
     
     sht(a,b,1)=255;
     sht(a,b,2)=0;
     sht(a,b,3)=0;
     
     [a2,b2,last2,dgm_sys2] = maze_sonuc2(res2,a2,b2,last2,dgm_sys2,yonlerim2);
     sht(a2,b2,1)=0;
     sht(a2,b2,2)=0;
     sht(a2,b2,3)=255;
     
    if mod(i,599)==0
     imshow(sht)
     end
     i=i+1;
       
   end
 %% kisa yol
   if size(yonlerim,1) < size(yonlerim2,1)
        yonlerim_X=yonlerim;
   else
       yonlerim_X=yonlerim2;
   end
 
 
   %%
a=bas_A;
b=bas_B;
a2=a;
b2=b
last=last_X;
sht=imread(resim);
dgm_sys=2;


   i=0;
   while ~((a == bit_A && b==bit_B) || (a2 == bit_A && b2==bit_B))
   
       [a,b,last,dgm_sys] = maze_sonuc(res,a,b,last,dgm_sys,yonlerim_X);
       
       
     
     sht(a,b,1)=255;
     sht(a,b,2)=0;
     sht(a,b,3)=0;
     
 
     if mod(i,1000)==0
     imshow(sht)
     end
     i=i+1;
       
   end
   
   %% gonderilecek veri
   
  sag_sol=[nodus(2:end,3) yonlerim(2:end,:)]
  
  donme=0;
  
  for i=1:1:size(sag_sol,1);
  if (sag_sol(i,1)==4 && sag_sol(i,2)==1) || (sag_sol(i,1)==2 && sag_sol(i,4)==1) || (sag_sol(i,1)==1 && sag_sol(i,3)==1) || (sag_sol(i,1)==3 && sag_sol(i,5)==1)
      
      donme=[donme;1]; % sol
  elseif (sag_sol(i,1)==1 && sag_sol(i,5)==1) || (sag_sol(i,1)==2 && sag_sol(i,2)==1) || (sag_sol(i,1)==3 && sag_sol(i,3)==1) || (sag_sol(i,1)==4 && sag_sol(i,4)==1)
     
      donme=[donme;2]; %sag
  else 
      donme=[donme;3]; % duz
  end
       
  end
      
  donme
   
   