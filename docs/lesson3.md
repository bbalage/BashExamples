# 3. óra

Az órához szükséges szintaktikai információk a következő linkeken találhatók:
- [Változók használata](https://users.iit.uni-miskolc.hu/~toth130/arch/gyak/Gyak5.pdf)
- [Feltételes szerkezetek használata](https://users.iit.uni-miskolc.hu/~toth130/arch/gyak/Gyak6.pdf)

A továbbiakban oldjunk meg feladatokat velük!

## 1. feladat
Hozzunk létre egy shell script fájlt, mely bemeneti paraméterként beolvas két számot, és kiírja
az összegüket, különbségüket,
szorzatukat, hányadosukat és osztási maradékukat a standard outputra. Amennyiben nem két szám
került megadásra, vagy nulla a második szám, akkor írjunk hibaüzenetet a standard error streamre, 
majd térjünk vissza hibás jelzéssel.

## 2. feladat
Hozzunk létre egy shell script fájlt, amely egy konfigurációs fájlt generál nekünk YAML 
formátumban. Ez egy rendkívül egyszerű formátum, ami jelen esetben így fog kinézni:

```yaml
username: first input
version: second input
site: third input
```

Kérjük be az inputokat a felhasználótól, és hozzuk létre a `config.yml` fájlt az inputjának 
megfelelően!

## 3. feladat
Hozzunk létre egy shell script fájlt, amely egy paraméterként kapott txt fáljban a `happy` szó
minden előfordulását `not thinking about the vizsgaidőszak` szövegre cseréli, és elmenti 
az új szöveget egy `filename_out.txt` fájlba, ahol `filename` az eredeti fájl neve, kiterjesztés
nélkül.

Egy elkészített példafájl a következő linken letölthető:
https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/winnie_the_pooh.txt

## 4. feladat
Hozzunk létre egy shell script fájlt, amelyben bekérjük két kettő dimenziós térbeli pontnak a 
koordinátáit, és kiszámoljuk az Euklidészi távolságukat. Használjuk az internetet, hogy a 
gyökvonás módját megleljük!