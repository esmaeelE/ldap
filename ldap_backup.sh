#!/bin/bash

###############################################################################
###############################################################################
###                                                                           #
###                     This is product                                       #
###                                                                           #
###############################################################################
###############################################################################

###############################################################################
#   Script Name         : backup_ldap.sh
#   Description         : Create backup from ldap files and config
#                       : store in separate .gz file and logs
#
#                       Scheduled to run with crontab
#                       see with: crontab -l
#   Creation Date       : 2024 11 27
#   Author              : Esmaeel
#
###############################################################################
## crontab -l
# 15 00 * * * bash /opt/scripts/run/backup_ldap.sh 1 >> /opt/scripts/logs/log_backup_ldap 2>> /opt/scripts/logs/error_backup_ldap


###############################################################################
#   Global Variables
###############################################################################
#   DATE                       : USE CURRENT DATE 
#   DESTINATION                : Set DEST_PATH to store files
#   
###############################################################################

DATE=$(date +%Y%m%d_%H%M%S)
DEST_PATH="/var/backup"
# DEST_PATH="/home/user/LDAP/backup"

LDAP="$DEST_PATH/ldap"
ARCH="$DEST_PATH/arch"

KEEP_DAY=10

###############################################################################
#   NAME          : LOGGER
#   ARGUMENTS     : Read all arguments inside with $@
#   WORK          : PRINT $DATE BEFORE ANY MESSAGE
#   USAGE         : LOGGER this is test message
#   OUTPUT        : 20230515 10:20:27 -- this is test message
###############################################################################
function LOGGER {

    echo "$(/usr/bin/date +%Y%m%d_%H%M%S)" "$@";
    #echo $@ | awk '{ printf strftime ("[%Y-%m-%d %H:%M:%S] ")}'
    #errcho $(date +%Y%m%d" "%H:%M:%S) -- $@
}


LOGGER "START RUNNIG BACKUP PROCEDURE ..." ${DESTINATION} 

/usr/bin/rm -rf $LDAP
/usr/bin/mkdir -p $LDAP $ARCH

LOGGER running dump ...

# Create ldap backup and zip output

/usr/sbin/slapcat  > "$LDAP/backup.ldiff"
/usr/sbin/slapcat -b cn=config > "$LDAP/config.ldiff"

# dont presever directory architeture
/usr/bin/tar -czvf "$ARCH/$DATE.ldiff.tar.gz" -C $LDAP . ;

LOGGER "END running dump ldap ..."

LOGGER "Sending $ARCH/$DATE.ldiff.tar.gz to remote server ..."

# copy archive file to remote server
# /usr/bin/scp $SEND/$DATE.tar user@1.1.1.1:/var/archive/tar

# extract files
# tar xvf 20240204_110754.tar -C extract/

LOGGER "***END BACKUP PROCEDURE***"

# Delete old backups
# /usr/bin/find $BACKUP_DIR -mtime +$KEEP_DAY -delete




