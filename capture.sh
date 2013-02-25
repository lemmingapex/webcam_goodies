#!/bin/bash

while true; do
	NOW=`date +"%Y-%m-%d_%H:%M:%S"`

	# snapshot
	cvlc -I dummy v4l2:///dev/video0 --video-filter scene --no-audio --scene-path /home/scott/webcam --scene-prefix $NOW --scene-format png vlc://quit --run-time=1
	mv "${NOW}00001.png" "$NOW.png"

	#video
	cvlc v4l2:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/pcm" :v4l-norm=3 :v4l-frequency=-1 :v4l-caching=300 :v4l-chroma="" :v4l-fps=-1.000000 :v4l-samplerate=44100 :v4l-channel=0 :v4l-tuner=-1 :v4l-audio=-1 :v4l-stereo :v4l-width=480 :v4l-height=360 :v4l-brightness=-1 :v4l-colour=-1 :v4l-hue=-1 :v4l-contrast=-1 :no-v4l-mjpeg :v4l-decimation=1 :v4l-quality=100 --sout="#transcode{vcodec=theo,vb=2000,fps=12,scale=0.33,acodec=vorb,ab=90,channels=1,samplerate=44100}:standard{access=file,mux=ogg,dst=$NOW.ogg}" vlc://quit --run-time=60

	#vlc-wrapper v4l2:// :v4l2-vdev="/dev/video0" --sout '#transcode{vcodec=x264{keyint=60,idrint=2},vcodec=h264,vb=400,width=368,heigh=208,acodec=mp4a,ab=32 ,channels=2,samplerate=22100}:duplicate{dst=std{access=http{mime=video/x-ms-wmv},mux=asf,dst=:8082/stream.wmv}}' --no-sout-audio

#	vlc-wrapper -vvv v4l2:// :v4l2-vdev="/dev/video0" --sout '#transcode{vcodec=mp4v,acodec=mpga,vb=800,ab=128}:standard{access=http,mux=ogg,dst=:8082}'

	#vlc-wrapper -vvv v4l2:// :v4l-vdev="/dev/video0" :v4l-adev="/dev/pcm" :v4l-norm=3 :v4l-frequency=-1 :v4l-caching=300 :v4l-chroma="" :v4l-fps=-1.000000 :v4l-samplerate=44100 :v4l-channel=0 :v4l-tuner=-1 :v4l-audio=-1 :v4l-stereo :v4l-width=480 :v4l-height=360 :v4l-brightness=-1 :v4l-colour=-1 :v4l-hue=-1 :v4l-contrast=-1 :no-v4l-mjpeg :v4l-decimation=1 :v4l-quality=100 --sout '#transcode{vcodec=theo,vb=4000,fps=18,scale=0.33,channels=1,samplerate=44100}:duplicate{dst=std{access=http,mux=ogg,dst=:8082/stream.ogg}}' --no-sout-audio

done
