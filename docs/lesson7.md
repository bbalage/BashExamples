# 7. óra
A hetedik gyakorlaton a ciklusokkal és tömbökkel fogunk foglalkozni.

## Ciklusok
Bashben léteznek a már máshonnan bizonyosan ismert `for` és `while` ciklusok, némileg más szintaktikával.
Létezik ezen felül `until` ciklus is, ami nem sokban különbözik a `while` ciklustól, mindössze annyiban,
hogy nem addig megy, amíg a feltétel igaz, hanem addig, amíg a feltétel hamis.

Nézzünk példákat a cikluskezelésre!

### 1. példa
Írjuk ki 0-tól 10-ig a számokat, `for`, `while` és `until` ciklussal is!

```bash
#!/bin/bash

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

### 2. példa
Generáljunk egy véletlen számot, és írjuk ki a nála kisebb négyzetszámokat!

A véletlenszám generálás Bashben a RANDOM változón keresztül elérhető. Alább néhány példa
generálás látható, adott intervallumokban.

```bash
echo $((RANDOM % 100)) # [0-99]
echo $((RANDOM % 101)) # [0-100]
echo $((RANDOM % 100 + 1)) # [1-100]
echo $((RANDOM % 50)) # [0-49]
echo $((RANDOM % 51 + 50)) # [50-100]
```

Az alábbi script egy megoldása a feladatnak:

```bash
#!/bin/bash

rnd=$RANDOM

echo "The number is: $rnd"
echo "Lesser square numbers are: "

for (( i=1; i*i < $rnd; i++ )); do
  echo -n "$((i*i)) "
done
```

### 3. példa
Kérjünk be egy `N` értéket, és írjuk ki az első `N` Fibonacci számot, ahol nullát vesszük a
nulladik Fibonacci számnak. Ellenőrizzük, hogy `N` egy legalább 2 értékű egész szám!

```bash
read -p "Please, give the value of N (at least 2):" N

reg_ex='^[0-9]+$'
if [[ ! $N =~ $reg_ex ]]; then
    echo "N must be a number!" 1>&2
    exit 1
fi

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

### 4. példa
Írjunk egy shell scriptet, ami bemeneti paraméterként egyetlen pozitív számot vár (hibát ír, ha nem
ezt kap). A program feladata, hogy kiírja, hogy a kapott szám prím-e.

```bash
if [ $# -lt 1 ]; then 
    echo "No number provided as input." 1>&2
    exit 1
fi

num=$1
re='^[0-9]+$'
if ! [[ $num =~ $re ]] ; then
    echo "error: Not a positive number." 1>&2;
    exit 1
fi

if [ $num -le 1 ]; then
    echo "Not prime."
    exit 0
fi

square_root=$(echo "scale=0; sqrt($num)" | bc)

for ((i=2;i<=square_root;++i)); do
    if [ $((num % i)) -eq 0 ]; then
        echo "Not prime."
        exit 0
    fi
done

echo "Prime."
```

## Tömbök
Bashben a tömbök használata kötetlenebb, mint egy C-szerű nyelvben. A tömb létrejöttekor nem kell tudnunk
annak a hosszát. A gyakorlatban a tömbök inkább listaként üzemelnek, és ezt látjuk is majd a következő
kódokban.

Egy tömböt az alábbi módon deklarálhatunk:

```bash
declare -a arr
```

A tömb elemeinek az alábbi módon adhatunk értéket. A sorrend nem kötött, és elemeket ki is hagyhatunk.
Ilyenkor a kihagyott elemek üresek lesznek.

```bash
arr[0]=12
arr[1]=3
arr[5]=6
```

Ha el akarjuk érni a tömb egy elemét, akkor a következő szintaxissal tehetjük meg:

```bash
echo ${arr[1]} # a második elem
```

Egy tömböt deklarálhatunk és inicializálhatunk egyszerre. A következő kód létrehoz egy tömböt, és 
kiírja a tartalmát:

```bash
declare -a arr=(12 3 6)

# ${#arr[*]} megadja nekünk a tömbelemek számát
for ((i=0;i<${#arr[*]};++i)); do 
    echo ${arr[i]}
done
```

A `for` ciklusnak akad egy másik, hasznos szintaxisa is, amit `for-each` ciklusként szoktak emlegetni,
és a legtöbb imperatív nyelvben megtalálható.

```bash
declare -a arr=(12 3 6)

# ${arr[*]} a tömb minden elemét adja vissza
for element in ${arr[*]}; do 
    echo $element
done
```

