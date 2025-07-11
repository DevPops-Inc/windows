#!/bin/python

# check Node in Python 

import colorama, os, sys, subprocess, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOs():
    print("Started checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System:", end=""); sys.stdout.flush()
        os.system('ver')
        print(Style.RESET_ALL, end="")
        operatingSystem = "Windows"

    elif sys.platform == "darwin": 
        print(Fore.GREEN + "Operating System: ")
        os.system('sw_vers')
        print(Style.RESET_ALL, end="")
        operatingSystem = "macOS"

    elif sys.platform == "linux": 
        print(Fore.GREEN + "Operating System: ")
        os.system('uname -r')
        print(Style.RESET_ALL, end="")
        operatingSystem = "Linux"

    print("Finished checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    print("")
    return operatingSystem


def checkNode(): 
    print("\nCheck Node in Python.\n")

    try:
        operatingSystem = checkOs()
        
        startDateTime = datetime.now()
        print("Started checking Node at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        FNULL = open(os.devnull,  'w')

        if operatingSystem == "macOS" or operatingSystem == "Linux":
            checkNodeOnMacOrLinux = subprocess.call(['which', 'node'], stdout=FNULL) 

            if checkNodeOnMacOrLinux == 0:
                print(Fore.GREEN + "Node is installed."+ Style.RESET_ALL)
                os.system('node --version')
                print(Fore.GREEN + "Successfully checked Node." + Style.RESET_ALL)

                finishedDateTime = datetime.now()

                print("Finished checking Node at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

                duration = finishedDateTime - startDateTime
                print("Total execution time: {0} second(s)".format(duration.seconds))
                print("")

            else: 
                raise Exception("Node is not installed.")

        elif operatingSystem == "Windows": 
            checkNodeOnWindows = subprocess.call(['where', 'node'], stdout=FNULL)

            if checkNodeOnWindows == 0:
                print(Fore.GREEN + "Node is installed."+ Style.RESET_ALL)
                os.system('node --version')
                print(Fore.GREEN + "Successfully checked Node." + Style.RESET_ALL)

                finishedDateTime = datetime.now()

                print("Finished checking Node at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

                duration = finishedDateTime - startDateTime
                print("Total execution time: {0} second(s)".format(duration.seconds))
                print("")

            else: 
                raise Exception("Node is not installed.")
            
    except Exception: 
        print(Fore.RED + "Failed to check Node in Python.")
        traceback.print_exc()
        exit("" + Style.RESET_ALL)
        

checkNode()
