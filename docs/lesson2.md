# 2. óra

Ezen az órán további kisebb feladatokat fogunk megoldani. Néhány bezető példa után 
igyekszek olyan feladatokra szorítkozni, amelyekhez hasonlóak a gyakorlatban is
előfordulhatnak. Ennek megfelelően felvetődik
a kérdés, hogy **mire jó a Bash?** A következő célokra a bash egy jól használható script
nyelv:
- Rendszergazdai feladatok ellátása.
- A munkánk során gyakran ismétlődő feladatsorozatok kötegelése. (Vagyis, ha én
minden alkalommal, mikor eljutottam egy pontra a fejlesztésben 1. lefordítom a kódot, 2.
teszt futtatást végzek, 3. a teszt futtatás eredményét felküldöm egy weboldalra, majd 4.
egy log fájlban rögzítem a futási időmet, akkor ezt a négy parancsot akár be is írhatom 
egyetlen Bash fájlba, és innentől mindig csak ezt a fájlt kell "lefuttatnom", hogy ez a 
4 lépés végrehajtódjon.)

Mielőtt azonban példákat oldunk meg, 
pár előzetes ismeretet is szeretnék átadni a programok strukturálásával kapcsolatban.

## Előzetes ismeretek
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

### nano (terminálos szövegszerkesztő)
A nano egyike a tömérdek terminálos szövegszerkeztőknek, amik elérhetőek szoktak lenni egy 
Unix rendszerre (ismertebbek még: emacs, vim). A nano egy olyan szövegszerkesztő, ami
teljesen a terminálban működik, és nem kell külön ablakot nyitnia, hogy használható legyen.
Az egér is szinte teljesen haszontalan.

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

A feladatok megoldásai megtalálhatóak az alábbi mappában, viszont a megoldókulcsot igénylő
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
a valid email címeket egy `emails.txt` fájlba!

