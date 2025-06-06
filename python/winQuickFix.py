#!/bin/python

# Windows quick fix

# run this script as admin

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


def winQuickFix(): 
    print("\nWindows quick fix.\n")

    try: 
        checkOsForWindows()
        
        startDateTime = datetime.now()
        print("Started Windows quick fix at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        if os.system('echo y | chkdsk /f c:') != 0: 
            raise Exception("Error occurred while performing Windows quick fix.")

        print(Fore.GREEN + "Successfully performed Windows quick fix." + Style.RESET_ALL)

        finishedDateTime = datetime.now()
        print("Finshed Windows quick fix at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

        print("Please save your documents and close applications.")
        input("Press any key to continue.")
        
        if os.system('shutdown /r /t 0') != 0: 
            raise Exception("Error occurred while restarting computer.")

    except Exception: 
        print(Fore.RED + "Failed to perform Windows quick fix.")
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


winQuickFix()
