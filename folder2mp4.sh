#/bin/sh
# First parameter specifies the folder that is searched for video files
# The converted files will be created in the same folder as mp4 files using h.264 and ac3 codecs

FOLDER_SRC="$1"

# Search the target folder
saveIFS="$IFS"; 
IFS=$'\n'; 
files=( $(find "$FOLDER_SRC" -type f -exec file -N -i -- {} + | sed -n 's!: video/[^:]*$!!p') ); 
IFS="$saveIFS"
convertList=()

# Loop over the file list and see for codecs that we want to convert
for f in "${files[@]}"; 
do
	format=$(file -b "$f")

    if [[ "$format" == *"ISO Media, MP4"* ]]  
	then
		continue
	else 
		if [[ "$format" == *"Matroska data"* ]] 
		then
			continue
		else
			convertList+=("$f")
			echo "$f"
			echo "$format"
		fi
	fi
    #format=$(file -b "$f")
    #ffmpeg -i "$f" 2>&1
done
echo "found ${#convertList[@]} files to convert" 

# Start the conversion - existing files are skipped
echo "Starting conversion"
for convert in "${convertList[@]}"; 
do
	filename=${convert%.*}
	filename+=".mp4"
	if [ ! -f "$filename" ]; 
	then
	    echo "Starting conversion for $convert"
		echo "ffmpeg -i $convert -codec:v libx264 -tune -film -codec:a libfdk_aac -b:a 384k -movflags +faststart $filename"
		ffmpeg -i "$convert" -codec:v libx264 -tune -film -codec:a ac3 -b:a 384k -movflags +faststart "$filename"
	else
		echo "Skipped conversion as destination file already exists"
	fi
done
echo "Converted ${#convertList[@]} convert" 

exit 0