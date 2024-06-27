#!/bin/python 

# check disk on Windows

# run this script as administrator
# haven't tested this script yet

import colorama, os, sys, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOsForWindows(): 
    print("Started checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System:", end=""); sys.stdout.flush()
        os.system('ver')
        print(Style.RESET_ALL, end="")

        print("Finished checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

        print("")

    else: 
        raise Exception("Sorry but this script only runs Windows.")


def checkDiskOnWindows():
    print("\nCheck disk on Windows.\n")
    checkOsForWindows()

    try: 
        startDateTime = datetime.now()
        print("Started checking disk on Windows at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        if os.system('echo y | chkdsk /f/r c:') != 0: 
            raise Exception("Error occurred while initializing check disk.")
        
        print(Fore.GREEN + "Successfully initiated check disk on next start up." + Style.RESET_ALL)

        finishedDateTime = datetime.now()

        print("Finished checking disk on Windows at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")
        
    except Exception: 
        print(Fore.RED + "Failed to check disk on Windows.")
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


checkDiskOnWindows()
