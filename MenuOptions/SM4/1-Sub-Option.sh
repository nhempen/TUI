#!/bin/bash
#Submen Function 
function smf ()
{
 dialog --title "$SM" \
        --msgbox "Selected Option" $SMHEIGHT $SMWIDTH
 submenu
} #END smf
smf

