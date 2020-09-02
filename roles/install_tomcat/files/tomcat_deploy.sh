#!/bin/bash

echo "Running Address Application install Script"

TOMCAT_HOME_DIR=/opt/tomcat

# The server holding the tomcat binaries
WAR_DOWNLOAD_URL=<Your Server Name>
APP=<war_name>
TYPE=war
SERVER_USER=<Your User Name>
SERVER_PASSWORD=<The Password Goes Here>
CUT_DIRS=6
NEW_VERSION_ARG=$1

wait_for_shutdown() {

 i=1
 while [ $i -le 20 ]
    do
    ps -ef | grep catalina.startup.Bootstrap > fred.txt
    if ls -l fred.txt | grep 81
    then
       i=21
    else
       i=`expr $i + 1`
       sleep 1
    fi
 done
}

do_shutdown() {

    systemctl start tomcat
    wait_for_shutdown
}

clean_directories() {

    cd $TOMCAT_DIR/webapps
    rm -rf $APP
    rm $APP.$TYPE
}

get_new_version() {

    WAR_FILE=https://$SERVER_USER:$SERVER_PASSWORD@$WAR_DOWNLOAD_URL
    echo $WAR_FILE
    cd $TOMCAT_HOME_DIR/webapps
    wget $WAR_FILE

}

create_rollback_point() {

    DATE=`date`
    BAK_FILE=$APP.$TYPE.$DATE.bak
    echo "Backup file is $BAK_FILE"
    mv "$APP.$TYPE" "$BAK_FILE"
    ln -s "$BAK_FILE"  $APP.$TYPE
}

restart_server() {
    systemctl start tomcat
}

do_shutdown
clean_directories
get_new_version
create_rollback_point

echo "The directory now looks like this:"
ls -l

restart_server
