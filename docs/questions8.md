# 8. Kérdések
Ellenőrző kérdések a nyolcadik gyakorlathoz.

### 1. kérdés
Mit ír ki az alábbi kód?

```bash
function f {
    echo "Hello"
}
echo $f
```

a. Semmit.\
b. Hello\
c. Egy üres sort.\
d. f

### 2. kérdés
Mit ír ki az alábbi kód?

```bash
function f {
    echo "Hello"
    return 1
}
n=f
echo $n
```

a. Semmit.\
b. Hello\
c. 1\
d. f

### 3. kérdés
Mit ír ki az alábbi kód?

```bash
function f {
    echo "Hello"
    return 1
}
n=$(f)
echo $n
```

a. Semmit.\
b. Hello\
c. 1\
d. f

### 4. kérdés
Mit ír ki az alábbi kód?

```bash
function f {
    echo "Hello"
    return 1
}
echo $?
```

a. Valószínűleg semmit.\
b. Hello\
c. 1\
d. f

### 5. kérdés
Mit ír ki az alábbi kód?

```bash
function f {
    echo -n "Hello "
}
f
echo $?
```

a. Semmit.\
b. Hello\
c. Hello 1\
d. Hello 0

### 6. kérdés
Mit ír ki az alábbi kód?


```bash
x=10
function f {
    local x=1
    x=$((x + 1))
    if [ $# -lt 2 ]; then
        return 1
    fi
    echo $((x + $1 + $2))
}
result1=$(f 12 10 || echo 0)
result2=$(f 10 || echo 0)
echo "$result1 : $result2 : $x"
```

a. 24 : 0 : 10\
b. 23 : 0 : 10\
c. 23 : 0 : 12\
d. 23 : 12 : 10