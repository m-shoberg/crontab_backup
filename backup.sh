#!/bin/bash

# This checks if the number of arguments is correct
# If the number of arguments is incorrect ( $# != 2) print error message and exit
if [[ $# != 2 ]]
then
  echo "backup.sh target_directory_name destination_directory_name"
  exit
fi

# This checks if argument 1 and argument 2 are valid directory paths
if [[ ! -d $1 ]] || [[ ! -d $2 ]]
then
  echo "Invalid directory path provided"
  exit
fi

# Set two variables equal to the values of the first and second command line arguments
targetDirectory=$1
destinationDirectory=$2

# Display the values of the two command line arguments in the terminal
echo "Target directory: $targetDirectory"
echo "Backup destination: $destinationDirectory"

# timestamp represented in seconds
currentTS=$(date +%s)

# set backupFilename var that populated timestamp in seconds
backupFileName="backup-[$currentTS].tar.gz"

'''
1: Go into the target directory
2: Create the backup file
3: Move the backup file to the destination directory
'''

origAbsPath=$(pwd)

cd $destinationDirectory
destAbsPath=$(pwd)

# Change directories from the current working directory to the target directory
cd origAbsPath
cd targetDirectory

# Define numerical variable called as the timestamp (in seconds) 24 hours prior to the current timestamp --> currentTS
yesterdayTS=$(($currentTS - 24 * 60 * 60))

declare -a toBackup

'''
1. loop iterates through files in current directory to see if $file has been updated within the last 24 hours
2. if $file date in seconds is greater than yesterdayTS, then $file has been updated within the last 24 hours
'''
for file in $(ls -a) # return all files and directories in current folder
do
  # checks for $file update within last 24 hours
  if ((`date -r $file +%s` > $yesterdayTS))
  then
    # add updated file to toBackup array
    toBackup+=($file)
  fi
done

# compress and archive the file names
tar -czvf $backupFileName ${toBackup[@]}
# move file to destination directory
mv $backupFileName $destAbsPath
