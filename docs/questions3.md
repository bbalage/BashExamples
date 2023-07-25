# 3. Kérdések
Ellenőrző kérdések a harmadik gyakorlathoz.

### 1. kérdés
Mit ír ki az alábbi parancs, ha `dir_1` létezik, és be lehet lépni
(az esetleges hibaüzenet nélkül)?

```bash
mkdir dir_1 || echo "OK"
```

### 2. kérdés
Mit ír ki az alábbi parancs, ha `dir_1` nem létezik (az esetleges hibaüzenet nélkül)?

```bash
mkdir dir_1 && echo "OK"
```

### 3. kérdés
Mit ír ki az alábbi parancs, ha `dir_1` létezik (az esetleges hibaüzenet nélkül)?

```bash
mkdir dir_1 || mkdir dir_1 && echo "OK"
```

### 4. kérdés
Mit ír ki az alábbi parancs, ha `dir_1` nem létezik (az esetleges hibaüzenet nélkül)?

```bash
cd dir_1 || echo "Making directory" && mkdir dir_1 && echo "OK" || echo "Problem"
```

### 5. kérdés
Mit ír ki az alábbi parancs, ha `dir_1` létezik (az esetleges hibaüzenet nélkül)?

```bash
cd dir_1 || echo "Making directory" && mkdir dir_1 && echo "OK" || echo "Problem"
```

### 6. kérdés
Mit ír ki az alábbi parancs, ha `dir_1` létezik, de nincs jogunk belépni
(az esetleges hibaüzenet nélkül)?

```bash
cd dir_1 || echo "Making directory" && mkdir dir_1 && echo "OK" || echo "Problem"
```

### 7. kérdés
Ír-e hibát az alábbi parancs, ha `dir_1` nem létezik?

```bash
cd dir_1 > /dev/null
```

### 8. kérdés
Ír-e hibát az alábbi parancs, ha `dir_1` létezik?

```bash
mkdir dir_1 3> /dev/null
```

### 9. kérdés
Ír-e hibát az alábbi parancs, ha `dir_1` nem létezik?

```bash
ls dir_1 2> /dev/null
```

### 10. kérdés
Üres lesz-e az `xyz.txt` fájl a következő parancs után, ha `dir_1`
nem létezik?

```bash
cd dir_1 2> xyz.txt
```

### 11. kérdés
Üres lesz-e az `xyz.txt` fájl a következő parancs után, ha `dir_1`
nem létezik?

```bash
cd dir_1 1> xyz.txt 2> zzz.txt
```

### 12. kérdés
Hány sort fog tartalmazni a `records.txt` fájl a következő parancsok 
után?

```bash
echo "John;29" > records.txt
echo "Alice;32" >> records.txt
echo "Marlon;50" >> records.txt
echo "Dracula;598" >> records.txt
cp records.txt records_2.txt
cat records_2.txt | grep "8" > records.txt
```

### 13. kérdés
Hány sort fog tartalmazni a `records.txt` fájl a következő parancsok 
után?

```bash
echo "John;29" > records.txt
echo "Alice;32" >> records.txt
echo "Marlon;50" >> records.txt
echo "Dracula;598" 2>> records.txt
cp records.txt records_2.txt
cat records_2.txt | grep "5" > records.txt
```

### 14. kérdés
Hány sort fog tartalmazni a `records.txt` fájl a következő parancsok 
után?

```bash
echo "John;29" > records.txt
echo "Alice;32" >> records.txt
echo "Marlon;50" >> records.txt
echo "Dracula;598" >> records.txt
cp records.txt records_2.txt
cat records_2.txt | grep "2" >> records.txt
```