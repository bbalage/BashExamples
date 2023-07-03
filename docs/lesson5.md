# 5. óra

A korábbiakban megtekintettük, hogy a Bashben elérhető toolokat milyen mechanikákkal
tudjuk kombinálni, saját algoritmust viszont egyszer sem alkalmaztunk. Amennyiben 
ezt szakszavakkal akarjuk kifejezni, akkor azt mondjuk, hogy eddig a Bash **deklaratív**
használatával foglalkoztunk. Nem lehet azonban mindent leírni deklaratívan, ugyanis 
a deklaratív nyelvi elemek mögött is **imperatív** megvalósítások vannak. Elkerülhetetlen,
hogy akadjanak lefedetlen használati esetek.

A Bash nyelvben az ilyen esetekre beleraktak imperatív elemeket, amiket már más tárgyakból
ismerünk. Vannak változók, tömbök, if-else vizsgálatok, ciklusok (for és while is), 
függvények. Azonban megjegyzendő, hogy **egy Bash-hez hasonló shell script nyelv akkor 
működik a legjobban, ha egyszerű dolgokat akarunk vele gyorsan megfogalmazni**. Nem az a 
célja, hogy bonyolult, részletesen megtervezett, finoman strukturált programok készüljenek
benne.

Létezik egy **KISS** nevű programozási elv, ami itt fokozottan igaz.
KISS = "Keep it Simple, Stupid!" Ha elkezd nagyon bonyolulttá válni a Bash programunk, akkor 
lehet nem Bashben kéne írni. A következő szerkezeteket tehát használjuk ésszel, és minél
kevesebbet kell belőlük bevetnünk, annál jobb. Időnként azonban megkönnyítik az életünket,
így lássunk hozzá.

## Változók
Bash-ben a legegyszerűbben a következőképpen lehet változót deklarálni:

```bash
greeting="Hello World!"
```

A változónak mindegy, hogy létezett-e korábban. Ezenfelül a Bash egy *loosely typed* nyelv
(lazán típusos), vagy más néven *dynamically typed* (dinamikusan típusos). Ez annyit jelent,
hogy a típust sem kell megadnunk, ugyanis az **futásidőben** fog kiértékelődni. Ez ellentétes a 
C-vel és társaival, amelyek *statikusan típusosak*, tehát nekik **fordításidőben** kell 
tudni a típust.

Ha valamilyen speciális tulajdonságot akarunk adni egy változónak létrehozáskor, akkor 
a `declare` paranccsal és kapcsolóival kell deklarálnunk. A következő használati eseteket 
nézzük:

```bash
declare -i num=10 # az -i kapcsolóval egész számként deklarál
declare -r constant_thing=10 # az -r kapcsoló read only változóként deklarál
# az -a kapcsoló tömbként deklarál, de majd később megnézzük
# az -x kapcsoló exportál, de erre aligha lesz szükségünk a tárgy során
```

Amennyiben törölni akarunk egy deklarált változót, azt az `unset` paranccsal tehetjük meg.

```bash
unset num
unset constant_thing # hiba, mert constans. Nem tudjuk törölni
```

Egy parancs tartalmát is változóba helyezhetjük a következőképpen:

```bash
content=$(ls -la)
```

Ha a változó tartalmát el akarjuk érni, akkor a változó elé `$` jelet kell raknunk. Ez 
azért van, mert enélkül az interpreter nem tudja, hogy a változó tartalmát, és nem a beírt
szöveget akarjuk használni. A következő példában ez látható:

```bash
greeting="Helloka"
echo greeting # kiírja, hogy greeting
echo $greeting # kiírja, hogy Helloka
content=$(ls -la)
echo $content # kiírja, amit az ls -la parancs kiírt volna.
```

Akadnak előre definiált környezeti változók. Ilyen például a `USER`, ami a shellbe belépett
felhasználót tárolja (tehát a mi felhasználónevünket), vagy a `HOME`, ami a felhasználó home 
mappájának elérési útját adja meg.

```bash
echo $USER
echo $HOME
```

Ha kíváncsiak vagyunk az összes beállított környezeti változóra, akkor az `env` paranccsal 
kiírhatjuk őket.

```bash
env
```

Egy változó értéke könnyedén beilleszthető egy szövegbe is. Például a következőképpen:

```bash
greeting=Helloka
echo "Hello $USER!"
echo "$greeting dear friend!"
echo "$greeting $USER! You live at $HOME."
```

Ha azt akarjuk, hogy a Bash a szövegben ne értelmezzen változókat, akkor vagy rakunk egy 
backslash karaktert a dollárjel elé, vagy egyszeres idézőjelek között írjuk a szöveget.
A következő kettő ugyanazt írja ki:

```bash
greeting=Helloka
echo "\$greeting dear friend, \$USER!"
echo '$greeting dear friend, $USER!'
```

Amennyiben a változó nem volt valamilyen értékkel feltöltve, akkor a parancsértelmező egyetlen 
whitespace karakterként fogja kezelni:

```bash
echo "something is $nothing at all."
# Output: something is  at all.
# Nincs hiba!
```

