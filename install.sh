#!/bin/bash

BIN_DIRECTORY="/usr/local/bin"
UPLOADER_SCRIPT="clouduploader.sh"

if [ -f "$BIN_DIRECTORY/$UPLOADER_SCRIPT" ]; then
  echo "The script is already installed"
  exit 1
fi

cp $UPLOADER_SCRIPT $BIN_DIRECTORY

chmod +x $BIN_DIRECTORY/$UPLOADER_SCRIPT

if [[ ":$PATH:" == *":$BIN_DIRECTORY:"* ]]; then
	echo "Installation sucessful. You can now call '$UPLOADER_SCRIPT' from anywhere."
else 
	echo "Installation successful, but '$BIN_DIRECTORY' is not in PATH."
fi