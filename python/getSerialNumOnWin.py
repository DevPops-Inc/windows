#!/bin/python

# get serial number on Windows

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
        raise Exception("Sorry but this script only runs on Windows.")


def getSerialNumber(): 
    print("\nGet serial number on Windows.\n")
    checkOsForWindows()

    try: 
        startDateTime = datetime.now()
        print("Started getting serial number at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        print(Fore.BLUE)

        if os.system('WMIC BIOS GET SERIALNUMBER') != 0: 
            raise Exception("Error occurred while getting serial number.")

        print(Fore.GREEN + "Successfully got serial number." + Style.RESET_ALL)

        finishedDateTime = datetime.now()
        
        print("Finished getting serial number at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception: 
        print(Fore.RED + "Failed to get serial number.") 
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


getSerialNumber()
