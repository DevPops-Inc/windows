#!/bin/python

# make folder in Python

# you can run this script with: python3 makeFolderInPython.py "< path to folder >" "< folder name >"

import colorama, os, sys, traceback
from colorama import Fore, Style 
from datetime import datetime
colorama.init()


def checkOs(): 
    print("Started checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System:", end="")
        os.system('ver')
        print(Style.RESET_ALL, end="")
        operatingSystem = "Windows"

    elif sys.platform == "darwin": 
        print(Fore.GREEN + "Operating System:")
        os.system('sw_vers')
        print(Style.RESET_ALL)
        operatingSystem = "macOS"

    elif sys.platform == "linux": 
        print(Fore.GREEN + "Operating System:")
        os.system('unrame -r')
        print(Style.RESET_ALL)
        operatingSystem = "Linux"

    print("Finished checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
    print("")
    return operatingSystem


def getPathToFolder(operatingSystem): 
    if operatingSystem == "Windows": 
        pathToFolder = str(input("Please type the path to where you want to make the folder and press the \"Enter\" key (Example: C:\\Users\\%USERNAME%\\Desktop): "))

    else: 
        pathToFolder = str(input("Please type the path to where you want to make the folder and press the \"return\" key (Example: /Users/$USER/Desktop): "))

    pathToFolder = os.path.expandvars(pathToFolder)
    print("")
    return pathToFolder


def getFolderName(operatingSystem): 
    if operatingSystem == "Windows": 
        folderName = str(input("Please type the name of the folder you wish to make and press the \"Enter\" key (Example: Repos): "))

    else: 
        folderName = str(input("Please type the name of the folder you wish to make and press the \"return\" key (Example: Repos): "))

    print("")
    return folderName


def checkParameters(pathToFolder, folderName): 
    print("Started checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
    valid = "true"

    print("Parameter(s):")
    print("--------------------------------------")
    print("pathToFolder: {0}".format(pathToFolder))
    print("folderName  : {0}".format(folderName))
    print("--------------------------------------")

    if pathToFolder == None: 
        print(Fore.RED + "pathToFolder is not set." + Style.RESET_ALL)
        valid = "false"

    if folderName == None: 
        print(Fore.RED + "folderName is not set." + Style.RESET_ALL)
        valid = "false"

    if valid == "true": 
        print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)

        print("Finished checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
        print("")

    else: 
        print(Fore.RED + "One or more parameter(s) are incorrect." + Style.RESET_ALL)

        print("Finished checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
        exit("")


def makeFolder(): 
    print("\nMake folder in Python.\n")
    operatingSystem = checkOs()

    if len(sys.argv) >= 2: 
        pathToFolder = str(sys.argv[1])
        folderName   = str(sys.argv[2])

    else: 
        pathToFolder = getPathToFolder(operatingSystem)
        folderName   = getFolderName(operatingSystem)

    checkParameters(pathToFolder, folderName)

    try: 
        startDateTime = datetime.now()
        
        print("Started making {0} at {1}".format(folderName, startDateTime.strftime("%m-%d-%Y %I:%M %p")))

        makePath="{0}/{1}".format(pathToFolder, folderName)
        os.mkdir(makePath)
        print(Fore.GREEN + "Successfully made {0}.".format(folderName) + Style.RESET_ALL)

        finishDateTime = datetime.now()

        print("Finished making {0} at {1}".format(folderName, finishDateTime.strftime("%m-%d-%Y %I:%M %p")))

        duration = finishDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception as e:
        print(Fore.RED + "Failed to make {0}.".format(folderName))
        print(e)
        print(traceback.print_stack)
        exit("" + Style.RESET_ALL)


makeFolder()
