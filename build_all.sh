#!/bin/bash

# This script builds all of the pdfs in the pdfs directory from the markdown files in the plaintxt directory.
# It does this by looping over the files in plaintxt and pdfs in parallel and building the pdf if the source file is newer than the target file.
# This script is meant to be run from the directory it is in.

# use safety checks to ensure that the script is run from the correct directory
if [ ! -f "build_all.sh" ]; then
	echo "Error: script must be run from the directory it is in"
	exit 1
fi

# catch errors and undefined variables
set -e
set -o pipefail
set -u

# create the pdfs directory if it doesn't exist
if [ ! -d "pdfs" ]; then
	mkdir pdfs
fi

# create the plaintxt directory if it doesn't exist
if [ ! -d "plaintxt" ]; then
	mkdir plaintxt
fi

SRC_FILES=plaintxt/*.md

TARGET_FILES=""
for i in $SRC_FILES; do
	TARGET_FILES="$TARGET_FILES ./pdfs/`basename $i .md`.pdf"
done

# get the number of files in TARGET_FILES and SRC_FILES
NUM_TARGET_FILES=`echo $TARGET_FILES | wc -w`
NUM_SRC_FILES=`echo $SRC_FILES | wc -w`

if [ $NUM_TARGET_FILES -ne $NUM_SRC_FILES ]; then
	echo "Error: number of target files and source files are not equal"
	exit 1
fi

# # loop over TARGET_FILES and SRC_FILES in parallel using and index
for i in `seq 1 $NUM_TARGET_FILES`; do
	TARGET_FILE=`echo $TARGET_FILES | cut -d ' ' -f $i`
	SRC_FILE=`echo $SRC_FILES | cut -d ' ' -f $i`
	# if the target file does not exist or the source file is newer than the target file, then build the target file
	if [ ! -f $TARGET_FILE ] || [ $SRC_FILE -nt $TARGET_FILE ]; then
		echo "Building $TARGET_FILE from $SRC_FILE"
		python3 ./build.py $SRC_FILE $TARGET_FILE
	fi
done
