# 6. Kérdések
Ellenőrző kérdések a hatodik gyakorlathoz.

### 1. kérdés
Mit csinál az alábbi kód?

```bash
#!/bin/bash

reg_ex='^-?[0-9]+\.?[0-9]*$'
if [ $1 =~ $reg_ex ]; then
  echo "OK"
else
  echo "Not OK"
  exit 1
fi
```

a. Hibára fut.\
b. Ellenőrzi egy szövegről, hogy dátum-e.\
c. Ellenőrzi, hogy a bemeneti paraméter létezik-e.\
d. Ellenőrzi, hogy a bemeneti paraméter lebegőpontos szám-e.

### 2. kérdés
Mit csinál az alábbi kód?

```bash
#!/bin/bash

reg_ex='^-?[0-9]+\.?[0-9]*$'
if [[ $1 =~ $reg_ex ]]; then
  echo "OK"
else
  echo "Not OK"
  exit 1
fi
```

a. Hibára fut.\
b. Ellenőrzi egy szövegről, hogy dátum-e.\
c. Ellenőrzi, hogy a bemeneti paraméter létezik-e.\
d. Ellenőrzi, hogy a bemeneti paraméter lebegőpontos szám-e.

### 3. kérdés
Mit csinál az alábbi kód?

```bash
#!/bin/bash

if [[ ! -d build ]]; then
  mkdir build
fi
```

a. Buildeli a Bash kódot.\
b. Ha a `build` directory nem létezik, akkor létrehozza azt.\
c. Ha a `build` fájl törölhető, akkor törli azt.\
d. Ha a `build` directory létezik, akkor létrehozza azt.

### 4. kérdés
Mit csinál az alábbi kód?

```bash
#!/bin/bash

if [[ "thing.txt" -nt "thing (1).txt" ]]; then
  rm "thing (1).txt"
else
  rm thing.txt
  mv "thing (1).txt" thing.txt
fi
```

a. Törli a másodjára letöltött `thing.txt` fájlt.\
b. Ha `thing.txt` vagy `thing (1).txt` létezik, akkor törli azt.\
c. Törli a régebbit a `thing.txt` és a `thing (1).txt` fájlok közül.\
d. A `thing.txt` és `thing (1).txt` fájlok közül az újabbat hagyja meg `thing.txt` néven.

### 5. kérdés
Mit csinál az alábbi kód?

```bash
#!/bin/bash

if [[ -w thing.txt ]]; then
  rm thing.txt
  echo "OK"
elif [[ -e thing.txt ]]; then
  exit 1
  echo "Cannot delete." 1>&2
else
  echo "OK"
fi
```

a. Megpróbálja törölni a thing.txt fájlt, és hibát ír, ha nem törölhető, de létezik.\
b. Törli a thing.txt fájlt, ha az létezik, és hibát ír, ha nem létezik.\
c. Törli a thing.txt fájlt, ha az írható, és hibával kilép, ha nem írható, de létezik.\
d. Hibára fut.
