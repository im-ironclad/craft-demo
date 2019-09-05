#!/bin/bash

source .env.sh

# Constants
BACKUP="db.sql"
ASSET_PATH="public_html/uploads"

# Variables
REMOTE_DB_NAME="$PRODUCTION_DB_NAME"
REMOTE_DB_USER="$PRODUCTION_DB_USER"
REMOTE_DB_PASS="$PRODUCTION_DB_PASS"
REMOTE_HOME_PATH="$PRODUCTION_HOME_PATH"

# Steps: Ignore owner, group, and permissions on push rsync
# 1) Dump DB
# 2) Sync DB
# 3) Import DB
# 4) Sync assets
# 5) Remove DB backup Locally and on Remote server
mysqldump -u"$LOCAL_DB_USER" -p"$LOCAL_DB_PASS" "$LOCAL_DB_NAME" > "$LOCAL_HOME_PATH/$BACKUP"
rsync -azP --no-o --no-g --no-p "$LOCAL_HOME_PATH/$BACKUP" "$SSH_HOST:$REMOTE_HOME_PATH"
ssh "$SSH_HOST" "mysql -h shareddb-q.hosting.stackcp.net -u'$REMOTE_DB_USER' -p'$REMOTE_DB_PASS' $REMOTE_DB_NAME < $REMOTE_HOME_PATH/$BACKUP"
# SYNC ASSETS HERE
rm "$LOCAL_HOME_PATH/$BACKUP"
ssh "$SSH_HOST" "rm $REMOTE_HOME_PATH/$BACKUP"
ssh "$SSH_HOST" "git fetch && git pull origin master"