Mivel a terminál egyfajta szövegértelmező is, többnyire szövegekkel fogunk dolgozni, de 
lehet számokkal is műveletet végezni. Ehhez azonban egy speciális szintaxis kell. Nem fogjuk
szeretni, de emlékezzünk: ezt a nyelvet nem összeadásra és kivonásra találták ki, hanem 
fájlok, felhasználók, adatcsatornák, parancssori programok, stb. kezelésére. Ha komolyabb 
aritmetika kell, keressünk más nyelvet!

Az alábbiak mind helyesek:

```bash
a=5
b=7
c=$((a + b))
echo $c
c=$((5 + 9))
echo $c
echo $((80 / 60))
echo $((a-b))
echo $((a*b))
echo $((a%b)) # modulo
```

A dollárjel és kettős zárójel aritmetikai műveletekhez megfelelő. A két zárójelen belül nem 
kell a dollárjelet kirakni, kivéve, ha csak ez teszi egyértelművé a műveletet. Erre is látunk
majd példát rövidesen. Vegyük észre, a Bash nyelv egészosztásokkal dolgozik. **Nincs beepített
lebegőpontos típus!** Erre egy segédprogramot tudunk használni, amit később meg fogunk nézni.

A szövegkezeléshez és változódeklaráláshoz további műveletek is tartoznak. Példákon keresztül
meg fogunk nézni néhányat. A következő egy rövid összefoglaló:

- `echo` \``ls -la`\` ugyanaz, mintha `echo $(ls -la)` parancsot adnánk ki.
- `${valtozo:-ertek}` ha `valtozo` nem üres, akkor a változó értékét jelenti, egyébként az `ertek`
értékét.
- ...

## Bash szkriptek

Amelyik szkript változót generál, valószínűleg nem egysoros. Éppen ezért ezeket szeretnénk 
egy script fájlban eltárolni, hogy mikor a programunkat futtatni akarjuk, akkor ne kelljen
sorról sorra beírnunk a parancsokat. A Bash szkripteket tartalmazó fájlokat `.sh` kiterjesztéssel
szokás elmenteni (Windowson az ottani parancsértelmezőknek a `.bat`, `.cmd`, `.ps1`
kiterjesztések jellemzőek). Ezek egyszerű szöveges fájlok, amikbe a parancsainkat írjuk.

Nyissunk meg egyet a `nano` szövegszerkesztőben a `lesson5` mappában!

```bash
mkdir lesson5
cd lesson5
nano my_script.sh
```

Írjuk bele a következőt:

```bash
favourite_number=42
echo "The answer to everything is: $favourite_number"
```

Mentsük el a fájlt, aztán lépjünk vissza a terminálba! Futtassuk a következő paranccsal:

```bash
bash my_script.sh
```

Futtathatjuk a következőképpen is (és jellemző is így futtatni a parancssori futtatható fájlokat):

```bash
./my_script.sh
```

Ehhez viszont először bele kell írni a fájl első sorába a *a parancsértelmező elérési útját*.
A fájl tartalmát módosítsuk a következőre:

```bash
#!/bin/bash

favourite_number=42
echo "The answer to everything is: $favourite_number"
```

Így a fájl első sorából a parancsértelmező tudni fogja, hogy milyen script vagy futtatható 
állományként kell értelmeznie ezt a futtatott fájlt. Amennyiben nem így kívánjuk futtatni a 
fájlt, ez opcionális.

Megjegyzés: ekkor kell a futtatási jog is. Adjuk meg `chmod` paranccsal!

## Paraméterek

A szkript fájlok jók arra, hogy elmentsük benne a programunkat, és utána lefuttassuk.
Ezzel bizonyos gyakran ismétlődő folyamatok jól automatizálhatók, és programozóként tényleges
hasznát vehetjük. Keveset ér viszont, ha nem tudunk *paramétereket* adni szkriptünknek.

Vegyünk például egy scriptet, ami kiírja az összes olyan fájlt egy paraméterként kapott
mappában, ahol `root` a tulajdonos!

Írjuk a következőt egy `useless_printer.sh` nevű fájlba!

```bash
#!/bin/bash

echo $(ls -la ~ | grep root)
```

Eddig elég haszontalan a szkriptünk, ugyanis csak mappára és egy felhasználóra működik.
A szkriptek azonban parametrizálhatók, és meghívhatók a következőképpen:

```bash
bash useless_printer.sh dirname username
```

Ekkor már paramétereket adtunk a szkriptnek, csak éppen a szkript egyelőre nem kezd velük
semmit. Alakítsuk át a következőre:

```bash
#!/bin/bash

echo $(ls -la $1 | grep $2)
```

Tehát a következő mondható el:
- `$1`, `$2`, `$3`, stb. a szkript bemeneti paramétereihez nyújtanak elérést.
- `$#` megmondja a bemeneti paraméterek számát.
- `$*` vagy `$@` a parancssori paramétereket egyben adja meg; ilyenkor lehet tömbként 
kezelni őket, végigiterálni rajtuk; később megnézzük.
- `$$` a szkriptet futtató program parancsazonosítója.
- `$?` a legutóbb végrehajtott parancs visszatérési értéke. Hibakezeléshez használható.

## Példák
