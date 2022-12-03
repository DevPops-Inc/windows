#!/bin/python

# progessively print chars in Python

# you can run this script with: python3 progressivelyPrintCharsInPython.py '< input string >'

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


def getInputString(operatingSystem): 
    if operatingSystem == "Windows": 
        inputString = str(input("Please type an input string and press the \"Enter\" key (Example: Python rocks!): "))

    else: 
        inputString = str(input("Please type an input string and press the \"return\" key (Example: Python rocks!): "))

    print("")
    return inputString


def checkParameters(inputString): 
    print("Started checking parameter(s) at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
    valid = "true"

    print("Parameter(s):")
    print("------------------------------------")
    print("inputString: {0}".format(inputString))
    print("------------------------------------")

    if valid == "true": 
        print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)
        
        print("Finished checking parameters at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
        print("")

    else: 
        print(Fore.RED + "One or more parameters are incorrect." + Style.RESET_ALL)

        print("Finished checking parameters at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
        exit("")


def progressivelyPrintChars(): 
    print("\nProgressively print chars at in Python.\n")
    operatingSystem = checkOs()

    if len(sys.argv) >= 2: 
        inputString = str(sys.argv[1])

    else: 
        inputString = getInputString(operatingSystem)

    checkParameters(inputString)

    try: 
        startDateTime = datetime.now()
        print("Started progressively printing chars at", startDateTime.strftime("%Y-%m-%d %H:%M %p"))

        print(Fore.BLUE, end="")

        for char in inputString: 
            sys.stdout.write(char)
            sys.stdout.flush()
            time.sleep(0.25)

        print("")
        print(Fore.GREEN + "Successfully printed chars progressively." + Style.RESET_ALL)
        
        finishedDateTime = datetime.now()
        
        print("Finished progressively printing chars at", finishedDateTime.strftime("%Y-%m-%d %H:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception as e: 
        print(Fore.RED + "Failed to progressivey print chars.")
        print(e)
        print(traceback.print_stack)
        exit("" + Style.RESET_ALL)


progressivelyPrintChars()
