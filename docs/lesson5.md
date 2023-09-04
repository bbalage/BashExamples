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

Az integernek deklarálás elvégez pár ellenőrzést, és hibákat is dob, de váratlan viselkedéseket
produkálhat annak, aki nem ismeri ki magát jól a nyelvben.

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
kell a dollárjelet kirakni. Vegyük észre, a Bash nyelv egészosztásokkal dolgozik. **Nincs beepített
lebegőpontos típus!** Erre egy segédprogramot tudunk használni, amit később meg fogunk nézni.

A szövegkezeléshez és változódeklaráláshoz további műveletek is tartoznak. Példákon keresztül
meg fogunk nézni néhányat. A következő egy rövid összefoglaló.

- `echo` \``ls -la`\` ugyanaz, mintha `echo $(ls -la)` parancsot adnánk ki.
- `${valtozo:-ertek}` ha `valtozo` nem üres, akkor a változó értékét jelenti, egyébként az `ertek`
értékét.
- `${valtozo:=ertek}` ha `valtozo` értéke még üres, akkor az `ertek`-kel lesz egyenlő.
- `${valtozo:?ertek}` ha `valtozo` üres, akkor kiíródik az érték, és hibával exitál a program.
Ez jó egy változó vagy bemeneti paraméter meglétének ellenőrzésére.
- `${valtozo:+ertek}` ha `valtozo` nem üres, akkor `ertek`-et kapunk vissza.
- `${#valtozo}` visszaadja a `valtozo` változóban található szöveg hosszát.
- `${valtozo:3:5}` visszaadja a `valtozo` változóban található szöveg részszövegét (substring).
- `${valtozo/"thing"/"stuff"}` a `valtozo` változóban található szövegben az **első** "thing" szöveget
"stuff" szövegre cseréli (és visszaadja az új szöveget).
- `${valtozo//"thing"/"stuff"}` a `valtozo` változóban található szövegben az **összes** "thing"
szöveget "stuff" szövegre cseréli (és visszaadja az új szöveget).

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

A változókat nem csak bemeneti paraméterként adhatjuk meg, hanem be is olvashatjuk a felhasználótól.
Ez megtehető például a `read` utasítással:

```bash
read -p "Please type a number! " x

echo "The double of your number is: $((x * 2))"
```



## Példák

### 1. példa
Írjunk egyszerű programot, amely bekér a felhasználótól egy nevet és egy telefonszámot,
majd a következő formátumban kiírja azokat egy `cred.json` fájlba:

```
{
  "name" : "the name written by the user",
  "phone" : "the phone number written by the user"
}
```

A következő script például megvalósítja ezt:

```bash
#!/bin/bash

read -p "Please type your name: " name
read -p "Please type your phone number: " phone_num

echo "{" > cred.json
echo -n '  "name" : "' >> cred.json
echo -n "$name" >> cred.json
echo '",' >> cred.json
echo -n '  "phone" : "' >> cred.json
echo -n "$phone_num" >> cred.json
echo '"' >> cred.json
echo '}' >> cred.json
```

### 2. példa
Hozzunk létre egy shell script fájlt, mely bemeneti paraméterként beolvas két számot, és kiírja az 
- összegüket,
- különbségüket,
- szorzatukat,
- hányadosukat,
- osztási maradékukat a standard outputra.

Ha nem kerültek megadásra az adott bemeneti paraméterek, akkor mind a két szám legyen 42.

```bash
#!/bin/bash

a=${1:-42}
b=${2:-42}
echo "$((a + b))"
echo "$((a - b))"
echo "$((a * b))"
echo "$((a / b))"
echo "$((a % b))"
```


### 3. példa
Hozzunk létre egy shell script fájlt, amely egy paraméterként kapott txt fáljban a `happy` szó
minden előfordulását `not thinking about the vizsgaidőszak` szövegre cseréli, és elmenti 
az új szöveget egy `out.txt` fájlba.

Egy elkészített példafájl a következő linken letölthető:
https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/winnie_the_pooh.txt

```bash
#!/bin/bash

text=$(cat $1)

printf "${text//"happy"/"not thinking about the vizsgaidőszak"}" > out.txt
```

Magyarázat: az `echo` parancsot `printf` parancsra cseréltük. A szerepe ugyanaz, de jobban
kezeli a sortöréseket. Próbáljuk ki `echo`-val is, és látni fogjuk! Alapesetben mindegy
melyiket használjuk.

### 4. példa
Írjunk egy scriptet, amely leszed a következő url-ről egy text file-t, majd kiírja belőle 
a valid email címeket egy `emails.txt` fájlba, aztán törli az eredetileg letöltött fájlt.

Url: https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/file1.txt

```bash
#!/bin/bash

wget https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/file1.txt
cat file1.txt | grep "^[a-Z0-9.]\+@[a-Z0-9.]\+\.[a-Z]\{2,\}" > emails.txt
rm file1.txt
```

Magyarázat: a `wget` egy új parancs (web get), és letölt egy fájlt az adott url-ről.
A hasznosabb parancsok egyike.

### 5. példa
Kérjünk be két koordinátát a felhasználótól! Ezek legyenek egy téglalap két átellenes sarka.
A téglalap oldalai párhuzamosak a koordináta tengelyekkel (aki játékot szeretne programozni,
akkor annak ezek lesznek az Axis-Aligned téglalapok).
Írjuk ki a téglalap területét! A koordináták **nem** lehetnek lebegőpontosak!

```bash
#!/bin/bash

read -p "x1: " x1
read -p "y1: " y1
read -p "x2: " x2
read -p "y2: " y2

x_length=$((x2 - x1))
y_length=$((y2 - y1))
area=$((x_length * y_length))

echo "Area: ${area/-/}"
```

A végén van egy kis trükközés, ami valószínűleg ismeretlen víz számunkra. Gondoljunk bele, hogy 
a számítások során sehol nincs biztosítva az, hogy végeredmény ne legyen negatív. Márpedig a
terület nem lehet negatív. Ezt a végén biztosítjuk egy string művelettel.

A `${area/-/}` művelet lecseréli az `area` változóban talált első `-` jelet a semmire (tehát törli
azt).

Ugye emlékszünk, hogy a Bash nem matematikára való? Itt ez eléggé látszik. A következőnél még
jobban fog. Lássuk, hogyan lehet Bashben lebegőpontos számokat kezelni!

### 6. példa
Valósítsuk meg ugyanazt, mint az 5. példában, de ezúttal a koordináták lehetnek lebegőpontosak!

```bash
#!/bin/bash

read -p "x1: " x1
read -p "y1: " y1
read -p "x2: " x2
read -p "y2: " y2

area=$(echo "($x2 - $x1) * ($y2 - $y1)" | bc)

echo "Area: ${area/-/}"
```

A `bc` egy lebegőpontos számításokat végző segédprogram (szűrő). Megkap egy bemeneti szöveget,
amely lebegőpontos műveletsorként értelmezhető, és kiírja az eredményt a standard outputra.
Az `echo` és a csővezeték operátorral adunk inputot neki, és a `$()` szintaktikával
eltároljuk az outputot.

A trükközés a végén ugyanaz a negatív számmal.

## Feladatok

### 1. feladat
Hozzunk létre egy shell script fájlt, amely egy konfigurációs fájlt generál nekünk YAML 
formátumban. Ez egy rendkívül egyszerű formátum, ami jelen esetben így fog kinézni:

```yaml
username: first input
version: second input
site: third input
```

A shell kód kérje be az inputokat a felhasználótól, és hozza létre a `config.yml` fájlt az
inputoknak megfelelően!

### 2. feladat
Legyen adott a korábbi órákról ismert `people.csv` fájl. Írjunk egy olyan szkriptet, ami
kicseréli benne a gmail-es email címeket citromail-esre, és kiírja az új tartalmat a 
`strange_people.csv` fájlba!

### 3. feladat
Legyen adott a korábbi órákról ismert `people.csv` fájl. Írjunk egy olyan szkriptet, ami 
bemeneti paraméterként megkapja a keresett ember nevét, és kiírja az életkorát!
