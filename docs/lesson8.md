# 8. óra

A nyolcadik gyakorlaton a függvényekkel fogunk foglalkozni.

## Függvények
Bashben a függvények nem egészen úgy működnek, mint C-ben, vagy más imperatív nyelvekben.
Itt is szervezési egységek, amiket többször meghívhatunk a programunkban, vagy éppen olvashatóbbá
tehetjük általuk a kódunkat. A különbségük a szintaktikán kívül a visszatérési értékek kezelésében
van.

Legpraktikusabb úgy gondolni a Bash függvények, mintha maguk is scriptek vagy segédprogramok
lennének, mint például `cut`, `grep`, `cat`, stb. Míg C-ben a visszatérési érték többnyire arra
szolgál, hogy egy számított értéket visszaadjon nekünk, addig itt sikert vagy hibát jelez.

Legegyszerűbb megérteni példákon keresztül.

Bashben az alábbi módon tudunk függvényt definiálni, és meghívni:

```bash
f() {
    echo "Hello world!"
}

f
```

Az alábbi szintaxis is megengedett (tetszés kérdése):

```bash
function f {
    echo "Hello world!"
}

f
# Prints Hello world! 
```

Gondoljunk úgy a függvényre, mintha egy kisebb parancs lenne! Argumentumokat is ennek megfelelően
adunk neki:

```bash
function add_two_numbers {
    echo "$(($1 + $2))"
}

add_two_numbers 10 30
# Prints 40
```

Változóba tudjuk tenni a kimenetét, mintha parancs lenne.

```bash
function add_two_numbers {
    echo "$(($1 + $2))"
}

sum=$(add_two_numbers 10 30)
add_two_numbers $sum 15
# Prints 55
```

A visszatérési értéke nem arra szolgál, hogy az eredményt adja vissza, hanem hogy hibát jelezzen.
Például:

```bash
function add_two_numbers {
    regex="^[0-9]+$"
    if [[ ! $1 =~ $regex || ! $2 =~ $regex ]]; then
        echo "Must be two numbers!" 1>&2
        return 1 # We use "return", not "exit". "exit" would quit the entire script
    fi
    echo "$(($1 + $2))"
    # The default return value is 0
}

add_two_numbers 10 20 && echo "OK" || echo "Not OK" # This succeeds
add_two_numbers 10 e0 && echo "OK" || echo "Not OK" # This fails
```

A visszatérési értéket megkaphatjuk a `$?` kifejezéssel is, amely mindig a legutóbb kiadott parancs
vagy meghívott függvény visszatérési értékét adja vissza:

```bash
function add_two_numbers {
    regex="^[0-9]+$"
    if [[ ! $1 =~ $regex || ! $2 =~ $regex ]]; then
        echo "Must be two numbers!" 1>&2
        return 1 # We use "return", not "exit". "exit" would quit the entire script
    fi
    echo "$(($1 + $2))"
    # The default return value is 0
}

add_two_numbers 10 20
echo $? # Prints 0
add_two_numbers 10 e0
echo $? # Prints 1
```

Vegyük észre, hogy `return` utasítást használunk `exit` helyett, de ezen kívül minden ugyanolyan,
mintha egy scriptet írnánk. Hivatkozhatunk tehát a korábbi órákon tanultakra.

FONTOS: a változók láthatóságában különbség van a scriptek és a függvények között.
Az alábbi példa futtatásával ezt jól meg tudjuk figyelni:

```bash
x=10
f() {
    x=$((x+1))
    echo $x
}

f
f
f
```

A fönti kód 11, 12, 13-at ír ki. Ha C nyelves kifejezésekkel akarunk élni, akkor az `x` változót 
globálisnak mondhatnánk. Ha erre nem számítunk, akkor váratlan hibáink lesznek.

Egy változót felüldefiniálhatunk a `declare` kulcsszóval:

```bash
x=10
f() {
    declare x
    x=10
    x=$((x+1))
    echo $x
}

f
echo $x
# Prints 11, then 10
```

Vigyáznunk kell azonban a változók létrehozásakor. Az alábbi esetben `y` nem fog létezni a
függvényen kívül:

```bash
x=10
f() {
    declare y
    y=10
    y=$((y+1))
    echo $y
}

f
echo $x
echo $y
# y is unset by the end
```

Az alábbi esetben viszont már létezni fog:

```bash
x=10
f() {
    y=10
    y=$((y+1))
    echo $y
}

f
echo $x
echo $y
# y exists at the end, and it's 11
```

Trükkös, ugye? A következő kód jól szemlélteti, mi áll a háttérben:

```bash
x=10
f() {
    local y=11
    z=12
}

f
echo $x
echo $y
echo $z
# y exists at the end, and it's 11
```

Az `y` lokális, a `z` pedig nem, ezért `y` kívül nem látszik, `z` viszont igen.
A `declare` kulcsszó a függvényen belül lokális változókat fog létrehozni.
Az alábbi kódnál két `x` fog létezni, egy belső és egy külső (lokális és globális):

```bash
x=10
f() {
    local x=11
    echo $x
}

f
echo $x
# Prints 11 and 10
```

Most már láttuk, hogy a függvényeket hogyan lehet használni. Lássunk rájuk tényleges példákat!

## Példák

### 1. példa
Készítsünk egy függvényt, ami összeadja az argumentumban megadott számokat. Ha nem kap argumentumot,
akkor 0-t ír ki, egyébként az argumentumok összegét. Az argumentumokat nem szükséges ellenőrizni,
hogy számok-e.

```bash
#!/bin/bash

sum() {
    local x=0
    for i in $*; do
        x=$((x + i))
    done
    echo $((x))
}

sum 10 20 30
sum
```

### 2. példa
Írjunk függvényt, ami legenerál `N` darab véletlen számot egy [`x`-`y`] intervallumban. `N`, `x` és
`y` értékeit paraméterekként kapja meg a függvény.

Ellenőrzések nem szükségesek a függvényen belül. Ha bármelyik paramétert nem adják meg, akkor a 
default értékek legyenek a következők: `N=5, x=1, y=90`.

Generáltassunk a függvénnyel 10 véletlen számot 800 és 900 között, majd 15 számot -10 és 10 között!

```bash
#!/bin/bash

generate() {
    local N=${1:-5}
    local x=${2:-1}
    local y=${3:-90}
    range_size=$((y - x + 1))
    declare -a arr
    for ((i=0; i < N; ++i)); do
        rnd=$((RANDOM % range_size + x))
        arr[$i]=$rnd
    done
    echo ${arr[*]}
}

generate 10 800 900
generate 15 -10 10
```

## Feladatok

Feladatok önálló megoldásra.

### 1. feladat
Egészítsük ki a második példát úgy, hogy a generált számok egyediek legyenek, és generáltassunk
ötös lottó nyerőszámokat!

### 2. feladat
Készítsünk egy függvényt, ami egy vektort vár, és kiírja a vektor hosszát. A vektor dimenziója a 
bemeneti paraméterek száma. Ha nem kap bemeneti paramétert, akkor jelezzen hibát!

Írjunk egy scriptet, ami felhasználja ezt a függvényt! A felhasználótól kérjünk be egy vektort,
és számítsuk ki az egységvektorát (az egy hosszúságú irányvektor, tehát a vektor összes komponense
osztva a hosszával).