#!/bin/python

# enable local admin account and set password on Windows

# you can run this script with: python3 enableLocalAdminSetPwOnWin.py < local admin password > 

# haven't successfully tested this script on Windows yet since all of the test passwords I've tried don't meet the minimum security requirements of my OS

import colorama, getpass, os, sys, traceback
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
		
		
def getLocalAdminPw(): 
	localAdminPw = getpass.getpass("Please type the password for the local admin account and press the \"Enter\" key (Example: Password123): ")
	
	print("")
	return localAdminPw


def checkParameters(localAdminPw): 
	print("Started checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
	valid = True
	
	print("Parameter(s):")
	print("-------------------------------")
	print("localAdminPw: {0}",format("***"))
	print("-------------------------------")
	
	if localAdminPw == None or localAdminPw == "": 
		print(Fore.RED + "localAdminPw is not set." + Style.RESET_ALL)
		valid = False
		
	if valid == True: 
		print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)
		
		print("Finished checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
		print("")
		
	else: 
		raise Exception("One or more parameters are incorrect.")
		

def enableLocalAdminAndSetPw(): 
	print("\nEnable local admin and set passsword on Windows.\n")
	
	try:
		checkOsForWindows()

		if len(sys.argv) >= 2: 
			localAdminPw = str(sys.argv[1])

		else: 
			localAdminPw = getLocalAdminPw()

		checkParameters(localAdminPw)

		startDateTime = datetime.now()

		print("Started enabling local admin and setting password at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))
		
		activateLocalAdmin = 'net user administrator /active:yes'
		setLocalAdminPw = "net user administrator {0}".format(localAdminPw)
		
		setLocalAdminPwNeverExp = "WMIC USERACCOUNT WHERE Name='administrator' SET PasswordExpires=FALSE"

		getLocalAdminExpPolicy = 'net user administrator | findstr /C:expires'

		enableLocalAdmin = [activateLocalAdmin, setLocalAdminPw, setLocalAdminPwNeverExp, getLocalAdminExpPolicy]
	
		for enable in enableLocalAdmin:
			if os.system(enable) != 0: 
				raise Exception("Error occurred while enabling local admin.")
				
		finishedDateTime = datetime.now()

		print("Finished enabling local admin and setting password at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))
		
		duration = finishedDateTime - startDateTime
		print("Total execution time: {0} second(s)".format(duration.seconds))
		print("")
		
	except Exception: 
		print(Fore.RED + "Failed to enable local admin and set password.")
		traceback.print_exc()
		exit("" + Style.RESET_ALL)
		
		
enableLocalAdminAndSetPw()
