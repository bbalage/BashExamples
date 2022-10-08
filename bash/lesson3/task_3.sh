#!/bin/bash

if [ $# -lt 1 ]; then
    echo "No input file name provided!" 1>&2
    exit 1
fi

if [ ! -e $1 ]; then
    echo "Input file does not exist." 1>&2
    exit 1
fi

# The first parameter is the input file's name. We only clarify that here.
input_file_name=$1
echo "Input file name: $input_file_name"

# Read the content of the file.
text=$(cat $input_file_name)

# We want to strip the file's name from its extension, so we find the dot, then use it for string manipulation.
dot_index=$(expr index $input_file_name '.')
before_dot_index=$((dot_index - 1))
extension=${input_file_name:dot_index}
only_file_name=${input_file_name:0:before_dot_index}
# By the way, I could have written: ${1:0:before_dot_index}

# Create the actual output file's name.
output_file_name="${only_file_name}_out.$extension"
echo "Output file name: $output_file_name"

# Use the built-in commands to switch parts of the text.
out_text=${text//"happy"/"not thinking about the vizsgaidőszak"}

# echo did not behave well with the newlines, so I used printf. The output is directed into the file.
printf "$out_text" > $output_file_name