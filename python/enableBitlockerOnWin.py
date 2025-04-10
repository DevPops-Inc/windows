#!/bin/python

# enable BitLocker on Windows

# haven't tested this on a Windows PC yet

import colorama, os, sys, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOsForWindows(): 
	print("Started checking operating system at", datetime.now().strftime("%m-%d-Y %I:%M %p"))
	
	if sys.platform == "win32": 
		print(Fore.GREEN + "Operating System:", end=""); sys.stdout.flush()
		os.system('ver')
		print(Style.RESET_ALL)
		
		print("Finished checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
		
		print("")
	else: 
		raise Exception("Sorry but this script only runs on Windows.")	
		
		
def enableBitLocker(): 
	print("\nEnable BitLocker on Windows.\n")
	
	try: 
		checkOsForWindows()
		
		startDateTime = datetime.now()
		print("Started enabling BitLocker at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))
		
		if os.system('manage-bde -on C:') != 0:
			raise Exception("Error occurred while enabling BitLocker.")
		
		print(Fore.GREEN + "Successfully enabled BitLocker." + Style.RESET_ALL)
		
		finishedDateTime = datetime.now()
		print("Finished enabling BitLocker at", finishedDateTime.strftime("%m-%d-Y %I:%M %p"))
		
		duration = finishedDateTime - startDateTime
		print("Total execution time: {0} second(s)".format(duration.seconds))
		print("")
		
	except Exception as e:
		print(Fore.RED + "Failed to enable BitLocker.")
		traceback.print_exc()
		exit("" + Style.RESET_ALL)
		
		
enableBitLocker()
