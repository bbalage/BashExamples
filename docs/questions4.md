# 4. Kérdések
Ellenőrző kérdések a harmadik gyakorlathoz.

### 1. kérdés
Mik azok a szűrő parancsok?\
a. Minden parancs előtt lefutó ellenőrző utasítások.\
b. Egy fájl tartalmán dolgozó módosító operátorok.\
c. Egy bizonyos inputot befogadó, majd annak egy módosított verzióját
az outputra író parancsok.\
d. Adatbázis utasítások, amelyek csökkentik egy perzisztens fájlból
kinyert adat számosságát.

### 2. kérdés
Mik azok a reguláris kifejezések?\
a. Egy minta, amellyel megadható, hogy a kifejezés milyen szövegre illeszkedik.\
b. Formális nyelvi leírásai a felhasználói követelményeknek egy Bash programmal szemben.\
c. Egy formális nyelvi leírás, amely megmondja, hogy a felhasználói input helyes-e.\
d. Egy keresőmotornak megadható szöveges kifejezés, amellyel pontosabban lehet keresni egy
szöveges inputban.

----
Legyen a következő az `animals.csv` fájl tartalma:

```
Name,Species,Age
Szatyor,dog,4
Bejgli,dog,1
Raptor,cat,10
Feri,dog,8
Ducatti,parrot,2
Marcang,pig,5
Garfield,cat,4
Aragorn,dog,5
Charles,parrot,22
Siemens,parrot,10
Aragog,cat,2
Thor,dog,12
Pestis,dog,9
```

### 3. kérdés
Mit ír ki az alábbi kód?

```bash
cat animals.csv | grep '^Ara[a-z],'
```

### 4. kérdés
Mit ír ki az alábbi kód?

```bash
cat animals.csv | grep -E '^Ara[a-z],'
```

### 5. kérdés
Mit ír ki az alábbi kód?

```bash
cat animals.csv | grep -E '^Ara[a-z]+,'
```

### 6. kérdés
Mit ír ki az alábbi kód?

```bash
cat animals.csv | grep 'cat' 
```

### 7. kérdés
Mit ír ki az alábbi kód?

```bash
cat animals.csv | grep ',cat' | cut -f 1 -d ';' 
```
### 8. kérdés
Mit ír ki az alábbi kód?

```bash
grep ',cat' animals.csv | cut -f 1 -d ',' | sort
```

### 9. kérdés
Mit ír ki az alábbi kód?

```bash
head -1 animals.csv | cut -f 2 -d ','
```

### 10. kérdés
Mit ír ki az alábbi kód?

```bash
grep ',dog' animals.csv | sort | tail -1
```

### 11. kérdés (bónusz)
Az eddigiek alapján írjunk egy kódot, ami kiírja a legidősebb papagáj életkorát!