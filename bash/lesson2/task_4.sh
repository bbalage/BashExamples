wget https://raw.githubusercontent.com/bbalage/BashExamples/master/assets/file1.txt
cat file1.txt | grep "^[a-Z0-9.]\+@[a-Z0-9.]\+\.[a-Z]\{2,\}" > emails.txt
rm file1.txt