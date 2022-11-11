#!/bin/bash

# check operating system in Bash

check_os() {
    echo "Started checking operating system at $(date)"

    if [[ $OSTYPE == 'darwin'* ]]; then 
        tput setaf 2; echo -e "Operating system:\n$(sw_vers)"; tput sgr0
        
        echo "Finished checking operating system at $(date)"
        echo ""
    else 
        tput setaf 2; echo "Operating system: $OSTYPE"; tput sgr0

        echo "Finished checking oeprating system at $(date)"
        echo ""
    fi 
}

check_os
