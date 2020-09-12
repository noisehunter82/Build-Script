#!/bin/bash
# tells computer that this is a bash sript file 

echo "Hi, there! I hope you are well."

firstline=$(head -n 1 source/changelog.md)
# extracts first line of changelog.md (version number)

read -a splitfirstline <<< $firstline
# arranges firstline into an array of words and save it to 'splitfirstline' variable

version=${splitfirstline[1]}
# targets the second item in the array (version number)

echo "You are building version: "$version
echo "Type 0 to exit, or 1 to continue: "
read versioncontinue

if [ $versioncontinue -eq 1 ]
  then
    echo "OK"
    for filename in source/*  
    # iterates through all the files in 'source' directory 
    do
      echo $filename
      if [ $filename == 'source/secret_info.md' ]
        then
          echo '! File: '$filename' is being modyfied and copied.'
          sed 's/[0-9]/X/g' $filename > build/not_secret_info.md
        else
          echo 'File: '$filename' is being copied.'
          cp $filename build/
          # copies a file into 'build' directory
      fi
    done
    echo 'Here is a list of files for version' $version 'in "build" folder:'
    ls build/
    # lists all contents of 'build' directory
    zip -r build.zip build
    # creates a zip file containing 'build' directory along with its contents
  else
    echo "Please come back when you are ready"
fi

# playing with GIT
# more changes
# even more changes