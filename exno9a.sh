#!/bin/bash


diskspace() {
    clear
    echo "Disk Space Usage (in Kilobytes):\n"
    df -k
}


whoseon() {
    clear
    echo "Currently Logged On Users:\n"
    who
}


memusage() {
    clear
    echo "Memory Usage Information:\n"
    cat /proc/meminfo
}


while true; do
    clear

    echo
    echo -e "\t\t\tSys Admin Menu\n"
    echo -e "\t\t1. Display disk space"
    echo -e "\t\t2. Display logged on users"
    echo -e "\t\t3. Display memory usage"
    echo -e "\t\t0. Exit program\n\n"
    echo -e "\t\t\tEnter option: \c"


    read option


    case $option in
        0)
            break ;;
        1)
            diskspace ;;
        2)
            whoseon ;;
        3)
            memusage ;;
        *)
            clear
            echo "Sorry, wrong selection" ;;
    esac

    echo "\n\n\t\t\tHit any key to continue"
    read -n 1 -s
done 

clear
echo "Exiting program."