/*
SELECT - LIKE kosulu
LIKE : Sorgulama yaparken belirli kalip ifadeleri kullanabilmemizi saglar
ILIKE : Sorgulama yaparken buyuk/kucuk harfe duyarsiz olarak eslestir
LIKE : ~~
ILIKE : ~~*
NOT LIKE : !~~
NOT ILIKE : !~~*

% --> 0 VEYA DAHA FAZLA KARAKTERI BELIRTIR
_ --> Tek bir karakteri belirtir.
*/

--Ismi A harfi ile baslayan personeli listele.
select * from personel where isim like 'A%';

--Ismi T harfi ile biten personeli listele.
select * from personel where isim like '%t';

--Isminin ikinci harfi 'e' olan personeli listeleyiniz.
select * from personel where isim like '_e%';

-- 'a' ile başlayıp 'n' ile biten personel isimlerini listeleyiniz
select * from personel where isim ~~* 'a%n';

-- ikinci karakteri 'a' ve dördüncü karakteri 'u' olan personel isimlerini listeleyiniz
select * from personel where isim ~~* '_a_u%';

-- İçinde 'e' ve 'r' bulunan personel isimlerini listeleyiniz
select * from personel where isim ~~* '%e%r%';
select isim from personel where isim ~~* '%e%' and isim ~~* '%r%';

-- 2. harfi e olup diğer harflerinde y olan personeli listeleyiniz
select * from personel where isim ~~* '_e%' and isim ~~* '%y%';

-- a harfi olmayan personeli listeleyin
select * from personel where isim !~~* '%a%';

-- 1. harfi A ve 7. harfi a olan personeli listeleyin
select * from personel where isim ~~ 'A_____a%';

--Sondan ikinci karakteri 'r' olan "isim" değerlerini listeleyiniz.
select * from personel where isim ~~* '%r_';

