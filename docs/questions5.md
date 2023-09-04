# 5. Kérdések
Ellenőrző kérdések az ötödik gyakorlathoz.

### 1. kérdés
Melyik állítás igaz?

a. A Bash nyelv a deklaratív programozási paradigmát követi.\
b. A Bash nyelv az imperatív programozási paradigmát követi.\
c. A Bash nyelvben keverhető a deklaratív és az imperatív programozási paradigma.

### 2. kérdés
Melyik állítás igaz?

a. A Bash nyelvben megvalósíthatók komplex matematikai műveletek.\
b. A Bash nyelv nem alkalmas matematikai műveletekre, mert nem tud lebegőpontos számokat kezelni.\
c. A Bash nyelvben nem készíthetők komplex programok.

### 3. kérdés
Mit ír ki az alábbi program?

```bash
x=10
unset x
echo 'x: $x'
```

### 4. kérdés
Mit ír ki az alábbi program?

```bash
declare -i x=10
x="Ten babe"
echo "x: $x"
```

### 5. kérdés
Mit ír ki az alábbi program?

```bash
declare -i x=10
x="Ten"
echo "x: $x"
```

### 6. kérdés
Mit ír ki az alábbi program?

```bash
x=10
unset x
echo "x: $x"
```

### 7. kérdés
Mit ír ki az alábbi program?

```bash
x=10
y=-15
z=$(x + y)
echo $z
```

### 8. kérdés
Mit ír ki az alábbi program?

```bash
x=10
y=-15
z=$(($x + $y))
echo $z
```

### 9. kérdés
Mire való a `wget` parancs?

a. Változók értékének beolvasására.\
b. Internetes tartalom lekérésére.\
c. Környezeti változók lekérésére.

### 10. kérdés
Mit ír ki az alábbi program?

```bash
x=10.5
echo "10 + 0.9 $(echo "$x * 2" | bc)" | bc
```
