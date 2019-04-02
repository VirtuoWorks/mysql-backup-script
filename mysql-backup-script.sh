#!/bin/sh
BACKUP_DIR="/path/to/backup/directory"

DBUSER="YOURDBUSER"
DBPASS="YOURDBPASS"
DBHOST="YOURDBHOST"

[[ -d "$BACKUP_DIR" ]] ||  mkdir -p "$BACKUP_DIR"

PREFIX=`date +"%Y-%m-%d"`
SUFFIX=`date +"%s"`

if [ -z $DBPASS ]
then
  DBS=`mysql -u$DBUSER -h$DBHOST -e"SHOW DATABASES;"`
else
  DBS=`mysql -u$DBUSER -h$DBHOST -p$DBPASS -e"SHOW DATABASES;"`
fi

for DATABASE in $DBS
do
  if [ $DATABASE != "Database" ] && [ $DATABASE != "mysql" ] && [ $DATABASE != "information_schema" ] && [ $DATABASE != "default_db" ] && [ $DATABASE != "test" ] && [ $DATABASE != "performance_schema" ]
  then
    DATE=`date +"%Y-%m-%d %T"`

    echo "[MySQL Backup Script]["${DATE}"] Starting ["${DATABASE}"] backup :"

    WILDCARD="*-${DATABASE}-*.sql.gz"
    FILENAME="${PREFIX}-${DATABASE}-${SUFFIX}.sql.gz"

    echo "[MySQL Backup Script]["${DATE}"] * Purging ["${DATABASE}"] backups older than 30 days..."
    find $BACKUP_DIR -name "${WILDCARD}" -type f -ctime +30 -delete > /dev/null

    echo "[MySQL Backup Script]["${DATE}"] * Starting ["${DATABASE}"] backup..."
    if [ -z $DBPASS ]
    then
      mysqldump -u$DBUSER $DATABASE | /bin/gzip > "${BACKUP_DIR}/${FILENAME}"
    else
      mysqldump -u$DBUSER -p$DBPASS $DATABASE | /bin/gzip > "${BACKUP_DIR}/${FILENAME}"
    fi

    echo "[MySQL Backup Script]["${DATE}"] End of ["${DATABASE}"] backup."
  fi
done

