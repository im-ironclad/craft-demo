#!/bin/bash

##
# Variables
##
# Local
LOCAL_DB_NAME=""
LOCAL_DB_USER=""
LOCAL_DB_PASS=""
LOCAL_HOME_PATH=""
# Remote
REMOTE_DB_NAME=""
REMOTE_DB_USER=""
REMOTE_DB_PASS=""
REMOTE_HOME_PATH=""

# SSH
SSH_HOST="ik-craft-demo.com@ssh.stackcp.com"

##
# Actual scripts to run
##
ssh "$SSH_HOST" "git fetch && git pull origin master"