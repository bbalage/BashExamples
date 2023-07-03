# 5. óra

Ezen az órán függvény példák és kérdések találhatóak.

A továbbolvasás előtt ajánlott elolvasni Tóth Alex ide tartozó
[anyagát](https://users.iit.uni-miskolc.hu/~toth130/arch/gyak/Gyak7.pdf).

### 1. példa
Mit ír ki az alábbi kód?

```bash
function f {
    echo "Hello"
}
f
```

### 2. példa
Mit csinál és mit ír ki az alábbi kód?

```bash
function f {
    echo "Hello"
    return 1
}
n=f
echo $n
```

### 3. példa
Mit csinál és mit ír ki?

```bash
function f {
    echo "Hello"
    return 1
}
n=$(f)
echo $n
```

### 4. példa
Mit csinál és mit ír ki?

```bash
function f {
    echo "Hello"
    return 1
}
echo $?
```

### 5. példa
Mit csinál és mit ír ki?

```bash
function f {
    echo "Hello"
    return 1
}
f
echo $?
```

### 5. példa
Mit csinál és mit ír ki?

```bash
function f {
    local x=1
    echo $((x + $1 + $2))
}
result1=$(f 12 10)
result2=$(f 10)
echo "$result1 : $result2"
```

### 6. példa
Mit csinál és mit ír ki?

```bash
function f {
    local x=1
    echo $((x + $1 + $2))
}
result1=$(f 12 10) || 0
result2=$(f 10) || 0
echo "$result1 : $result2"
```

### 7. példa
Mit csinál és mit ír ki?

```bash
function f {
    local x=1
    echo $((x + $1 + $2))
}
result1=$(f 12 10) || echo 0
result2=$(f 10) || echo 0
echo "$result1 : $result2"
```

### 8. példa
Mit csinál és mit ír ki?

```bash
function f {
    local x=1
    if [ $# -lt 2 ]; then
        return 1
    fi
    echo $((x + $1 + $2))
}
result1=$(f 12 10 || echo 0)
result2=$(f 10 || echo 0)
echo "$result1 : $result2"
```

### 9. példa
Mit csinál és mit ír ki?

```bash
function sum {
    local x=0
    for i in $*; do
        x=$((x + i))
    done
    echo $((x))
}
echo $(sum 1 2 3 4 5)
```

## Feladatok
A feladatok a megoldásokkal együtt leginkább minták, segítség ahhoz, hogy bashben hogyan használunk
függvényeket.

### 1. feladat
Írjunk függvényt, amely két számot kér, és 1-est ad vissza, ha az első osztható a másodikkal, és 
0-t, ha nem. Ha nem két pozitív egész számot kapott, akkor jelezzen hibát!

**Megoldás:**

```bash
function is_div {
    local reg="^[0-9]+$"
    if [[ $# -ne 2 ]] || [[ ! $1 =~ $reg ]] || [[ ! $2 =~ $reg ]]; then
        return 1
    fi
    if [ $(($1 % $2)) -eq 0 ]; then
        echo 1
    else
        echo 0
    fi
}
echo $(is_div 10 10 || echo "error")
echo $(is_div 10 100 || echo "error")
echo $(is_div eee 10 || echo "error")
```