#!/bin/bash
#Copyright ECU Created by Nicholas Hempenius
#Submen Function 
function smf ()
{
 dialog --title "$SM" \
        --msgbox "Selected Option" $SMHEIGHT $SMWIDTH
 submenu
} #END smf
smf

