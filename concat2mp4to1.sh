#/bin/sh
name="$1"
input1=$name"cd1.mp4"
input2=$name"cd2.mp4"
original1=$input1".original"
original2=$input2".original"
output=$name".mp4"

echo $input1
echo $input2
echo $output

rm ./concat.txt
printf "file '$input1'\nfile '$input2'\n" > ./concat.txt
ffmpeg -f concat -safe 0 -i ./concat.txt -c copy "$output"
mv "$input1" "$original1"
mv "$input2" "$original2"