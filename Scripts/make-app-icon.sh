#!/usr/bin/env bash

#
# Script: make-app-icon.sh
# Usage: ./make-app-icon </path/to/image.png>
#
# Overlay the PNG image passed as argument over a 1024x1024 white background
# using https://imagemagick.org.
# The file will be written in the same directory as the image provided 
# as argument.
#

# Set defaults
set -o nounset -o errexit -o errtrace -o pipefail

# ============================== Variables ==============================

# Name of the file to output
OUTPUT_FILE_NAME="output.png"

# ============================== Functions ==============================

# Exit with failure message
function fatalError {
    echo "$1" >&2
    exit 1
}

# ============================== Main ==============================

# Check for a file command line argument
if [ $# -ne 1 ] || ! [ -f "$1" ]; then
    fatalError "Please provide a PNG as a command line argument."
fi

# Check the command line argument has a '.png' extension
if [ "${1%.png}" == "$1" ]; then
    fatalError "The PNG provided did not have a '.png' extension."
fi

# Get directory of the file provided as argument
dir="$(dirname "$1")"

# Path to the file to write
dst="${dir}/${OUTPUT_FILE_NAME}"

# Execute imagemagick command
convert "$1" -gravity center -background white -extent 1024x1024  "${dst}"

# Print success
echo "Success, file written to ${dst}"
