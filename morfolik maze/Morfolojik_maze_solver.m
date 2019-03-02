clc;

close all;

clear all;

%Başlıkların 15 font boyunda olmasını istiyoruz.

fontSize = 15;

% Bulmacaların olduğu klasörün açılması ve içerisindeki bulmacaların

% listelenmesi

depo = 'C:\Maze';

if ~exist(depo, 'dir')

% Bu klasörde dosyalar yoksa başka klasörlere bakılır.

depo = pwd;

end

%Bu bölümde dosyanın yüklenmesini, kontrol ediyoruz. Eğer "İPTAL" tuşuna basılırsa

%Program işleyişini sürdürmecek ve duracaktır.

bulmaca = true;

mesaj = sprintf('Lütfen Bulmacanızı seçin.\nBu programla labirent çözümü yapılacaktır.');

button = questdlg(mesaj, 'BULMACA ÇÖZÜMÜ', 'TAMAM', 'İPTAL', 'TAMAM');

if strcmpi(button, 'İPTAL')

bulmaca = false;

end

while bulmaca

% Yüklemek istediğimiz dosyaların tamamını listede göreceğiz.

dosya = fullfile(depo, '*.*');

[secilendosya, folder] = uigetfile(dosya, 'LÜTFEN BULMACA DOSYASINI SEÇİNİZ.. ');

%Eğer kullanıcı dosyayı yüklemekten vazgeçerse, programı keserek çıkış yapmak için aşağıdaki komut kullanılmıştır.

if secilendosya == 0

return;

end

%Seçilen dosyanın "dosyaismi" olarak belirtilmesini yapıyoruz.

dosyaismi = fullfile(folder, secilendosya);

% Bu bölümde seçilen dosyanın yüklenmesini yapıyoruz....

orjinalgoruntu = imread(dosyaismi);

%Resmi renk bandlarına ayırıyoruz.

[rows cols renknumara] = size(orjinalgoruntu);

% Resmi işlemek için tek renge dönüştürüyoruz.

if renknumara > 1

% Resmi tek renge dönüştürme işlemi

kirmiziduzlem = orjinalgoruntu(:, :, 1);

yesilduzlem = orjinalgoruntu(:, :, 2);

maviduzlem = orjinalgoruntu(:, :, 3);

% Resmin herbir matrisinin standart sapması ve her bir renk kanalının bularak matris değerlerini tekrar oluşturacağız..

kirmizistandartsapma = std(single(kirmiziduzlem(:)));

yesilstandartsapma = std(single(yesilduzlem(:)));

mavistandartsapma = std(single(maviduzlem(:)));

%Değerleri tek renkli değerlere indirgiyoruz. Burada matrislerden gelen değerleri 0 ile 1 arası değerlere dönüştürüyoruz..

if kirmizistandartsapma >= yesilstandartsapma && kirmizistandartsapma >= mavistandartsapma

%Kırmızı rengin binary renge dönüştürülmesi

sbresim = single(kirmiziduzlem);

elseif yesilstandartsapma >= kirmizistandartsapma && yesilstandartsapma >= mavistandartsapma

%Yeşil rengin binary renge dönüştürülmesi

sbresim = single(yesilduzlem);

else

%Mavi rengin binary renge dönüştürülmesi

sbresim = single(maviduzlem);

end

else

sbresim = single(orjinalgoruntu);

end

%Bütün bunların sonucunda labirenti bulmak için tek renkli bir resmimiz

%var, şimdi bunları göntüleyelim.

%Tüm pencereleri kapatıyoruz.

close all;

subplot(2, 2, 1);

imshow(sbresim, []);

title('Resmimiz', 'FontSize', fontSize);

set(gcf, 'Position', get(0,'Screensize'));

% Resmi 0-255 arası ölçeklendiriyoruz.

enbuyukdeger = max(max(sbresim));

enkucukdeger = min(min(sbresim));

sbresim = uint8(255 * (single(sbresim) - enkucukdeger) / (enbuyukdeger - enkucukdeger));

