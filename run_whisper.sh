#!/bin/bash

FILE=data/test.mp3

docker run --rm -it --gpus all -v $PWD:/app whisper \
whisper $FILE --task translate --model medium --language Norwegian

