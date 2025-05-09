#!/bin/python

# rename computer on Windows

# haven't tested this script on local PC without being on domain yet
# run this script as admin
# you can run this script: python3 renameComputerOnWin.py < new name > 

import colorama, os, sys, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOsForWindows():

    print("Started checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M: %p"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System:", end=""); sys.stdout.flush()
        os.system('ver')
        print(Style.RESET_ALL, end="")

        print("Finished checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M: %p"))

        print("")

    else: 
        raise Exception("Sorry but this script only runs on Windows.")


def getOldName(): 
    oldName = os.getenv('COMPUTERNAME') 
    
    if oldName == None: 

        oldName = str(input("Please type the computer's current name and press the \"Enter\" key (Example: Victors-PC): "))
        
    print("")
    return oldName


def getNewName(): 
    newName = str(input("Please type the new name and press the \"Enter\" key (Example: Vics-PC): "))

    print("")
    return newName


def checkParameters(oldName, newName): 
    print("Started checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M: %p"))
    valid = True

    print("Parameter(s):")
    print("-----------------------------")
    print("oldName : {0}".format(oldName))
    print("nameName: {0}".format(newName))
    print("-----------------------------")

    if oldName == None or oldName == "": 
        print(Fore.RED + "oldName is not set." + Style.RESET_ALL)
        valid = False

    if newName == None or newName == "": 
        print(Fore.RED + "newName is not set." + Style.RESET_ALL)
        valid = False

    if valid == True: 
        print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)

        print("Finished checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M: %p"))

        print("")

    else: 
        raise Exception("One or more parameters are incorrect.")


def renameComputer(): 
    print("\nRename computer on Windows.\n")

    try: 
        checkOsForWindows()
        
        oldName = getOldName()

        if len(sys.argv) >= 2: 
            newName = sys.argv[1]

        else: 
            newName = getNewName()

        checkParameters(oldName, newName)

        startDateTime = datetime.now()
        print("Started renaming computer at", startDateTime.strftime("%m-%d-%Y %I:%M: %p"))

        print("Your computer's current name is: {0}".format(oldName))
        
        renameComputer = "WMIC computersystem where name='{0}' call rename '{1}'".format(oldName, newName) 
        
        if os.system(renameComputer) != 0: 
            raise Exception("Error occurred while renaming computer.")
        
        print(Fore.BLUE + "Your computer's current name is: \n")
        os.getenv('COMPUTERNAME') 
        print(Fore.GREEN + "Successfully renamed computer." + Style.RESET_ALL)

        finishedDateTime = datetime.now()

        print("Finished renaming computer at", finishedDateTime.strftime("%m-%d-%Y %I:%M: %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception: 
        print(Fore.RED + "Failed to rename computer.")
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


renameComputer()
