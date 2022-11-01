#!/bin/python

# display first letter in name 

# you can run this script with: python3 displayFirstLetterInNameInPython.py < name > 

import colorama, os, sys, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOs(): 
    print("Started checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))

    if sys.platform == "win32":
        print(Fore.GREEN + "Operating System: ", end="")
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
        print(os.system('unrame -r'))
        print(Style.RESET_ALL, end="")
        operatingSystem = "Linux"

    print("Finished checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))

    print("")
    return operatingSystem


def getName(operatingSystem): 
    if operatingSystem == "Windows": 
        name = str(input("Please type your name and press \"Enter\" key (Example: Vic): "))

    elif operatingSystem == "macOS" or operatingSystem == "Linux": 
        name = str(input("Please type your name and press \"return\" key (Example: Vic): "))

    print(Fore.BLUE + "Hello, {0}.".format(name) + Style.RESET_ALL)
    print("")
    return name


def checkParameters(name): 
    print("Started checking parameters at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
    valid = "true"

    print("Parameters:")
    print("----------------------")
    print("name: {0}".format(name))
    print("----------------------")

    if name == None: 
        print(Fore.RED + "name is not set." + Style.RESET_ALL)
        valid = "false"
    
    if valid == "true": 
        print(Fore.GREEN + "All parameter checks passed." + Style.RESET_ALL)

        print("Finished checking parameters at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
        
        print("")
    
    else: 
        print(Fore.RED + "One or more parameter checks are incorrect." + Style.RESET_ALL)

        print("Finished checking parameters at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))

        exit("")


def displayFirstLetterInName(): 
    print("\nDisplay first letter in name in Python.\n")
    operatingSystem = checkOs()

    if len(sys.argv) >= 2: 
        name = str(sys.argv[1])

    else: 
        name = getName(operatingSystem)

    checkParameters(name)

    try: 
        startDateTime = datetime.now()

        print("Started displaying first letter in name at", startDateTime.strftime("%Y-%m-%d %H:%M %p"))

        lname=list(name)
        print(Fore.BLUE + "The first letter of your name is {0}.".format(*lname))
        
        print(Fore.GREEN + "Successfully displayed the first letter of name." + Style.RESET_ALL)

        finishedDateTime = datetime.now()
        
        print("Finished displaying first letter in name at", finishedDateTime.strftime("%Y-%m-%d %H:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception as e: 
        print(Fore.RED + "Failed to display first letter in name.")
        print(e)
        print(traceback.print_stack)
        exit("" + Style.RESET_ALL)


displayFirstLetterInName()
