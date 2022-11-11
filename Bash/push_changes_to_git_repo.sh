#!/bin/bash

# push changes to GitHub

# you can run this script with: ./push_changes_to_git_repo.sh < staged changes > < commit message > 

stagedChanges=$1
commitMessage=$2

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

get_staged_changes() {
    if [ -z "${stagedChanges}" ]; then 
        git status
        
        if [ $OSTYPE != 'msys' ]; then 
            read -p "Please type the file with changes you wish to stage and press \"return\" key (Example: main.js): " stagedChanges

            echo ""
        else 
            read -p "Please type the file with changes you wish to stage and press \"Enter\" key (Example: main.js): " stagedChanges
        fi

    else 
        echo "${stagedChanges}" &>/dev/null
    fi
}

get_commit_message() {
    if [ -z "${commitMessage}" ]; then 
        
        if [ $OSTYPE != 'msys' ]; then 
            read -p "Please type the commit message and press \"return\" key (Example: Initial commit): " commitMessage

            echo ""
        else 
            read -p "Please type the commit message and press \"Enter\" key (Example: Initial commit): " commitMessage

            echo ""
        fi
    
    else 
        echo "${commitMessage}" $>/dev/null
    fi
}

check_parameters() {
    echo "Started checking parameters at $(date)"
    valid="true"

    echo "Parameters:"
    echo "-----------------------------"
    echo "stagedChanges: ${stagedChanges}"
    echo "commitMessage: ${commitMessage}"
    echo "-----------------------------"

    if [ -z "${stagedChanges}" ]; then 
        tput setaf 1; echo "stagedChanges is not set."; tput sgr0
        valid="false"
    fi

    if [ -z "${commitMessage}" ]; then 
        tput setaf 1; echo "commitMessage is not set."; tput sgr0
        valid="false"
    fi

    if [ $valid == "true" ]; then 
        tput setaf 2; echo "All parameter checks passsed."; tput sgr0

        echo "Finished checking parameters at $(date)"
        echo ""
    else 
        tput setaf 1; echo "One ore more parameters are incorrect."; tput sgr0

        echo "Finished checking parameters at $(date)"
        echo ""

        exit 1
    fi
}

push_git_changes() {
    printf "\nPush changes to Git repository.\n\n"
    check_os

    get_staged_changes
    get_commit_message
    check_parameters

    start=$(date +%s)
    echo "Started pushing changes at $(date)"

    git add "$stagedChanges"
    echo ""

    git commit -m "$commitMessage"
    echo ""

    git push
    echo ""

    git status
    echo ""

    tput setaf 2; echo "Successfully pushed changes to Git repository."; tput sgr0

    end=$(date +%s)
    echo "Finished pushing changes at $(date)"

    duration=$(( $end - $start ))
    echo "Total execution time: $duration second(s)"
    echo ""
}

push_git_changes
