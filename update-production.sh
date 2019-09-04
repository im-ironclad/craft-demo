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
# 5) Remove DB backup
mysqldump -u"$LOCAL_DB_USER" -p"$LOCAL_DB_PASS" "$LOCAL_DB_NAME" > "$LOCAL_HOME_PATH/$BACKUP"

# OLD: ssh "$SSH_HOST" "git fetch && git pull origin master"