Érdekesség, hogy a program bemeneti paramétereinek listáját, és akár egy parancs kimenetét is megkaphatjuk
tömbként. Így könnyű végigiterálni rajtuk `for-each` ciklussal. A további példák a tömbökkel foglalkoznak.

### 5. példa
Írjuk ki összes argumentumot, amit a program kapott!

```bash
for i in $*; do
    echo $i
done
```

### 6. példa
Listázzuk egy directory tartalmát, minden egyes fájlt és mappát számozottan!
A directory elérési útját bemeneti paraméterként kapjuk meg. Ellenőrizzük, hogy kaptunk-e bemeneti
paramétert, és hogy az tényleg egy létező directory-e!

```bash
#!/bin/bash

# Itt azt nézzük, hogy üres-e a változó
if [[ -z $1 ]]; then
    echo "No input given." 1>&2
    exit 1
fi

if [[ ! -d $1 ]]; then
    echo "Not an actual directory." 1>&2
    exit 1
fi

i=0
for name in $(ls $1); do
    echo "$i: $name"
    i=$((i+1))
done
```


### 7. példakód
Töltsünk fel egy 10 elemű tömböt véletlen számokkal, majd menjünk végig a számokon és növeljük meg őket
1-gyel!

```bash
#!/bin/bash

declare -a arr

for ((i=0; i<10; ++i)); do
    # random szám 0-tól 99-ig
    arr[$i]=$((RANDOM % 100))
    printf "${arr[$i]} "
done
echo

for ((i=0; i<10; ++i)); do
    arr[$i]=$((arr[i] + 1))
done

for element in ${arr[*]}; do
    printf "$element "
done
echo
```

### 8. példa
Hozzunk létre egy N elemű tömböt, ahol N-t `read` paranccsal kérjük be, és ellenőrizzük, hogy 
pozitív egész szám (hibával visszatérünk, ha nem az). Töltsük fel véletlen számokkal a tömböt,
ahol a véletlen számok az \[1-100\] intervallumból kerülnek ki! Ezután végezzük el a következő
műveleteket a tömbre:
- Minimum elem kiíratása (hányadik elem és mi az értéke).
- Maximum elem kiíratása (hányadik elem és mi az értéke).
- Írjuk ki az elemek összegét.
- Írjuk ki az elemek átlagát.


```bash
read -p "Please type the size of the array!" N

re='^[0-9]+$'
if ! [[ $N =~ $re ]] ; then
    echo "error: Not a positive number." 1>&2;
    exit 1
fi

if [ $N -eq 0 ]; then
    echo "error: Array size is 0." 1>&2
    exit 1
fi

declare -a arr

for ((i=0; i<N; ++i)); do
    # random szám 1-től 100-ig
    arr[$i]=$((RANDOM % 100 + 1))
    printf "${arr[$i]} "
done
echo

sum=arr[0]
mini=0
maxi=0
for ((i=1; i<N; ++i)); do
    if [ ${arr[$i]} -gt ${arr[$maxi]} ]; then
        maxi=$i
    fi
    if [ ${arr[$i]} -lt ${arr[$mini]} ]; then
        mini=$i
    fi
    sum=$((sum + arr[i]))
done

echo "Minimum: $mini - ${arr[$mini]}."
echo "Maximum: $maxi - ${arr[$maxi]}."
echo "Sum: $sum."
avg=$(echo "scale=4; $sum / $N" | bc)
echo "Average: $avg."
```

## Feladatok
Önálló feladatok gyakorlásra.

### 1. feladat
Kérjünk be egy pozitív egész számot a felhasználótól, majd írjuk azokat a páratlan, pozitív
egészeket, amik ettől a számtól kisebbek!

### 2. feladat
Valósítsuk meg a 6. példában írtakat, de ezúttal a scriptünk tetszőleges mennyiségű input 
directory-t fogadhat. Ellenőrizzük, hogy kaptunk legalább egy bemeneti paramétert, és hogy
minden bemeneti paraméter directory-e. Ha igen, akkor írjuk ki mindegyik tartalmát! A 
számozást ne szakítsuk meg!

### 3. feladat
Írjunk egy scriptet, ami letölti a következő .zip fájlt az internetről:
*https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/nums.zip*


A script tömörítse ki a mappát, majd másolja át az összes `.txt` fájlt belőle egy 
`out_nums` mappába, de úgy, hogy a `.txt` fájlok minden olyan sorát, ahol szám van,
ossza el kettővel!
