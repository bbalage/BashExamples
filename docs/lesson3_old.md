# 3. óra

## Elméleti információk
Mire használják a Bash-t:
- Fájlrendszer műveletekre.
- Parancssori programok indítására.
- Parancssori programok kombinálására.

A munkánk során gyakran ismétlődő feladatok automatizálására.

Az órához szükséges szintaktikai információk a következő linkeken találhatók:
- [Változók használata](https://users.iit.uni-miskolc.hu/~toth130/arch/gyak/Gyak5.pdf)
- [Feltételes szerkezetek használata](https://users.iit.uni-miskolc.hu/~toth130/arch/gyak/Gyak6.pdf)

A továbbiakban oldjunk meg feladatokat velük!

A megoldások elérhetőek [itt](https://github.com/bbalage/BashExamples/tree/master/bash/lesson3).

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


## Feladatok
Az alábbi feladatokat hajtsuk végre a jegyzetekben található parancsokkal, regulári
kifejezésekkel, vagy ezeknek a kombinálásával!

**Lépjünk be egy az órára létrehozott jegyzékünkbe (lesson2), és a feladatokat hajtsuk
végre ott!**

A feladatok megoldásai megtalálhatóak az
[alábbi mappában](https://github.com/bbalage/BashExamples/tree/master/bash/lesson2), viszont
a megoldókulcsot igénylő
feladatokhoz eleve odaírtam a megoldást is. Amelyiknél nincs megoldás, ott legalább a 
próbálkozás és a jegyzetekben való utánaolvasás szükséges!

### 3. feladat

Készítsünk nano segítségével egy csv fájlt! A csv fájl csak egy text fájl, amiben strukturálva
vannak az adatok, nagyjából úgy, mint egy táblázatban. Például:
```
Name;Birthdate;Phone;Skill
Robert Bob;1997.09.12.;06201975555;IT
Zsuber Driver;1988.10.11.;06304445555;Driving
Hatori Hanso;1966.01.11.;06301234555;Smithing
Rinaldo Orson;2001.05.24.;06709330000;IT
Travis Camel;1970.10.01.;06301717171;Horses
Dagobert McChips;1956.08.31.;06700001111;Cooking
Bumfolt Rupor;1967.09.11.;06201112233;Marketing
```

A fönti tartalommal hozza létre a people.csv fájlt!

Írassuk ki a következőket a terminálba (egyetlen sornyi paranccsal):
- Azokat a sorokat, ahol a személy ért az IT-hez.
- Azokat a sorokat, ahol a személy keresztneve R-rel kezdődik.
- Azokat a sorokat, ahol a személy vezetékneve R-rel kezdődik.
- Azokat a sorokat, ahol a telefonszám 30-as.
- Azokat a sorokat, ahol a *Skill* megnevezése -*ing* végződésű.
- Azokat a sorokat, ahol a személy 2000-ben vagy utána született.
- Az első 3 sort, a fejléccel együtt (a fejléc a Name;Birthdate;Phone;Skill sor).
- Az első 3 sort, a fejléc nélkül.

```bash
cat people.csv | grep "IT" # the first one... do the rest!
```

### 4. feladat
Írjunk egy scriptet, amely leszed a következő url-ről egy text file-t, majd kiírja belőle 
a valid email címeket egy `emails.txt` fájlba, aztán törli az eredetileg letöltött fájlt.

Url: https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/file1.txt

Az emails.txt fájl tartalma a következő kell legyen:
```
Jupici@gmail.com
howard.wayland@citromail.hu
ubuntu@gmail.com
bestrapper@gmail.com
ET@gmail.com
harapos@gmail.com
bob@gmail.com
```

**Help:** érdemes ránézni a `wget`, `cat`, `grep` és `rm` parancsokra.

### 5. feladat
Készítsünk egy scriptet, ami lefordít, majd lefuttat egy C programot, majd az eredményét és 
a futási idejét egy fájlba írja, majd az eredményt felmásolja jerry-re.

A program rendelkezzen a következő kóddal:

```c
// This should be in hello.c
#include "stdio.h"

int main()
{
    printf("Hello World!\n");
}
```

A fordításhoz használjuk a `gcc` programot! A következőképpen:

```bash
gcc hello.c -o hello
```

A lefordított program ekkor a `hello` fájlba kerül. A futtatást a következőképpen vitelezhetjük
ki:

```bash
./hello
```

Az idő mérésére alkalmas a `time` program. A jerry-re való felmásolást az `scp` programmal meg
tudjuk oldani.

**Önálló feladat:** Az internet segítségével találjuk meg, hogy a `time` program és a `hello`
program outputját hogyan tudjuk egy fájlba irányítani! Trükkös, mert a `time` nem a standard 
outputra ír, hanem a standard error streamre. Ezután keressük meg, hogy az `scp` programot 
hogyan tudjuk használni!