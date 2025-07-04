#!/bin/python 

# change local user password on Windows 

# you can run this script with changeLocalUserPwOnWin.py < local user > < new password >

import colorama, getpass, os, sys, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOsForWindows(): 
    print("Checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    if sys.platform == "win32":
        print(Fore.GREEN + "Operating System:", end=""); sys.stdout.flush()
        os.system('ver')
        print(Style.RESET_ALL, end="")
        
        print("Finished checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

        print("")

    else:
        raise Exception("Sorry this script only runs on Windows.")


def getLocalUser(): 
	localUser = str(input("Please type the local user you wish to change the password for and press the \"Enter\" key (Example: local.user): "))

	print("")
	return localUser


def getNewPw(): 
    newPassword = getpass.getpass("Please type the new password and press \"Enter\" key (Example: Password123): ")

    print("")
    return newPassword


def checkParameters(localUser, newPassword):
    print("Started checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
    valid = True

    print("Parameter(s):")
    print("----------------------------------")
    print("localUser  : {0}".format(localUser))
    print("newPassword: {0}".format("***"))
    print("----------------------------------")

    if localUser == None or localUser == "": 
        print(Fore.RED + "localUser is not set." + Style.RESET_ALL)
        valid = False

    if newPassword == None or newPassword == "": 
        print(Fore.RED + "newPassword is not set." + Style.RESET_ALL)
        valid = False

    if valid == True: 
        print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)

        print("Finished checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
        
        print("")
    else: 
        raise Exception("One or more parameters are incorrect.")


def changeLocalUserPw():
    print("\nChange local user password on Windows.\n")
    
    try: 
        checkOsForWindows()

        if len(sys.argv) >= 2:
            localUser   = str(sys.argv[1])
            newPassword = str(sys.argv[2])

        else: 
            localUser   = getLocalUser()
            newPassword = getNewPw() 

        checkParameters(localUser, newPassword)
        
        startDateTime = datetime.now()

        print("Started changing password for {0} at {1}".format(localUser,startDateTime.strftime("%m-%d-%Y %I:%M %p")))
		
        setPassword = "net user {0} {1}".format(localUser, newPassword)
        getUserInfo = "net user {0}".format(localUser)
        
        if os.system(setPassword) != 0: 
            raise Exception("Cannot set password.")  
        
        print(Fore.BLUE, end="")
        os.system(getUserInfo)
            
        print(Fore.GREEN + "Successfully changed password for {0}".format(localUser) + Style.RESET_ALL)
		
        finishedDateTime = datetime.now()
		
        print("Finished changing password for {0} at {1}".format(localUser, finishedDateTime.strftime("%m-%d-%Y %I:%M %p")))
		
        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception as e:
        print(Fore.RED + "Failed to change password for {0}".format(localUser))
        traceback.print_exc()
        exit("" + Style.RESET_ALL)
		
		
changeLocalUserPw()
