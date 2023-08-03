# 7. Kérdések
Ellenőrző kérdések a hatodik gyakorlathoz.

### 1. kérdés
Mit csinál az alábbi kód?

```bash
#!/bin/bash

for i in $*; do
    echo $i
done
```

a. Kiírja a bemeneti argumentumokat.\
b. Kiírja a bemeneti argumentumok számát.\
c. Megszámolja a bemeneti argumentumokat.\
d. Hibára fut.

### 2. kérdés
Mit ír ki az alábbi kód?

```bash
#!/bin/bash

i=0
until [ $i -lt 10 ]; do
    i=$((i + 2))
    echo $i
done
```

a. Kiírja a páros számokat 2-től 10-ig.\
b. Kiírja a páros számokat 0-tól 8-ig.\
c. Nem ír ki semmit.\
d. Hibát ír.

### 3. kérdés
Mit ír ki az alábbi kód?

```bash
#!/bin/bash

i=0
j=20
while [ $i -lt $j ]; do
  echo $((i + j))
  i=$((i + 1))
  j=$((j - 2))
done
```

a. Hibára fut.\
b. A számokat 20-tól 14-ig.\
c. A számokat 20-tól 15-ig.\
d. A számokat 19-tól 14-ig.