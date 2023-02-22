# 2. óra

## Jogosultságok
---

Az előző órán megtanultuk, hogy hogyan lehet terminálban navigálni a fájlrendszerbe.
Nem néztük azonban meg, hogy milyen jogosultságok vannak, hogyan lehet ezeket megnézni,
hogyan tárolja őket a Linux, és hogyan tudjuk őket módosítani.

A jogosultságok megtekintése meglehetősen egyszerű, és ennek a módját már tanultuk. Adjuk ki
a következő parancsot egy tetszőleges, nem üres mappában (természetesen terminálból).

```bash
ls -l
```

Eddig nem néztük meg jobban, hogy mit is ír ki pontosan az `ls` parancs az `-l` kapcsolóval
kombinálva. Az alábbi képen látható egy lehetséges output:



Ilyenkor a következő oszlopok jelennek meg.
1. Jogosultságok. Rövidesen tisztázzuk az értelmezését.
2. Tulajdonos. Általában egyezik azzal a felhasználóval, aki létrehozta a fájlt.
3. Tulajdonosi csoport. Rövidesen erre is kitérünk bővebben.
4. Méret. Bájtokban megadva látjuk.
5. Utolsó módosítás ideje.
6. Név.



### nano (terminálos szövegszerkesztő)
A nano egyike a tömérdek terminálos szövegszerkeztőknek, amik elérhetőek szoktak lenni egy 
Unix rendszerre (ismertek még: emacs, vim). A nano egy olyan szövegszerkesztő, ami
teljesen a terminálban működik, és nem kell külön ablakot nyitnia, hogy használható legyen.
Az egér is szinte teljesen haszontalan.


### Parancsok kombinálása
Az Unix parancsok azt az elvet követik, hogy egy parancs egy lényegi feladatot hajtson végre, 
de azt jól. Ennek megfelelően, ha komplexebb feladatot akarunk végrehajtani, akkor 
valószínűleg nem fogunk olyan parancsot találni, ami megoldja nekünk azt. Helyette össze 
kell kombinálni meglévő parancsokat valamilyen módon. Erre adnak lehetőséget az alábbi 
eszközök:

- `parancs1 && parancs2` -> ha parancs1 sikeresen végrehajtódott, akkor hajtódjon végre
parancs2 is.
- `parancs1 || parancs2` -> ha parancs1 elbukott, akkor hajtódjon végre parancs2
- `parancs1 | parancs2` -> parancs1 kimenetét parancs2 bemenetére irányítja

Ezeken felül lehet még a parancs outputját valamilyen egyéb "folyamra" (stream) is irányítani.
Ez akkor hasznos például, ha fájlba szeretnénk írni, vagy csak "kukázni" akarjuk az 
outputot. A következő "irányításokat" ismerjük meg:

- `parancs > streamname` -> a parancs outputját a `streamname` nevű streamre irányítja.
Tipikus eset, hogy `streamname` egy fájl; ekkor az output felülírja a fájl tartalmát
(az eredeti tartalom törlődik).
- `parancs >> streamname` -> ugyanaz, mint az előző, csak a parancs outputja hozzáfűződik
a streamhez, nem pedig felülírja azt. Ez fájl esetén a látványos, mikor ez a parancs a 
fájl végéhez hozzáír további adatok, míg az előző parancs teljesen felülírja a fájl tartalmát.

Vegyük észre, hogy alapból is egy streamre írunk, a *standard output* streamre (*stdout*, 1-es
azonosító). Ismert a *standard input* stream is (*stdin*, 0-s azonosító), továbbá a *standard
error* stream (*stderr*, 2-es azonosító).

### Script fájlok
Egy parancsot nem csak a terminálba lehet beírni. Helyette el lehet tárolni 

### Hasznos parancsok
Az alábbi [jegyzetben](https://users.iit.uni-miskolc.hu/~toth130/arch/gyak/Gyak2.pdf) fel
vannak sorolva hasznos parancsok, kicsit bővebb magyarázatért pedig a
[következő](https://users.iit.uni-miskolc.hu/~toth130/arch/gyak/Gyak4.pdf) jegyzetet is
érdemes megtekinteni.

### Reguláris kifejezések
A reguláris kifejezések a *text matching* feladatához gyakran használt eszközök. A reguláris 
kifejezések egy strukturált megfogalmazása annak, hogy milyen szöveget szeretnénk megtalálni
egy másik szövegben. Egy rövid összefoglaló található a föntebb megjelölt forrásokban, de
a legbőségesebb tudástár ilyen téren az [internet](https://www.regular-expressions.info/).

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

### 1. feladat
Próbáljunk meg belépni egy `tmp` nevű jegyzékbe, és ha nem sikerül, akkor hozzuk létre azt, és 
lépjünk bele. Mindezt oldjuk meg egyetlen sor parancsban.

**Megoldás:**

```bash
cd tmp || mkdir tmp && cd tmp
```

### 2. feladat
Az előzőleg létrehozott `tmp` mappában készítsünk egy hello.txt nevű fájlt!
A fájlba írjunk bele az `echo` parancs segítségével (elismétli, amit írsz neki),
először annyit, hogy "hello world!", másodszor annyit, hogy "goodbye world!".

**Megoldás:**
```bash
touch hello.txt
echo "hello world!" > hello.txt
echo "goodbye world!" > hello.txt # why doesn't it work? read upwards :)
cat hello.txt # this command will print the content of hello.txt to the terminal
```

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