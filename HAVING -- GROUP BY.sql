/*
GROUP BY -- HAVING --
HAVING ifadesinin islevi WHERE ifadesininkine cok benziyor.
Ancak kumeleme fonksiyonlari ile WHERE ifadesi birlikte kullanilmadigindan 
HAVING ifadesine ihtiyac duyulmustur.
GROUP BY ile kullanilir gruplamadan sonraki sart icin group by'dan sonra
HAVING kullanilir.
*/

--Maaş ortalaması 30000’den fazla olan ülkelerdeki erkek çalışanların maaş ortalaması.
select ulke, round(avg(maas),2) as maas_ortalamasi from personel
where cinsiyet = 'E'
group by ulke having avg(maas) > 30000; 

select ulke,round(avg(maas),2)as maas_ortalamasi from personel
where cinsiyet='E'and maas>30000
group by ulke

--Erkek çalışanların sayısı 1’den fazla olan ülkelerin maaş ortalamasını getiren sorgu(odev)