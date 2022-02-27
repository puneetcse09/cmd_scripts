#!/bin/bash
#                       :                                                 #
#  Date                 : 18-NOV-2014                                     #
#  Author               : Puneet Shekhar                                  #
#  Description          : EMCATELOGJOB                                      #
###########################################################################
#set -x

#GLOBAL VARIABLES
JOB_NAME="EMCATELOGJOB"
EXITSTATUS=0
PARAM_1=$1
PARAM_2=$2
EDITOR="Puneet Shekhar"
RED='\033[0;41;30m'
STD='\033[0;0;39m'
SPACE_TILD="~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
SPACE_LINE="---------------------------------------------------------------------"
USER_NAME=$USER
CURRENT_DIR=$(pwd)
. /home/$USER_NAME/test/key.properties
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
        echo "refresh_proj() called"
		cd ${REP_NAME}
        git pull
		echo ${SPACE_LINE}
		cd ..
        pause
}
# ----------------------------------------------------------------------------------
# Function CLONE_PROJ: User defined function
# ----------------------------------------------------------------------------------
clone_proj(){
        echo ${SPACE_LINE}
        echo "clone_proj() called"
        git clone ${GIT_REP}
       # pause
        sleep 1
        echo 
	echo "Checking $CONFIG_DIR directory is exists or not."
	echo

	if [ -d "$CONFIG_DIR" ]
	    then
                echo "$CONFIG_DIR directory  exists!"
	    else
	        echo "$CONFIG_DIR directory not found!"
		mkdir $CONFIG_DIR
		echo "$CONFIG_DIR directory created now."
	    fi
		echo
		echo "Checking $CONFIG_FILE directory is exists or not."
		echo 
	 
        if [ -s $CURRENT_DIR/$CONFIG_DIR/$CONFIG_FILE ]
           then
		echo "File $CONFIG_FILE is available"
	   else
		echo "File $CONFIG_FILE is not available"
	       # touch $CONFIG_DIR/$CONFIG_FILE
	       # echo "File $CONFIG_FILE created now."
                echo
               # echo "Making entry $CONFIG_DATA into $CONFIG_FILE"
               # cd $CONFIG_DIR
               # echo $(pwd)
               # $CONFIG_DATA >> $CONFIG_FILE
               # cd ..
               # echo "$CONFIG_DATA added into $CONFIG_FILE"
                echo "Copying $CONFIG_FILE into $CONFIG_DIR"
                mv $CONFIG_FILE $CONFIG_DIR/$CONFIG_FILE
                echo "$CONFIG_FILE moved to $CONFIG_DIR"
                echo  
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
        echo "stash_proj() called"
        echo ${REP_NAME}
        echo ${BRANCH_NAME}
        cd ${REP_NAME}
        git stash
        echo ${SPACE_LINE}
		cd ..
          pause
}
# ----------------------------------------------------------------------------------
# Function BOWER_INSTALL: User defined function
# ----------------------------------------------------------------------------------
bower_install(){
        echo ${SPACE_LINE}
        echo "BOWER_INSTALL() called."
	    echo ${REP_NAME}
        echo ${BRANCH_NAME}
        cd ${REP_NAME}
        npm install
        sleep 1	
        bower install
        echo ${SPACE_LINE}
        cd ..
        pause
}
# ----------------------------------------------------------------------------------
# Function START_SERVER: User defined function
# ----------------------------------------------------------------------------------
start_server(){
      echo ${SPACE_LINE}
      echo "START_SERVER() called."
      cd $REP_NAME
     nohup grunt serve &
      cd ..  
      echo ${SPACE_LINE}
          pause
}
# ----------------------------------------------------------------------------------
# Function STOP_SERVER: User defined function
# ----------------------------------------------------------------------------------
stop_server(){
      echo ${SPACE_LINE}
      echo "STOP_SERVER() called."
      ps -ef | grep grunt | grep -v grep
TO_KILL=ps -ef |grep grunt | grep -v grep | awk '{print $2}'
      echo "Process is going to kill $TO_KILL"
#      kill -9 $TO_KILL
      ps -ef |grep grunt | grep -v grep | awk '{print $2}' | xargs kill -9
      echo ${SPACE_LINE}
          pause
}
# ----------------------------------------------------------------------------------
# Function CHECKOUT_BRANCH: User defined function
# ----------------------------------------------------------------------------------
checkout_branch(){
      echo ${SPACE_LINE}
          echo "checkout_branch() called."
          echo ${REP_NAME}
          echo ${BRANCH_NAME}
          cd ${REP_NAME}
          git checkout ${BRANCH_NAME}
          echo ${SPACE_LINE}
          cd ..
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
    echo "      INSERT : 2 - CLONE"
    echo "      INSERT : 3 - STASH"
    echo "      INSERT : 4 - INSTALL DEPENDENCY"
    echo "      INSERT : 5 - START SERVER"
    echo "      INSERT : 6 - STOP SERVER"
        echo "      INSERT : 7 - CHECKOUT BRANCH"
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
                5) start_server ;;
                6) stop_server ;;
                7) checkout_branch ;;
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
