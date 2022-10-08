# 4. óra
Ezen az órán az eddig tanultak alapján gyakorlófeladatokat csinálunk. A példakódok segítségre 
szolgálnak. Bizonyos feladatoknál hasznosak lehetnek.

## 1. Példakód csoport

Korábbi ismeretekből példakódok.

### 1.1. példa
Az alábbi script leszed egy fájlt az internetről, és kilistázza a tartalmát.

```bash
wget https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/file1.txt
cat file1.txt
```

### 1.2. példa
Az alábbi script kitömöríti az `example.zip` fájlt, és a tartalmát egy `dirname` nevű
mappába helyezi.

```bash
unzip example.zip -d dirname
```

### 1.3. példa
Az alábbi script lefordít egy `hello.c` fájlnevű C fájlt, és a készült bináris parancsfájlt 
`hello` néven kiírja a fájlrendszerre.

```bash
gcc hello.c -o hello
```

### 1.4. példa
Az alábbi script lefuttat egy `rm` parancsot, és ha a parancs sikertelen volt, akkor hibaüzenetet
ír, majd maga is kilép hibával. Megjegyzem, hogy a `$?` a legutóbb lefuttatott parancs visszatérési
értékét adja, és a fele végrehajtott ellenőrzés bármilyen szabványkövető paranccsal működőképes
kell legyen.

```bash
rm -r non_existing_directory # -r is for recursive; if specified, rm deletes a directory with all its contents
if [ $? -ne 0 ]; then
    echo "There was an error!" 1>&2
    exit 1
fi
```

### 1.5. példa
Az alábbi script ellenőrzi, hogy van-e már `build` nevű mappa a futtatás helyén, és
ha nincs, akkor létrehozza azt.

```bash
if [ ! -d build ]; then
    mkdir build
fi
```

## 1. feladatcsoport
Néhány gyakori parancs együttes használata. Plusz pontért megcsinálható feladatok.

### 1.1. feladat
Az MVK Zrt. elérhetővé tesz egy szabványos GTFS adatbázist a fejlesztők számára, hogy a menetrendi 
adatokat a saját applikációikba tudják integrálni. Írjunk egy shell script fájlt, amely letölti ezt 
az adatbázist, és kilistázza belőle azokat az utakat, amelyek a Centrumból indulnak, vagy a Centrumba
mennek.

**Parancsok:**
wget, unzip (kitömörítésre), cat, grep

**Szükséges ellenőrzések:**
- Ha a letöltendő fájl már egyszer le volt töltve, akkor az újbóli letöltés előtt töröljük az előző 
verziót!
- Ha egy mappába már korábban ki lett tömörítve a letöltött állomány, akkor az újbóli kitömörítés
előtt szabaduljunk meg ennek a mappának a tartalmától!

### 1.2. feladat
Írjunk egy shell script fájlt, amely lefordít egy paraméterként megadott .c fájlt, ha az létezik és
nem üres (ha nem létezik vagy üres, akkor jelezzen hibát, és adjon hibaüzenetet)!
A lefordított, futtatható bináris állomány egy `build` nevű mappába kerüljön, mely jöjjön létre, ha 
még nem létezik!

Ha a fordítás sikeres, akkor futtassa le a kapott bináris állományt!

A C program legyen a következő:

```c
#include "stdio.h"

int main()
{
    printf("Hello World!\n");
}
```

**Parancsok:** gcc (C fordító)

## 2. Példakódcsoport
Ciklusokhoz tartozó példakódok.
További példakódok és bővebb magyarázatok találhatók az alábbi [pdfben](https://users.iit.uni-miskolc.hu/~toth130/arch/gyak/Gyak7.pdf).

### 2.1. példa
Az alábbi script kiírja 0-tól 10-ig a számokat, `for`, `while` és `until` ciklussal is!

```bash
# for ciklussal
for (( i = 0; i <= 10; i++)); do
    printf "$i "
done
echo

# while ciklussal
i=0
while [ $i -le 10 ]; do
    printf "$i "
    i=$((i + 1))
done
echo

# until ciklussal
i=0
until [ $i -gt 10 ]; do
    printf "$i "
    i=$((i + 1))
done
echo
```

### 2.2. példa
Az alábbi script felsorolja az összes argumentumot, amit a program kapott.

```bash
for i in $*; do
    echo $i
done
```

### 2.3. példa
Az alábbi script véletlenszámokat generál különböző intervallumokban, és kiírja őket.

```bash
echo $((RANDOM % 100)) # [0-99]
echo $((RANDOM % 101)) # [0-100]
echo $((RANDOM % 100 + 1)) # [1-100]
echo $((RANDOM % 50)) # [0-49]
echo $((RANDOM % 51 + 50)) # [50-100]
```

### 2.4 példa
Az alábbi script bekéri `N` értékét, és kiírja az első `N` Fibonacci számot, ahol nullát vesszük a
nulladik Fibonacci számnak. `N` legalább 1.

```bash
read -p "Please, give the valu of N (at least 2):" N

if [ N -lt 2 ]; then
    echo "N was too small." 1>&2
    exit 1
fi

f_before_prev=0
f_prev=1
echo "0: $f_before_prev"
echo "1: $f_prev"
for ((i = 2; i <= N; i++)); do
    f=$((f_prev + f_before_prev))
    echo "$i: $f"
    f_before_prev=$f_prev
    f_prev=$f
done
```

### 2.5. példa
Az alábbi script kilistázza a working directory-ban található fájlokat (és mappákat), és mindegyikhez
egy számot is rendel.

```bash
i=0
for name in $(ls); do
    echo "$i: $name"
    i=$((i+1))
done
```

## 2. feladatcsoport
Ciklusok használata. Plusz pontért.

### 2.1. feladat

Írjunk egy shell scriptet, ami bemeneti paraméterként egyetlen pozitív számot vár (hibát ír, ha nem)
ezt kap. A program feladata, hogy kiírja, hogy a kapott szám prím-e.

### 2.2. feladat
Írjunk egy shell scriptet, ami bemeneti paraméterként egy mappa nevét várja. Ha a mappa létezik,
akkor minden benne lévő fájlra lefuttat egy scriptet, amely az alábbi tartalommal rendelkezik:

```bash
# TODO
```

### 2.3. feladat
Írjunk két shell scriptet, amelyek egymás "párjai".

Az egyik shell script legenerálja az első 
10 Fibonacci számot (1-től kezdődve), és kiírja ezeket a számokat egy 1-1 külön fájlba.
A fájlok legyenek 1.txt, 2.txt, ..., 10.txt. A fájlok tartalma kizárólag a Fibonacci szám legyen,
amit generáltunk hozzájuk. A fájlok egy külön mappában helyezkedjenek el.

A másik shell script kapjon meg mappát bemeneti paraméterként. A mappában talált összes `n.txt`
szerkezetű fájlban növelje meg a szám értékét 1-gyel. A változtatás természetesen íródjon vissza a
megfelelő fájlba!