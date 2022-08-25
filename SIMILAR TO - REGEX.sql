--SELECT - SIMILAR TO - REGEX(Regular Expressions) --
/*
SIMILAR TO : Daha karmasik pattern(kalip) ile sorgulama ilemi icin SIMILAR TO kullanilabilir.
Sadece PostgreSQL de kullanilir. Buyuk kucuk harf onemlidir.

REGEX : Herhangi bir kod, metin icerisinde istenen yazi veya kod parcasinin arayip bulunmasin saglayan
kendine ait bir soz dizimi olan bir yapidir.MySQL de (REGEXP_LIKE) olarak kullanilir.
PostgreSQL'de "~" karakteri ile kullanilir.
*/

CREATE TABLE kelimeler
(
id int,
kelime VARCHAR(50),
harf_sayisi int
);

INSERT INTO kelimeler VALUES (1001, 'hot', 3);
INSERT INTO kelimeler VALUES (1002, 'hat', 3);
INSERT INTO kelimeler VALUES (1003, 'hit', 3);
INSERT INTO kelimeler VALUES (1004, 'hbt', 3);
INSERT INTO kelimeler VALUES (1005, 'hct', 3);
INSERT INTO kelimeler VALUES (1006, 'adem', 4);
INSERT INTO kelimeler VALUES (1007, 'selim', 5);
INSERT INTO kelimeler VALUES (1008, 'yusuf', 5);
INSERT INTO kelimeler VALUES (1009, 'hip', 3);
INSERT INTO kelimeler VALUES (1010, 'HOT', 3);
INSERT INTO kelimeler VALUES (1011, 'hOt', 3);
INSERT INTO kelimeler VALUES (1012, 'h9t', 3);
INSERT INTO kelimeler VALUES (1013, 'hoot', 4);
INSERT INTO kelimeler VALUES (1014, 'haaat', 5);
INSERT INTO kelimeler VALUES (1015, 'hooooot', 5);
INSERT INTO kelimeler VALUES (1016, 'booooot', 5);
INSERT INTO kelimeler VALUES (1017, 'bolooot', 5);

select * from kelimeler;

--  İçerisinde 'ot' veya 'at' bulunan kelimeleri listeleyiniz
--Veya islemi icin | karakteri kullanilir.

--Similar To ile
select * from kelimeler where kelime SIMILAR TO '%(at|ot|Ot|At|aT|oT|OT|AT)%';
--Like ile
select * from kelimeler where kelime ~~* '%at%' or kelime ~~* '%ot%';
select * from kelimeler where kelime ILIKE '%at%' or kelime ILIKE '%ot%';
--REGEX ile
select * from kelimeler where kelime ~* 'ot' or kelime ~* 'at';

--  'ho' veya 'hi' ile başlayan kelimeleri listeleyeniz
--Similar to ile
select * from kelimeler where kelime similar to 'ho%|hi%';
--Like ile
select * from kelimeler where kelime ~~* 'ho%' or kelime ~~* 'hi%';
--Regex ile
select * from kelimeler where kelime ~* 'h[oi](.*)'; -- Regex'te ".(nokta) bir karakteri temsil eder."
-- Regex'de ikinci karakter icin koseli parantez kullanilir. * hepsi anlaminda kullanilir.

-- Sonu 't' veya 'm' ile bitenleri listeleyeniz
select * from kelimeler where kelime similar to '%t|%m';
select * from kelimeler where kelime ~* '.*[tm]$'; --$ karakteri bitisi gosterir

-- h ile başlayıp t ile biten 3 harfli kelimeleri listeleyeniz
-- Like ile
select * from kelimeler where kelime ~~* 'h_t';
-- Similar To ile 
select * from kelimeler where kelime similar to 'h[a-z,A-Z,0-9]t';
--Regex ile
select * from kelimeler where kelime ~* 'h[a-z,A-Z,0-9]t';

--İlk karakteri 'h', son karakteri 't' ve ikinci karakteri 'a'dan 'e'ye herhangi bir karakter olan “kelime" değerlerini çağırın.
select * from kelimeler where kelime similar to 'h[a-e,A-E]%t';
--Regex ile
select kelime from kelimeler where kelime ~* 'h[a-e](.*)t';

--İlk karakteri 's', 'a' veya 'y' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime similar to '[s,a,y]%';

select * from kelimeler where kelime ~ '^[say](.*)'; -- "^" --> baslangici temsil eder

--Son karakteri 'm', 'a' veya 'f' olan "kelime" değerlerini çağırın.
select * from kelimeler where kelime similar to '%[m,a,f]';

select * from kelimeler where kelime ~ '(.*)[maf]$';

--İlk harfi h, son harfi t olup 2.harfi a veya i olan 3 harfli kelimelerin tüm bilgilerini sorgulayalım.
select * from kelimeler where kelime similar to 'h[a|i]t';
--Regex
select * from kelimeler where kelime ~* '^h[a|i]t$';

--İlk harfi 'b' dan ‘s' ye bir karakter olan ve ikinci harfi herhangi bir karakter olup 
--üçüncü harfi ‘l' olan “kelime" değerlerini çağırın.

select * from kelimeler where kelime ~* '^[b-s].l(.*)$';

--içerisinde en az 2 adet oo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
select * from kelimeler where kelime similar to '%[o][o]%';
select * from kelimeler where kelime similar to '%[o]{2}%'; --Suslu parantez icindeki rakam bir onceki koseli parantez 
                                   							--icinde kac tane oldugunu belirtir.
															
--içerisinde en az 4 adet oooo barıdıran kelimelerin tüm bilgilerini listeleyiniz.
select * from kelimeler where kelime similar to '%[o]{4}%';

--'a', 's' yada 'y' ile başlayan VE 'm' yada 'f' ile biten "kelime" değerlerini çağırın.
select * from kelimeler where kelime ~* '^[a|s|y](.*)[m|f]$';



