#!/bin/bash
#                       :                                                 #
#  Date                 : 18-NOV-2014                                     #
#  Author               : Puneet Shekhar                                  #
#  Description          : EMCATELOGMENU                                   #
###########################################################################
#set -x

#GLOBAL VARIABLES
JOB_NAME="EMCATELOGMENU"
EXITSTATUS=0
EDITOR="Puneet Shekhar"
RED='\033[0;41;30m'
STD='\033[0;0;39m'
SPACE_TILD="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
SPACE_LINE="---------------------------------------------------------------------"
USER_NAME=$USER
USER_HOME=$HOME
CURRENT_DIR=$(pwd)
PROJ_DIR=proj
PROJ_DIR_PATH=${USER_HOME}/proj
SCRIPT_DIR=scripts
SCRIPT_DIR_PATH=${PROJ_DIR_PATH}/${SCRIPT_DIR}
APP_DIR=eMApp
APP_DIR_PATH=${PROJ_DIR_PATH}/${APP_DIR}
. ${SCRIPT_DIR_PATH}/key.properties

# ----------------------------------------------------------------------------------
# PAUSE for re - selection of options
# ----------------------------------------------------------------------------------
pause(){
        echo ${SPACE_LINE}
        read -p "Press [Enter] key to continue..." fackEnterKey
}
# ----------------------------------------------------------------------------------
# Function REFRESH_PROJ: User defined function
# ----------------------------------------------------------------------------------
refresh_proj(){
        echo ${SPACE_LINE}
        echo "refresh_proj() called..."
        #echo ${USER_NAME}
        #echo ${CURRENT_DIR}
        #echo ${PROJ_DIR}
        #echo ${PROJ_DIR_PATH}
        #echo ${SCRIPT_DIR}
        #echo ${SCRIPT_DIR_PATH}
        #echo ${APP_DIR}
        #echo ${APP_DIR_PATH}
        #echo ${REP_NAME}
        #echo ${CONFIG_DIR}
        
		    echo ${SPACE_LINE}
		    #cd ${SCRIPT_DIR_PATH}
		    #cd ${APP_DIR_PATH}
		    cd ${APP_DIR_PATH}/${REP_NAME}
		    
		    echo "executing git pull command. Please enter your "
        git pull
        pause
}
# ----------------------------------------------------------------------------------
# Function CLONE_PROJ: User defined function
# ----------------------------------------------------------------------------------
clone_proj(){
        echo ${SPACE_LINE}
        echo "clone_proj() called..."
       
        echo 
        echo "Checking ${APP_DIR} directory is exists or not."
        echo
        
        cd ${PROJ_DIR_PATH}
        
        if [ -d "${APP_DIR}" ]
        	    then
        	    echo "${APP_DIR} directory  exists!"
   	    else
	           echo "${APP_DIR} directory not found !"
	           mkdir ${APP_DIR}
	           echo "${APP_DIR} directory created now."
	      fi       
        
        cd ${APP_DIR_PATH}
        
        echo "executing git clone command."
        git clone ${GIT_REP}
	      pause
	      sleep 1
      
        echo 
        echo "Checking ${CONFIG_DIR} directory is exists or not."
        echo
        
     	  if [ -d "${CONFIG_DIR}" ]
     		    then
            echo " ${CONFIG_DIR} directory exists!"
	      else
	          echo "${CONFIG_DIR} directory not found!"
	          mkdir $CONFIG_DIR
	          echo "$CONFIG_DIR directory created."
	      fi
	      
	      echo
		    echo "Checking $CONFIG_FILE file is exists or not."
		    echo
		   
		    if [ -d "${LOGS_DIR}" ]
     		    then
            echo " ${LOGS_DIR} directory exists!"
	      else
	          echo "${LOGS_DIR} directory not found!"
	          mkdir $LOGS_DIR
	          echo "$LOGS_DIR directory created."
	      fi
	      
        if [ -s $APP_DIR_PATH/$CONFIG_DIR/$CONFIG_FILE ]
           then
		       echo "File $CONFIG_FILE is available."
	      else
	         echo "File $CONFIG_FILE is not available."
	         #touch $CONFIG_DIR/$CONFIG_FILE
	         #echo "File $CONFIG_FILE created now."
           #echo
           #echo "Making entry $CONFIG_DATA into $CONFIG_FILE"
                 #cd $APP_DIR_PATH/$CONFIG_DIR
           #echo $(pwd)
                #cat <<EOF >>file.conf.new
                #DBHost=localhost
                #DBName=database
                #DBPassword=password
                #EOF
                #cd ..
                #echo "$CONFIG_DATA added into $CONFIG_FILE"
                #echo "Copying $CONFIG_FILE into $CONFIG_DIR"
                #mv $CONFIG_FILE $CONFIG_DIR/$CONFIG_FILE
                #echo "$CONFIG_FILE moved to $CONFIG_DIR"
                #echo  
	       fi
         echo
         pause
         echo
}
# ----------------------------------------------------------------------------------
# Function STASH_PROJ: User defined function
# ----------------------------------------------------------------------------------
stash_proj(){
        echo ${SPACE_LINE}
        echo "stash_proj() called..."
        #echo ${REP_NAME}
        #echo ${BRANCH_NAME}
        #echo ${APP_DIR_PATH}
        cd ${APP_DIR_PATH}/${REP_NAME}
        
        echo "executing git stash command."
        git stash
        echo ${SPACE_LINE}
		    echo
        pause
        echo
}
# ----------------------------------------------------------------------------------
# Function BOWER_INSTALL: User defined function
# ----------------------------------------------------------------------------------
bower_install(){
        echo ${SPACE_LINE}
        echo "BOWER_INSTALL() called..."
	      #echo ${REP_NAME}
        #echo ${BRANCH_NAME}
        #echo ${APP_DIR_PATH}        
        cd ${APP_DIR_PATH}/${REP_NAME}
        
        echo "executing npm install command."
      
        npm install
        sleep 1	
        echo "executing bower install command."
        bower install
        echo ${SPACE_LINE}
        #cd ..
        pause
}
# ----------------------------------------------------------------------------------
# Function gulp_build : User defined function
# ----------------------------------------------------------------------------------
gulp_build(){
        echo ${SPACE_LINE}
        echo "GULP_BUILD() called..."
	      #echo ${REP_NAME}
        #echo ${BRANCH_NAME}
        #echo ${APP_DIR_PATH}        
        cd ${APP_DIR_PATH}/${REP_NAME}
        
        echo "executing gulp build command."
        gulp
        sleep 1	
        echo ${SPACE_LINE}
        #cd ..
        pause
}
# ----------------------------------------------------------------------------------
# Function START_SERVER: User defined function
# ----------------------------------------------------------------------------------
start_server(){
      echo ${SPACE_LINE}
      echo "START_SERVER() called."
      cd ${APP_DIR_PATH}/${REP_NAME}
      #nohup grunt serve &
      #node server.js
      #cd ..  
      cd ${APP_DIR_PATH}/${REP_NAME}
      
      echo "executing pm2 stop all command."
      $PM2 stop all
    	#$PM2 resurrect
    	echo "executing pm2 start command with number of instances : " ${PM2_INSTANCE}
    	$PM2 start server.js -i ${PM2_INSTANCE}
      
      echo ${SPACE_LINE}
      pause
}
# ----------------------------------------------------------------------------------
# Function STOP_SERVER: User defined function
# ----------------------------------------------------------------------------------
stop_server(){
      echo ${SPACE_LINE}
      echo "STOP_SERVER() called..."
      
      cd ${APP_DIR_PATH}/${REP_NAME}
      
      echo "executing pm2 stop all command."
      $PM2 stop all
    	echo ${SPACE_LINE}
      pause
}
# ----------------------------------------------------------------------------------
# Function RESTART_SERVER: User defined function
# ----------------------------------------------------------------------------------
restart_server(){
      echo ${SPACE_LINE}
      echo "RESTART_SERVER() called..."
      cd ${APP_DIR_PATH}/${REP_NAME}
      
      echo "executing pm2 resgtart all command."
      $PM2 restart all
      pause
}
# ----------------------------------------------------------------------------------
# Function CHECKOUT_BRANCH: User defined function
# ----------------------------------------------------------------------------------
checkout_branch(){
      echo ${SPACE_LINE}
      echo "checkout_branch() called."
      cd ${APP_DIR_PATH}/${REP_NAME}
      
      echo "executing git checkout command."
      git checkout ${BRANCH_NAME}
      echo ${SPACE_LINE}
      pause
}
# ----------------------------------------------------------------------------------
# EXIT from the program
# ----------------------------------------------------------------------------------
program_exit(){
      echo ${SPACE_LINE}
      echo "Exiting from the Program."
      EXITSTATUS=0;
      echo ${SPACE_LINE}
      sleep 1
      exit
}
# ----------------------------------------------------------------------------------
# Dummy Job Step. It just display menu.
# ----------------------------------------------------------------------------------
show_menus() {
        clear
        echo ${SPACE_TILD}
        echo "           M A I N - M E N U"
        echo ${SPACE_TILD}
        echo "      INSERT : 1 - REFRESH/PULL"
        echo "      INSERT : 2 - CLONE PROJECT"
        echo "      INSERT : 3 - STASH PROJECT"
        echo "      INSERT : 4 - INSTALL DEPENDENCY"
        echo "      INSERT : 5 - GULP BUILD"
        echo "      INSERT : 6 - START SERVER"
        echo "      INSERT : 7 - STOP SERVER"
        echo "      INSERT : 8 - RESTART SERVER"
        echo "      INSERT : 9 - CHECKOUT BRANCH"
        echo ${SPACE_TILD}
        echo "      INSERT : 0 - EXIT"
        echo ${SPACE_TILD}
        echo
}
# ----------------------------------------------------------------------------------
# read input from the keyboard and take a action
# ----------------------------------------------------------------------------------
read_options(){
        local choice
        read -p "Enter choice : " choice
        case $choice in
                1) refresh_proj ;;
                2) clone_proj ;;
                3) stash_proj ;;
                4) bower_install ;;
                5) gulp_build ;;
                6) start_server ;;
                7) stop_server ;;
                8) restart_server ;;
                9) checkout_branch ;;
                0) program_exit ;;
                *) echo -e "${RED}Error... Incorrect choice. Wait for a moment ${STD}" && sleep 2
        esac
}
# ----------------------------------------------------------------------------------
# Step #3: Trap CTRL+C, CTRL+Z and quit singles
# ----------------------------------------------------------------------------------
trap '' SIGINT SIGQUIT SIGTSTP
# ----------------------------------------------------------------------------------
# Step #4: Main logic - infinite loop
# ----------------------------------------------------------------------------------
while true
do
        show_menus
        read_options
done
