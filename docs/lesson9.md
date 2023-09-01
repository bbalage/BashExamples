# 9. óra
Ezen a gyakorlaton elengedjük a Bash nyelv használatával kapcsolatos technikai ismereteket.
Ehelyett megtekintünk néhány használati esetet.

Alapvető megállapítás (triviális), hogy egy nyelv csak annyira lehet hasznos, amennyi
szituációban hasznát tudjuk venni. A Bash nyelvet nem számítógépes játékok vagy komplex
grafikus alkalmazások fejlesztésére találták ki. Legjobban rendszergazdai feladatokhoz,
egyszerű parancssori automatizálásokhoz, installációs szkriptekhez működik. Mivel az
ilyenek hosszúra nyúlhatnak, ezek helyett összegyűjtöttem pár olyan szituációt,
amelyekben a Bash nyelv hasznomra vált az évek során. Ezek nagyrészt rövidek lesznek.

Az alábbiakban érdemi sorrend nélkül következnek a használati esetek.

## Hasznos példák

### Az `ssh` parancs
Talán a leghasznosabbal indítottam. `ssh` = Secure Shell. Gyakori, hogy a parancssort nem 
azon a gépen akarjuk használni, amin éppen vagyunk. Az `ssh` megengedi a távoli parancssori 
elérést.

```bash
ssh username@jerry.iit.uni-miskolc.hu
```

Az alábbi parancsot kiadhatjuk akár egy Linuxos, akár egy Windowsos gép termináljában, és
segítségével rácsatlakozunk egy távoli gépre. A távoli gép jelenleg egy szerver, ami a 
`jerry.iit.uni-miskolc.hu` címen elérhető. A `@` elé beütjük a felhasználónevet, amivel 
be kívánunk jelentkezni. Ezután a parancs megkérdezi, hogy elfogadjuk-e az új `ssh`
kapcsolat fingerprintjét (beírjuk, hogy *yes*). Ezt követően be kell írnunk a jelszavunkat,
és már kész is a távoli kapcsolat!

Innentől úgy kezelhetjük a terminált, mintha ott lennénk a távoli gépen. Ha le akarunk
csatlakozni, csak adjuk ki a `logout` parancsot!

Hasznos ez a következő esetekben:
- A szerver messze van, de dolgoznod kell rajta. Karbantartási, rendszergazda munka, devops
feladatok.
- A `jerry` szerverre kell csatlakoznod, mert valami beadandót kell rajta csinálnod.
- A szerveren nincs grafikus felület (ez gyakori). Ilyenkor egyszerűbb `ssh` parancsot
használni, mint levinni egy monitort és billentyűzetet a szerverterembe.
- Kis készülékre, tipikusan Raspberry PI-re telepítettél Ubuntut vagy Raspbiant, és 
a kis kütyü már benne van egy robotban. Csatlakoznod kell, de nem akarsz monitort és 
billentyűzetet vinni magaddal a robotra.

### Az `scp` parancs
Emlékszünk a `cp` parancsra? Fájlok másolására szolgált. Ugyanaz az `scp` is, csak *Secure* Copy.
Mint az `ssh` parancs, ez is gépek közötti másolásra szolgál. Ha `ssh`-val csatlakozol a 
távoli gépre, akkor sok dolgot megtehetsz *azon* a gépen, de ha a saját gépedről akarsz
odamásolni valamit, akkor valami egyéb parancsra van szükséged.

Az alábbi példa egy fájlt másol a gépemről a `jerry`-s szerverre, a saját felhasználói
fiókomba.

```bash
scp some_file.txt bolyki@jerry.iit.uni-miskolc.hu:~/foldername/
```

Ugyanúgy jelszót kell majd beírni, mint `ssh` esetén, de a jelszó beírása után a `some_file.txt`
nevű fájl *erről a gépről* átmásolódik *arra a gépre*. A másik gép címe után kettőspontot
rakunk, és a kettőspont után írjuk a fájl új elérési útvonalát. A fönti esetben a `home`
mappámban lévő `foldername` nevű mappába fog kerülni a fájl.

Megjegyzem, hogy az `rsync` parancs is ilyesmire szolgál, de soha nem tanultam meg a működését.
Az `scp` egyszerű, egyértelmű, és mindenre elég volt, amire nekem kellett.

