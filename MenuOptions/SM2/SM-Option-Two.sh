#!/bin/bash
######################
### Option Submenu ###
######################
#Menu Title
SMTITLE='Sub Menu'
SMHEIGHT="15"
SMWIDTH="30"
SMFUNC="smf"
#Location of Tools used by this submenu
TOOLS=$SMHOME/tools
#
function get_menus()
{
 I=0
 MENUS=()
 MENUSSOURCE=()
 MENUFILES="$(ls "$SMHOME" | grep ^[0-9]-)"
 for FILE in $MENUFILES; do
  HEAD="`echo $FILE | cut -d "-" -f1`"
  CHECKFILEDUPS="`echo "$MENUFILES" | grep -o ^$HEAD- | wc -l`"
  [[ $CHECKFILEDUPS -gt 1 ]] && errormsg "There are duplicate files for a menu option$HEAD in \"$SMHOME\"." "main"
  TITLE="`echo "$FILE" |tr '-' ' '|sed -e 's/\.sh//' |cut -d " " -f2-`"
  MENUS+=("$I" "$TITLE")
  MENUSSOURCE+=("$FILE")
  let I=$I+1
 done
 MENUCOUNT=$((( ${#MENUS[@]} / 2) + 1 ))
} #END get_menus
#Sub Menu :
function submenu()
{
 get_menus
 OPTION=""
 OPTION=$(dialog --title "$SMTITLE" \
                 --no-cancel --no-tags \
                 --menu "Choose an Option" $SMHEIGHT $SMWIDTH $MENUCOUNT \
                 "${MENUS[@]}" \
	         "$MENUCOUNT" "$RETURN_MAINMENU" 3>&1 1>&2 2>&3)

 if [[ $OPTION -eq $MENUCOUNT ]]
  then
   main
  else
   source "${SMHOME}/${MENUSSOURCE[$OPTION]}" || errormsg "Could not load source file\n\"${SMHOME}/${MENUSSOURCE[$OPTION]}\"\nFor Menu option$OPTION." "submenu"
 fi
} #END submenu
submenu
