#!/bin/bash
#Copyright ECU created by Nicholas Hempenius September 30, 2019
#This is the configuration Menu for TUI
#Menu Title
SMCTITLE='TUI Configuration'
#Menu Options text
SMC_1='Enable TUI on Login'
#Menu Options text
SC1_1='TUI Auto start'
SC1_2='SE Option2'
SC1_3='SE Option3'
SC1_4='Log Out'
USERN="`whoami`"
#SubMenu :
function confmenu()
{
 OPTION=$(dialog --title "$SMCTITLE" \
                 --no-cancel --no-tags \
                 --menu "Choose an Option" 15 60 5 \
        "1" "$SC1_1" \
        "2" "$SC1_2" \
        "3" "$SC1_3" \
        "4" "$SC1_4" \
        "5" "$RETURN_MAINMENU" 3>&1 1>&2 2>&3)
 exitstatus=$?

 case $OPTION in
        1)
         autostartemtui
         ;;
        2)
         dialog --title "Option $SC1_2" --msgbox "You selected the $SC1_2 option. Hit OK to continue." 8 70
         confmenu
         ;;
        3)
         dialog --title "Option $SC1_3" --msgbox "You selected the $SC1_3 option. Hit OK to continue." 8 70
         confmenu
         ;;
        4)
         dialog --title "Option $SC1_4" --msgbox "You selected the $SC1_4 option. Hit OK to continue." 8 70
         confmenu
         ;;
        5)
         echo "123"
         main
 esac
}



#SubMenu 1:
function autostartemtui()
{
 ASTITLE="Auto start TUI"
 OFSTATE="off"
 #Check if TUI is already set to start on login
 grep "/home/${USERN}/MANAGE/TUI-Menu.sh" /home/${USERN}/.bash_profile && OFSTATE="on"
 if [ $OFSTATE = "on" ]
  then
   SMC_1='(Enabled) TUI on Login'
   OPTION=$(dialog --title "$SMCTITLE" --no-tags --menu "$ASTITLE" 15 60 1 \
        "2" "$SMC_1" 3>&1 1>&2 2>&3)
   [ $? -eq 1 ] && confmenu
  elif [ $OFSTATE = "off" ]
   then
   SMC_1='(Disabled) TUI on Login'
   OPTION=$(dialog --title "$SMCTITLE" --no-tags --menu "$ASTITLE" 15 60 1 \
        "1" "$SMC_1" 3>&1 1>&2 2>&3)
   [ $? -eq 1 ] && confmenu
  else
   confmenu
 fi
 case $OPTION in
        1)
         echo "/home/${USERN}/MANAGE/TUI-Menu.sh" >> /home/${USERN}/.bash_profile 
         autostartemtui
         ;;
        2)
         sed -i '/\/home\/${USERN}\/MANAGE\/TUI\-Menu\.sh/d' /home/${USERN}/.bash_profile
         autostartemtui
         ;;
        5)
         confmenu
         ;;
 esac
}
confmenu      
