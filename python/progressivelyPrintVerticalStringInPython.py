#!/bin/python

# progressively print vertical string 

# you can run this script with: python3 progressivelyPrintVerticalStringInPython.py '< vertical string >'

import colorama, os, sys, time, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOs(): 
    print("Started checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System:", end="")
        os.system('ver')
        print(Style.RESET_ALL, end="")
        operatingSystem = "Windows"

    elif sys.platform == "darwin": 
        print(Fore.GREEN + "Operating System:")
        os.system('sw_vers')
        print(Style.RESET_ALL, end="")
        operatingSystem = "macOS"
        
    elif sys.platform == "linux": 
        print(Fore.GREEN + "Operating System:")
        os.system('uname -r')
        print(Style.RESET_ALL, end="")
        operatingSystem = "Linux"

    print("Finished checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
    print("")
    return operatingSystem


def getVerticalString(operatingSystem): 
    if operatingSystem == "Windows": 
        verticalString = str(input("Please type the string you would like to print vertically and press the \"Enter\" key (Example: Python is fun!): " ))  

        print("")

    else: 
        verticalString = str(input("Please type the string you would like to print vertically and press the \"Enter\" key (Example: Python is fun!): " ))  

        print("")

    return verticalString


def checkParameters(verticalString): 
    print("Started checking parameter(s) at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
    valid = "true"

    print("Parameter(s):")
    print("------------------------------------------")
    print("verticalString: {0}".format(verticalString))
    print("------------------------------------------")

    if verticalString == None: 
        print(Fore.RED + "Vertical string is not set." + Style.RESET_ALL)
        valid = "false"

    if valid == "true": 
        print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)

        print("Finished checking parameter(s) at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
        print("")

    else: 
        print(Fore.RED + "One or more parameter checks are incorrect." + Style.RESET_ALL)

        print("Finished checking parameter(s) at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
        exit("")


def progressivelyPrintVerticalString(): 
    print("Progressively print vertical string in Python.\n")
    operatingSystem = checkOs()

    if len(sys.argv) >= 2: 
        verticalString = sys.argv[1]

    else: 
        verticalString = getVerticalString(operatingSystem)

    checkParameters(verticalString)

    try: 
        startDateTime = datetime.now()

        print("Started progressively printing {0} at {1}".format(verticalString, startDateTime.strftime("%Y-%m-%d %H:%M %p")))

        for char in verticalString: 
            print(Fore.BLUE + char)
            time.sleep(.25)

        print(Fore.GREEN + "Succesfully printed {0} progressively.".format(verticalString) + Style.RESET_ALL)

        finishedDateTime = datetime.now()

        print("Finished progressively printing {0} at {1}".format(verticalString, finishedDateTime.strftime("%Y-%m-%d %H:%M %p")))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception as e: 
        print(Fore.RED + "Failed to progressively print {0}".format(verticalString))
        print(e)
        print(traceback.print_stack)
        exit("" + Style.RESET_ALL)
    

progressivelyPrintVerticalString()
