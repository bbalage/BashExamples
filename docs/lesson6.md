# 6. óra

A Bash nyelvben is megvannak a feltételes utasítások. Ezeket fogjuk megnézni az órán.

Bashben tömérdek feltételvizsgáló operátor van. Alább egy összefoglaló lista látható.
A lista után meg fogjuk nézni, hogy az egyes operátorokat hogyan tudjuk használni.

## Feltételes operátorok
### Egész számok
Legyenek `x` és `y` egész számok.

```bash
x=10; y=20
```
| Művelet      | Bash | Jelentés |
| ----------- | ----------- | - |
| x < y | `$x -lt $y`| less-than|
| x <= y   | `$x -le $y` | less-or-equal |
| x > y   | `$x -gt $y` | greater-than |
| x >= y   | `$x -ge $y` | greater-or-equal|
| x == y   | `$x -eq $y` | equal |
| x != y   | `$x -ne $y` | not-equal|

### Stringek
Legyenek `text1` és `text2` stringek.

```bash
text1=blabla
text2="Bla bla"
```

| Bash | Jelentés |
| ----------- | - |
| `$text1 == $text2`| egyenlőség|
| `$text1 != $text2`| nem egyenlőség|
| `$text1 < $text2`| text1 rendezéskor text2 elé kerül (jelenlegi *locale* szerint)|
| `$text1 > $text2`| text1 rendezéskor text2 után kerül (jelenlegi *locale* szerint)|
| `-n $text1`| text1 nem üres |
| `-z $text1`| text1 üres |
| `$text1 =~ "regex_pattern" `| text1-re illeszkedik a regex_pattern reguláris kifejezés |

### Fájlok
Legyen `file_path` egy fájl elérési útja, `other_file_path` pedig egy másik fájllé.

| Vizsgálat tárgya | Bash | Jelentés |
| -- | ----------- | - |
| A fájl létezik-e | `-e file_path`| exists |
| Directory létezik-e | `-d file_path`| directory |
| Legutóbbi olvasás óta módosult-e | `-N file_path`| new |
| Jelenlegi user által birtokolt-e | `-O file_path`| owned |
| Olvasható-e | `-r file_path`| readable |
| Írható-e | `-w file_path`| writeable |
| Futtatható-e | `-x file_path`| executable |
| Nem üres-e | `-s file_path`| size greater than zero byte |
| Újabb-e egyik fájl a másiknál | `file_path -nt other_file_path`| newer than |
| Régebbi-e egyik fájl a másiknál | `file_path -ot other_file_path`| older than |
| Ugyanaz a fájl-e (a fájlrendszeren) | `file_path -ef other_file_path`| equal file |

---
Most már ismerjük a vizsgáló operátorokat. Nézzük, milyen szintaxissal tudjuk ténylegesen használni
őket!

## && és || szerkezet
Ezt már láttuk korábban. Továbbra is ugyanazt csinálják, mint eddig, csak a `test` parancs
segítségével feltételvizsgálatot társíthatunk hozzájuk. Például:

```bash
x=10; y=20
test $x -lt $y && echo "Smaller" # -lt means less-than
test $x -gt $y && echo "Greater" # -gt means greater-than
```

Ez a fajta feltételmegadás egysorosok esetén használható jól. Például a következő kód 
létrehoz egy fájlt, ha az nem létezik.

```bash
test -e some_file.txt || touch some_file.txt # -e means exists
```

Létezik két segédprogram is a rendszeren, a `true` és a `false`. Ezek a nevükhöz illően
úgy viselkednek, mintha egy mindig igazra (`true`) vagy egy mindig hamisra (`false`) kiértékelődő
feltételt írtunk volna a helyükre. Például:

```bash
true && echo "This is written"
true || echo "This is NOT written"
false && echo "This is NOT written"
false || echo "This is written"
```

A `test` parancsnak van egy *shortcut*-ja is, szögletes zárójelek formájában. A következő két 
sor parancs ugyanaz.

```bash
test 1 -ne 2 && echo "Thing"
[ 1 -ne 2 ] && echo "Same thing"
```

Ez az `if` szerkezetnél lesz intuitívabb. Szintén az `if` szerkezetnél fogjuk használni a
`[[ feltétel ]]`, tehát a kétszeres szögletes zárójeles szerkezetet is.

```bash
[[ 1 -ne 2 ]] && echo "Almost the same thing"
```

Ez majdnem ugyanolyan, mint az egyszeres szögletes zárójel (és ennélfogva a `test` parancs),
kivéve, hogy ez többféle szintaxist megenged. Például csak ebben tudjuk használni a 
reguláris kifejezés összehasonlító operátort `=~`.

A továbbiakban leginkább az `if-else` szerkezetet használjuk, mert ez rugalmasabb.

