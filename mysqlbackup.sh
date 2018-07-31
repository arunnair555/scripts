#!/bin/bash

FILE_NAME="webrsqco_itaxsmart-`date +%Y%m%d%H%M`.sql"
SAVE_DIR="/backup/mysql/"
S3BUCKET="aruntestbuckets3"

# Get MYSQL_USER and MYSQL_PASSWORD
#source /home/ubuntu/backup/.env

mysqldump -u root   webrsqco_itaxsmart > ${SAVE_DIR}/${FILE_NAME}

if [ -e ${SAVE_DIR}/${FILE_NAME} ]; then

    # Upload to AWS
    aws s3 cp ${SAVE_DIR}/${FILE_NAME} s3://${S3BUCKET}/${FILE_NAME}

    # Test result of last command run
    if [ "$?" -ne "0" ]; then
        echo "Database backup of Hitch server  failed please contact system admin" | mail -s "Datbase backup on $date FAILED!!" arunnair555@gmail.com
	echo "failed"
	exit 1
    fi

    # If success, remove backup file
	echo "Database backup of Hitch server  failed please contact system admin" | mail -s "Datbase backup on $date SUCCESS!!" arunnair555@gmail.com
    rm ${SAVE_DIR}/${FILE_NAME}

    # Exit with no error
    exit 0
fi

# Exit with error if we reach this point
echo "Backup file not created"
exit 1