### `sudo apt install`
Amint saját rendszert telepítesz, szemben fogod magad találni ezzel a paranccsal. Ez Ubuntun
így néz ki, bár Arch Linuxon máshogy fog. Az `apt` az Ubuntu csomagkezelője. A hivatalos
repository-ból tudsz csomagokat letölteni és installálni vele. Szinte minden installációs 
tutorialban találkozni fogsz vele, úgyhogy nem ragozom tovább. Jobb, mint a next-next-finish.

### A `tar`, `zip` és `unzip` parancsok
A JupyterLab szerveren jártam többször úgy, hogy nem tudtam mappát letölteni a felhasználói
felületről. A JupyterLabbal akkor fogtok találkozni, ha neurális hálókat tanítotok fel egy 
távoli gépen (egy erős szerveren, masszív videokártyákkal). A JupyterLabot el lehet 
érni böngészőben, és lehet Python kódokat futtatni benne. Ennek a dokumentumnak az írásakor 
viszont nem lehetett mappát letölteni róla. Sem feltölteni.

Szerencsére akad terminál is a szerveren, így lehet Bashben utasításokat adni. A megoldás az 
volt, hogy a mappából csinálok egy *zip* fájlt, és azt töltöm le, vagy töltöm fel. Kitömöríteni
sem lehet kattintgatással, csak terminálból.

Gondolom mostanra mindenki kitalálta, mire jó a `tar` és az `unzip` parancs.

A `tar` parancs neve a *Tape ARchive* szavakból jön. Eredetileg szalagra írt archívumokhoz 
találták ki. Lehet vele tömöríteni és kitömöríteni fájlokat, mappákat. Még saját fájl
kiterjesztése is van (*tar*). A tömörített archívumokat kétszeres kiterjesztéssel szokták
használni, `archive_name.tar.gz` szintaxissal. Egy mappát az alábbi módon tudunk tömöríteni:

```bash
tar cfzv archive.tar.gz foldername
```

A létrejött archívum neve `archive.tar.gz` lesz. Kitömöríteni az alábbi módon tudjuk:

```bash
tar xfzv archive.tar.gz
```

A `tar` parancs irodalma ennél jóval bővebb, de én 95%-ban csak ennyit használtam belőle.
Az `xfzv` 4 darab kapcsoló összevonva, a `cfzv` szintúgy. Érdekesség, hogy melyik mit jelent:
- x= eXtract (csomagold ki).
- c= Compress (csomagold be).
- f= File (a következő fájlnévvel hozd létre az archívumot).
- z= gZip (gzip tömörítésű fájlon fog dolgozni).
- v= Verbose ("bőbeszédű", kiírja milyen fájlokon dolgozik, miközben csomagol / kicsomagol).

A `zip` és `unzip` parancs ennek az egyszerűbb verziója, ezért szeretem jobban. Ha csak egy *zip*
fájlt akarsz becsomagolni és kicsomagolni, akkor könnyebbet nem is kereshetnél.

```bash
# Becsomagolja a my_folder mappát egy my_archive.zip fájlba
zip -r my_archive.zip my_folder # -r is for recursive
# Kicsomagolja a my_archive.zip mappát
unzip my_archive.zip
```

A `tar` parancs egy svájci bicska az archívumok készítésére, tömörítésre, kitömörítésre. A `zip` és 
`unzip` csak annyi, amennyit a nevük mond. Nekik is vannak kapcsolóik, amikről érdemes lehet 
olvasni, ha használod őket. A fönti példa azonban lefedi a használati esetek 95%-át (nálam).

### Az `sl` parancs
Az előző parancsok hosszúra sikerültek, ezért ez egy fellélegzős parancs lesz.
Programozó vagy és szereted megviccelni magad? Az `sl` parancsot neked találták ki!

Mi az egyik leggyakrabban beütött parancssori utasítás? Igen, az `ls`.

Mi az egyik leggyakoribb elgépelési forma? Igen, a karakterek felcserélése. Tehát `sl`.

