# folder2mp4

This simple bash script converts certain video files into a MP4 video format using H.264 and AC3 codecs. The main reason behind this was my PLEX media server running on an older Synology Disk Station, which was not able to transcode various file formats on the fly.

Here is an example usage:
```bash
./folder2mp4 /my/video/folder
```

The script basically does the following:
* Find all video files inside the passed directory or its subfolders
* Ignores files that are already in a MP4 or MKV format
* Converts the remaining files into an MP4 video at the same location as the source file

The script uses ffmpeg for the conversion, therefore you have to make sure that ffmpeg is installed.
So far I only tested it on Ubuntu 16.04
