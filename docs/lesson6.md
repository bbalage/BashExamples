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

Látható, hogy az szavak `else-if` összevonódtak `elif` szóba.

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

Most már nagyjából mindent tudunk, amire a feltételes kódjainkhoz szükség lesz.
Lássunk példákat!

## Példák