% Duvarları keskinleştiriyoruz. Bu işlem duvarların keskinliğinide artıracaktır.

renkderinligi = uint8((enbuyukdeger + enkucukdeger) / 2);

ikilideger = 255 * (sbresim < renkderinligi);

% Şimdi bu adımın sonuçlarına bir bakalım

subplot(2, 2, 2);

imshow(ikilideger, []);

title('Siyah beyaz resim - Duvarlar siyah yerine beyazdir..', 'FontSize', fontSize);

%Resmi daha iyi tanımlamak için verilen değerlere göre resmi tanımlayalım.

%Herbir program bloğunu etiketleyerek ölçümler yapabiliriz.

[resimismi duvarnumarasi] = bwlabel(ikilideger, 4);

%Renk etiketleri

renklietiket = label2rgb (resimismi, 'hsv', 'k', 'shuffle');

%Yapmış olduğumuz işlemin sonucu aşağıdaki gibidir.

subplot(2, 2, 3);

imshow(renklietiket);

caption = sprintf('Duvar ve Zeminin Farkli Renkleri', duvarnumarasi);

title(caption, 'FontSize', fontSize);

if duvarnumarasi ~= 2

message = sprintf('Burada Resmimizin Duvarları var gibi gözüküyor, Çözümde sıkıntılar yaşanabilir.', duvarnumarasi);

uiwait(msgbox(message));

end

%Mükemmel sonuç almak için sadece bir duvar alınabilir.

sbresim2 = (resimismi == 1);

subplot(2, 2, 4);

imshow(sbresim2, []);

title('Duvarlardan biri', 'FontSize', fontSize);

%Duvarların genişliklerini açalım.

deletionmiktari = 7;

%Resme Erosion ve Dilation özelliklerini verme

deletionresim = imdilate(sbresim2, ones(deletionmiktari));

%Elde edilen resimlerin görüntülenmesi

figure;

set(gcf, 'Position', get(0,'Screensize'));

subplot(2, 2, 1);

imshow(deletionresim, []);

title('Kabartmali Duvar (Dilation)', 'FontSize', fontSize);

doldurulmusresim = imfill(deletionresim, 'holes');

subplot(2, 2, 2);

imshow(doldurulmusresim, []);

title(' Deliklerin doldurulmasi', 'FontSize', fontSize);

erozyonresim = imerode(doldurulmusresim, ones(deletionmiktari));

subplot(2, 2, 3);

imshow(erozyonresim, []);

title('Asinmis hali', 'FontSize', fontSize);

% Farkı bulmak için aşınmış parçayı sıfıra ayarlayın.Ayrıca, dilate edilmiş görüntüyü de çıkartabilirsiniz.

solution = doldurulmusresim;

solution(erozyonresim) = 0;

subplot(2, 2, 4);

imshow(solution, []);

title('Fark - Çözüm', 'FontSize', fontSize);

% Şimdi çözümü orjinal görüntünün üzerine koyalım.

if renknumara == 1

% Eğer tek renkliyse, renk düzlemlerini yapmalıyız.

% Eğer biz renkteysek, bunu zaten yukarıdan yapıyoruz.

kirmiziduzlem = sbresim;

yesilduzlem = sbresim;

maviduzlem = sbresim;

end

kirmiziduzlem(solution) = 255;

yesilduzlem(solution) = 0;

maviduzlem(solution) = 0;

solvedImage = cat(3, kirmiziduzlem, yesilduzlem, maviduzlem);

figure;

imshow(solvedImage);

set(gcf, 'Position', get(0,'Screensize'));

title('Orijinal Görüntü Hakkinda Son Çözüm', 'FontSize', fontSize);

mesaj = sprintf('Başka bir labirent çözmek ister misin?');

button = questdlg(mesaj, 'BULMACA ÇÖZÜMÜ', 'EVET', 'HAYIR', 'HAYIR');

if strcmpi(button, 'HAYIR')

bulmaca = false;

end

end