read -p "x1: " x1
read -p "y1: " y1
read -p "x2: " x2
read -p "y2: " y2

operation_string="($x2 - $x1) * ($x2 - $x1) + ($y2 - $y1) * ($y2 - $y1)"
result_string=$(echo "scale=4; sqrt($operation_string)" | bc)
echo "Result: $result_string"