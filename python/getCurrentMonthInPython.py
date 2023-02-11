#!/bin/python

# get current month in Python

import colorama, os, sys, time, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOs(): 
    print("Started checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System:", end=""); sys.stdout.flush()
        os.system('ver')
        print(Style.RESET_ALL)
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
    

def getCurrentMonthInPython():
    print("\nGet current month in Python.\n")
    checkOs()

    try: 
        startDateTime = datetime.now()
        print("Started getting current month at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        print(Fore.BLUE + "The current month is: {0}.".format(time.strftime("%B")))
        print(Fore.GREEN + "Successfully got current month." + Style.RESET_ALL)
        
        finishedDateTime = datetime.now()
        print("Finished getting current month at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception: 
        print(Fore.RED + "Failed to get current month.")
        
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


getCurrentMonthInPython()
