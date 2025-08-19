temp=$(mktemp -t test.XXXXXX) 
temp2=$(mktemp -t test2.XXXXXX) 
diskspace(){ 
clear 
df -k> $temp 
dialog --textbox $temp 20 50 
} 
whoseon() { 
clear 
who> $temp 
dialog --textbox $temp 20 50 
} 
memusage(){ 
clear 
cat /proc/meminfo> $temp 
dialog --textbox $temp 20 50 
} 
while [ 1 ] 
do 
clear 
dialog --menu "Sys Admin Menu" 20 30 10 1 "Display diskspace" 2 
"Display users" 3 "Display memory usage" 2> $temp2 
if [ $? -eq 1 ] 
then 
break 
fi 
selection=$(cat $temp2) 
case $selection in 
1) diskspace ;; 
2) whoseon ;; 
3) memusage ;; 
*) dialog --msgbox "Sorry, invalid selection" 10 30 
esac 
done 
clear 
rm -f $temp 2> /dev/null 
rm -f $temp2 2> /dev/null