Nem is lennél igazi mérnök, ha időről időre nem csinálnál hülyét magadból. Az `sl` parancs
karaktergrafikusan meganimál egy elhaladó vonatot neked, valahányszor elgépeled az `ls` parancsot.
Lehet installálnod kell, de megéri (a tanszéki gépekre az illetékes már volt kedves felrakni).

```bash
sl
```

### A `cowsay` parancs
Az `sl` parancs egyik ismert párja. Karaktergrafikusan kirajzol egy tehenet, ami mond neked valamit.
Miután 3 órája szívsz egy beadandóval, bizonyára valami kedveset fog mondani.

```bash
cowsay "You suck."
```

### A `history` parancs
Most térjünk vissza pár olyan parancsra, amik tényleg hasznosak. A `history` parancs már mentette 
meg párszor az életemet. Remélem a félév végére már rájöttél, hogy a terminálban, ha fölfelé 
nyilat nyomsz, akkor az előző parancsokon tudsz végiggörgetni. Mi van, ha hirtelen szükséged
lesz arra a parancsra, amit 200 paranccsal ezelőtt ütöttél be? Nagyon hosszú parancs volt, nem 
emlékszel a paraméterlistájára, de tudod, hogy például `gcc`-vel kezdődött.

A `history` parancs siet a segítségedre. Kiírja neked az adott terminálhoz tartozó korábban kiadott
parancsok listáját. Kombináld a `grep` paranccsal, hogy még kevesebbet kelljen szívnod vele!

```bash
history | grep "gcc"
```

### A `kill` és a `ps` parancs
Nem vagy programozó, ha még nem rontottál el semmit. Időnként annyira el lehet rontani, hogy
le se tudod lőni a sz*r programot, amit indítottál. A terminálos programokat általában meg lehet 
ölni `Ctrl+C`-vel. Létezhet viszont olyan eset, amikor egyenesen meg kell ölnöd egy programot a
PID-je (Process Id) alapján.

Először meg kell találnod a parancs PID-jét. Többek között erre jó a `ps`. Add ki a következő 
kapcsolókkal, hogy mindent is láss!

```bash
ps awux
```

Üdv a Linuxos parancskezelőben! A gépen futó összes programot láthatod. Több ezer van. Használd a
`grep`-et, hogy rátalálj a saját programodra.

```bash
ps awux | grep "my_crazy_program"
```

Bal szélen az a felhasználó van, akinek a jogaival fut a program. A saját felhasználónevedet és a 
`root` felhasználót biztosan látni fogod. A következő oszlopban a PID van. A PID alapján le tudsz
állítani egy programot erőszakkal.

```bash
kill -9 10234
```

A fönti parancs leállítja a 10234-es PID-del rendelkező futó programot (processzt). OS-ből erről
többet fogtok tanulni, de megjegyeznék itt valamit:

**Megjegyzés:** A `kill` parancs neve becsapós. Nem programok leállítására szolgál, hanem arra, hogy 
jelet küldjünk nekik. A 9-es jel a SIGKILL, tehát az **azonnali** leállításra vonatkozó jel. Ha
másféle jelet
küldünk, akkor a program másként reagál. Például ha lenyomjuk a `Ctrl+C` billentyűket, akkor 
is jelet küldünk, csak egy másikat, a SIGINT parancsot (Interrupt). Általában ez is megöli a
programot, de SIGKILL egészen biztosan.

**Még egy megjegyzés:** Gondolom mondanom sem kell, hogy ha elkezdünk ész nélkül programokat 
öldösni a rendszerünkben, akkor az valószínűleg hibákhoz fog vezetni.

### A `gcc` parancs
Van olyan eset, főleg Linux alatt, főleg az OS tantárgy gyakorlatán, hogy terminálban kell C
programokat fordítani és futtatni. A C fordító a legtöbb Linux rendszeren a `gcc` lesz.

Ha van egy egyfájlos C kódod, amit le akarsz fordítani és futtatni, akkor megteheted a következőt:

```bash
gcc my_prog.c -o my_prog # compile
./my_prog # run
```

Nyilván nagy programoknál nem javaslom ezt a módszert, de kicsiknél elég ennyi is. Ha külső
könyvtárat használsz a programodban, akkor azt esetleg linkelned kell:

```bash
gcc my_prog.c -o my_prog -lSDL # compile
./my_prog # run
```

