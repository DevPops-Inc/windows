#!/bin/python

# count characters in last name

# you can run this script with: python3 countCharsLastNameInPython.py < last name > 

import colorama, os, sys, traceback
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

    print("Finished checking oeprating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    print("")
    return operatingSystem


def getLastName(operatingSystem): 
    if operatingSystem == "Windows": 
        lastName = str(input("Please type your last name and press \"Enter\" key (Example: Phan): "))

    elif operatingSystem == "macOS" or operatingSystem == "Linux": 
        lastName = str(input("Please type your last name and press \"return\" key (Example: Phan): "))

    print("")
    return lastName

    
def checkParameters(lastName): 
    print("Started checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
    valid = True

    print("Parameter(s):")
    print("------------------------------")
    print("lastName: {0}".format(lastName))
    print("------------------------------")

    if lastName == None or lastName == "": 
        print(Fore.RED + "lastName is not set." + Style.RESET_ALL)
        valid = False
    
    if valid == True: 
        print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)
        
        print("Finished checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
        print("")

    else: 
        raise Exception("One or more parameters are incorrect")


def countCharsInLastName(): 
    print("\nCount characters in last name in Python.\n")

    try: 
        operatingSystem = checkOs()

        if len(sys.argv) >= 2: 
            lastName = str(sys.argv[1])
        else: 
            lastName = getLastName(operatingSystem)

        checkParameters(lastName)
        
        startDateTime = datetime.now()
        
        print("Started counting characters in last name at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        count = len(lastName)
        print(Fore.BLUE + "\"{0}\" has {1} characters in it.".format(lastName, count))
        print(Fore.GREEN + "Successfully counted characters in last name." + Style.RESET_ALL)

        finishedDateTime = datetime.now()

        print("Finished counting characters in last name at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")
        
    except Exception: 
        print(Fore.RED + "Failed to count characters in last name.")
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


countCharsInLastName()
