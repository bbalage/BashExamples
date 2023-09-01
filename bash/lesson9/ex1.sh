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