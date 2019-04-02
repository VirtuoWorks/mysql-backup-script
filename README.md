# MySQL Backup Script

This is small mysql backup script. It creates an SQL backup of each database of a MySQL running instance in the configured directory.
It can be used in a daily cron job. It keeps a maximum of 30 days worth of backups.

## Prerequisites

* A Working MySQL installation.
* A administrative user account.
  
## Installation

* Copy the script in :
	* `/root/mysql-backup-script.sh`

### Configuration
* Change (line 2)  `/path/to/backup/directory` with the path to a backup directory (for instance : `/tmp`).
* Change (line 4)  `YOURDBUSER` with your database administrative user username (for instance : `john`).
* Change (line 5)  `YOURDBPASS` with your database administrative user password (for instance : `****`).
* Change (line 6)  `YOURDBHOST` with the MySQL instance host (for instance : `localhost`).

## Permissions

* Set the owner/group to root user : 
	* `sudo chown root:root /root/mysql-backup-script.sh`
* Set Read/Write/Execute to root user only, others (group and others) get nothing :
	* `sudo chmod 700 /root/mysql-backup-script.sh`

### Test
* As root : `/root/mysql-backup-script.sh`
* and : `sudo /root/mysql-backup-script.sh`