Az SDL (vagyis inkább SDL2) egy videojáték készítéshez jól használható könyvtár (alacsony szintű,
ezért programozni vágyóknak ajánlom).

### A `cloc` parancs
Benne vagy egy nagy saját projektben vagy beadandóban? Írod már egy hete, és kíváncsi lettél, hogy 
mégis mennyit írtál eddig? Kíváncsi lettél, hány soros a kódod, mennyivel dicsekedhetsz el?

A `cloc` parancs (Count Lines Of Code) Linux alatt egy könnyen installálható kis utility.

```bash
cloc src
```

A fönti parancs megszámolja az `src` mappában lévő kódsorok számát, nyelv szerint.

### Egyebek
A legtöbb programnak, programnyelvnek, keretrendszernek, amit használni fogtok az egyetem és a 
munka során, van valamilyen parancssori interfésze (CLI - Command Line Interfész). Tipikus példa a 
`git`. Én szeretem a parancssori `git`-et, más kevésbé. De itt nem áll meg a sor. Csak néhány
parancssori felület, amit használnom kellett:
- `gcc` a C nyelvhez.
- `g++` a C++ nyelvhez.
- `java` és `javac` a Java nyelvhez.
- `node`, `npm`, `ng` a webfejlesztéshez (Node szerver, Node csomagmenedzser, Angular CLI).
- `docker` a virtuális gépek menedzseléséhez. Itt is előjött az, hogy meg kellett találni a virtuális
gépek azonosítóit, majd le kellett lőni őket, esetleg törölni és újragenerálni őket. Sokat segített
a `grep` parancs.
- `cmake` a komplexebb C, C++ projektek buildeléséhez és installálásához.

Ezekkel vagy fogtok találkozni, vagy nem, de jó tudnotok, hogy a command line nem ér véget
Számítógépi Architektúrák tantárggyal.

## Parancsok, amik segíthetnek a beadandóban

### A `w` és a `who` parancs
Arra valók, hogy adatokat tudjunk meg az épp bejelentkezett felhasználókról, legutóbbi belépésükről,
stb. Vannak olyan beadandó feladatok, amik ezekre építenek.

### A `read` parancs kapcsolói
Akadnak játékok is a beadandók között. Bár alapesetben nem javasolnám, hogy bárki Bashben készítsen
játékot, de a beadandó talán izgalmasabb és élvezetesebb, ha nem egy APEH szimulátort írtok, hanem
egy Pongot. Egy valós idejű játéknál (ami nem körökre osztott, mint az amőba), jól jöhet a `read`
parancs `-t` kapcsolója. Ez egy *timeout*-ot ad a parancshoz, vagyis ha nem ütsz le semmit, akkor 
program folytatódik. Mint egy játékban.

Ezenfelül jól jöhet az is, hogy a `read` parancsnak megadható, hogy csak egy karaktert várjon.
Egy billetyűlenyomást pont elég egyszerre kezelni. Ha olyan játékot akarsz írni, ahol egyszerre 
több billentyű kell, akkor tényleg keres másik programnyelvet.

A `read` parancsot el is lehet hallgattatni az `-s` kapcsolóval (így ha leütsz valamit, akkor 
az nem fog megjelenni a terminálban).

Egy példa a használatára:

```bash
playing=1
while [[ $playing -eq 1 ]]; do
    read -n1 -t 0.1 -s user_keypress
    if [[ $user_keypress == "w" ]]; then
        echo UP
    elif [[ $user_keypress == "s" ]]; then
        echo DOWN
    elif [[ $user_keypress == "a" ]]; then
        echo LEFT
    elif [[ $user_keypress == "d" ]]; then
        echo RIGHT
    elif [[ $user_keypress == "x" ]]; then
        playing=0 # exit
    fi
    echo "Computer takes action."
done
echo "Game over"
```

A fönti példában a `read` parancs egy karaktert vár, és 0.1 másodperc után továbblép, ha addig
nem érkezik felhasználói input. Az `-s` kapcsoló miatt a felhasználói input nem kerül ki a terminálra.
Erre az alapra ráírhatod a Pongot, vagy bármi egyéb egyszerű, karaktergrafikus játékot.