## if-else szerkezet
Az `if` szerkezetek írásakor ugyanúgy használhatjuk a `test` operátort, mint eddig:

```bash
if test 1 -eq 1; then
  echo "true"
fi
```

A következőt azonban (főleg imperatív nyelvek ismeretében) intuitívabb olvasni:

```bash
if [ 1 -eq 1 ]; then
  echo "true"
fi
```

A két fönti kifejezés ugyanazt jelenti. A továbbiakban mi többnyire a lenti kifejezést használjuk
majd, mert gazdagabb feltételmegfogalmazást biztosít nekünk:

```bash
if [[ 1 -eq 1 ]]; then
  echo "true"
fi
```

Ennél az egyszerű példánál természetesen mindhárom ugyanazt jelenti.

Az `if` szerkezet sajátossága Bashben a többi nyelvhez képest, hogy a lezáró parancsa a `fi`,
ami az `if` fordítva. Ezt a logikát máshol is látjuk majd.

Az `if` szerkezethez rakhatunk `else` ágat is:

```bash
if [[ 1 -ne 1 ]]; then
  echo "true"
else
  echo "false"
fi
```

Az `else-if` szerkezetet a Bash a következőképpen oldja meg:

```bash
x=10
if [[ $x -eq 1 ]]; then
  echo "equal"
elif [[ $x -lt 1 ]]; then
  echo "less than"
else
  echo "greater than"
fi
```

Látható, hogy az `else-if` szavak összevonódtak az `elif` szóba.

A C-ből ismert `switch-case` szerkezet is megtalálható itt, a következő szintaxissal:

```bash
read -p "Which type of person are you, 0, 1, 2 or 3" ptype
case $ptype in
0)
  echo "You are chaotic evil.";;
1)
  echo "You are a mermaid.";;
2)
  echo "You are phylosopher.";;
3)
  echo "You are a Tauren Druid.";;
*)
  echo "That's not a person type, it's a default!";;
esac
```

A `[[]]` szerkezetben hasonlóan tudjuk használni az ÉS, VAGY, NEM logikai kifejezéseket, ahogy C-ben.
Például a következő ellenőrzi, hogy x 10 és 20 között legyen:

```bash
if [[ $x -gt 10 && $x -lt 20 ]]; then 
  echo "OK"
fi
```

Vagy hogy NE legyen szám:

```bash
reg_ex='^[0-9]+$'
# A felkiáltójel a következő kifejezés tagadása
if [[ ! $x =~ $reg_ex ]]; then
  echo "Not a number."
fi
```

Most már nagyjából mindent tudunk, amire a feltételes kódjainkhoz szükség lesz.
Lássunk példákat!

## Példák
A következő példákban gyakoriak lesznek az input ellenőrzések. Amennyiben egy input nem megfelelő,
hibával lépünk ki a programból. A hiba jelzésére a program visszatérési értéke alkalmas. Ha a 
visszatérési érték nem nulla, az hibát jelent. Idő előtt kilépni az `exit` paranccsal tudunk.

Például:

```bash
#!/bin/bash

if [ 1 -ne 1 ]; # very unexpected error
  exit 1 
fi
```

Ha nem írunk számot az `exit` után (vagy nem írunk `exit` parancsot a programba), akkor a visszatérési
érték automatikusan nulla lesz (még akkor is, ha valamelyik parancs hibát adott a programon belül).
Például a következő program nem tér vissza hibával, bár a `grep` maga hibára fut.

```bash
#!/bin/bash

grep "hello" nonexistent_file_blabla.txt
```

### 1. példa
Készítsünk egy shell scriptet, ami bemenetként egy téglalap két oldalának hosszát várja, és kiírja 
a síkidom területét! Valósítsuk meg csak egész számokkal! (Természetesen végezzünk ellenőrzéseket az
inputon!)

```bash
#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Two inputs are needed, $# is given." 1>&2
  exit 1
fi

reg_ex='^[0-9]+$'
if [[ ! $1 =~ $reg_ex || ! $2 =~ $reg_ex ]]; then
  echo "Both inputs must be positive integer numbers!" 1>&2
  exit 1
fi

echo "Area is: $(($1 * $2))"
```

A `1>&2` kifejezés az `echo` után átirányítja a standard output streamet a standard error streamre.

Az első `if` kifejezés ellenőrzi, hogy pontosan két inputot adtunk-e meg.

A második `if` kifejezés biztosítja, hogy ha az első vagy a második kifejezés nem felel meg az egész 
számokra vonatkozó reguláris kifejezésünknek, akkor hibaüzenettel lépjünk ki.

