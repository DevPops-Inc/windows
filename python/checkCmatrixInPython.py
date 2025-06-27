#!/bin/python

# check cmatrix in Python 

import colorama, os, sys, subprocess, time, traceback
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


def checkCmatrix(): 
    print("\nCheck cmatrix in Python.\n")

    try:
        operatingSystem = checkOs()
        
        startDateTime = datetime.now()
        print("Started checking cmatrix at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        FNULL = open(os.devnull, 'w')

        if operatingSystem == "macOS" or operatingSystem == "Linux":
            checkCmatrixOnMacOrLinux = subprocess.call(['which', 'cmatrix'], stdout=FNULL) 

            if checkCmatrixOnMacOrLinux == 0:
                print(Fore.GREEN + "cmatrix is installed."+ Style.RESET_ALL)
                print("")

                print("Do you want to run cmatrix now?" + Fore.BLUE)
                answer = str(input("Please press \"Y\" or \"N\" and the \"return\" key: "))

                if answer == "Y":
                    print("Press the \"control\" and \"C\" keys when you're ready to quit cmatrix." + Style.RESET_ALL)

                    time.sleep(5)
                    os.system('cmatrix')

                print(Fore.GREEN + "Successfully checked cmatrix." + Style.RESET_ALL)

                finishedDateTime = datetime.now()

                print("Finished checking cmatrix at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

                duration = finishedDateTime - startDateTime
                print("Total execution time: {0} second(s)".format(duration.seconds))
                print("")

            else: 
                raise Exception("cmatrix is not installed.")

        elif operatingSystem == "Windows": 
            checkCmatrixOnWindows = subprocess.call(['where', 'cmatrix'], stdout=FNULL)

            if checkCmatrixOnWindows == 0:
                print(Fore.GREEN + "cmatrix is installed."+ Style.RESET_ALL)
                print("")

                print("Do you want to run cmatrix now?" + Fore.BLUE)
                answer = str(input("Please press \"Y\" or \"N\" and the \"Enter\" key: "))

                if answer == "Y":
                    print("Press the \"Ctrl\" and \"C\" keys when you're ready to quit cmatrix." + Style.RESET_ALL)

                    time.sleep(5)
                    os.system('cmatrix')

                print(Fore.GREEN + "Successfully checked cmatrix." + Style.RESET_ALL)

                finishedDateTime = datetime.now()

                print("Finished checking cmatrix at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

                duration = finishedDateTime - startDateTime
                print("Total execution time: {0} second(s)".format(duration.seconds))
                print("")

            else: 
                raise Exception("cmatrix is not installed.")
                
    except Exception: 
        print(Fore.RED + "Failed to check cmatrix in Python.")
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


checkCmatrix()