### 2. példa
Legyen adott egy fájl `name_id_pairs.txt` néven, ami id és név párosokat tartalmaz.
Készítsünk egy shell scriptet, ami bekéri a nevet, és kiírja a hozzá tartozó id-t,
vagy hibát ad, ha a név nem található a fájlban.

A fájl tartalma legyen a következő:

```
zsuzso:aef7421b
alfonz:eef4555b
barnabas:98726371
tom:aaaabbbb
jerry:cccdddee
hasselhoff:cafebabe
```

A következő script megvalósítja a feladatot:

```bash
#!/bin/bash

read -p "Please, type the name you are searching for! " name

row=$(cat name_id_pairs.txt | grep $name)

if [[ -z $row ]]; then
  echo "No name like that." 1>&2
  exit 1
fi

id=$(echo $row | cut -d ':' -f 2)
echo $id
```

### 3. példa
Az MVK Zrt. elérhetővé tesz egy szabványos GTFS adatbázist a fejlesztők számára, hogy a menetrendi 
adatokat a saját applikációikba tudják integrálni. Írjunk egy shell script fájlt, amely letölti ezt 
az adatbázist, és kilistázza belőle azokat az utakat, amelyek a Centrumból indulnak, vagy a Centrumba
mennek!

**Parancsok:**
wget, unzip (kitömörítésre), cat, grep

**Szükséges ellenőrzések:**
- Ha a letöltendő fájl már egyszer le volt töltve, akkor az újbóli letöltés előtt töröljük az előző 
verziót!
- Ha egy mappába már korábban ki lett tömörítve a letöltött állomány, akkor az újbóli kitömörítés
előtt szabaduljunk meg ennek a mappának a tartalmától!

**Megjegyzés:** A tanszéki gépekről *certificate* problémák miatt a korábbiakban nem volt letölthető
az adatbázis, ezért egy *github* repository-ba is feltettem. A hozzá tartozó parancs ki van
kommentezve. Hibaüzenet esetén cseréljük le a jelenlegi url-t a következőre:
*https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/gtfs.zip*

```bash
#!/bin/bash

if [ -e gtfs.zip ]; then
    rm gtfs.zip
fi

if [ -d gtfs ]; then
    rm -r gtfs
fi

wget "https://gtfsapi.mvkzrt.hu/gtfs/gtfs.zip"
unzip gtfs.zip -d gtfs # próbáljuk ki -d kapcsoló nélkül is...
cat gtfs/routes.txt | grep "Centrum"
```

### 4. példa

Készítsünk egy shell scriptet, ami bekéri a felhasználó születési dátumát `yyyy.mm.dd` formátumban!
Ellenőrizzük le a dátum helyességét, és írjuk ki, hogy a felhasználó hány éves!

Használjuk a `date` parancsot a jelenlegi dátum lekérésére!

```bash
#!/bin/bash

read -p "Please, type your birthdate in yyyy.mm.dd format! " bdate

reg_ex='^[0-9]{4}\.[0-9]{2}\.[0-9]{2}$'
if [[ ! $bdate =~ $reg_ex ]]; then
  echo "Date is not in proper format!" 1>&2
  exit 1
fi

byear=$(echo $bdate | cut -f 1 -d '.')
bmonth=$(echo $bdate | cut -f 2 -d '.')
bday=$(echo $bdate | cut -f 3 -d '.')

# A date parancs le tudja ellenőrizni egy szintaktikailag helyes
# dátum validitását. Például a hónap nem-e nagyobb 12-nél, stb.
date -d "$byear-$bmonth-$bday" > /dev/null || exit 1

bseconds=$(date -d "$byear-$bmonth-$bday" +%s)
cseconds=$(date +%s)

age_in_seconds=$((cseconds - bseconds))

if [[ $age_in_seconds -lt 0 ]]; then
  echo "You haven't been born yet!" 1>&2
  exit 1
fi

echo $(( age_in_seconds / 60 / 60 / 24 / 365 ))
```

## Feladatok

### 1. feladat
Valósítsuk meg az *1. példa* feladatát, de ezúttal lebegőpontos számokkal!

### 2. feladat
Valósítsuk meg a *2. példa* feladatát, de ezúttal ne csak `name_id_pairs.txt` nevű fájlra
működjön, hanem bármilyen nevű fájlra! A fájl nevét a script bemeneti paraméterként 
fogadja! Ellenőrizzük, hogy a fájl létezik és olvasható-e, mielőtt a funkciók további részét
megvalósítjuk!

### 3. feladat
Valósítsuk meg a *3. példa* feladatát, de ezúttal a Centrum helyett bármelyik végállomást 
fogadjuk el, és bemeneti paraméterként adjuk át azt a scriptnek. Ha nincs ilyen végállomás,
írjunk hibaüzenetet!
