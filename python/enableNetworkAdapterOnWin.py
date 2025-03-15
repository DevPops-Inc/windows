#!/bin/python 

# enable network adapter on Windows

# you can run this script with: python3 enableNetworkAdapaterOnWinn.py < network adapter >

import colorama, os, sys, time, traceback
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
		

def getNetworkAdapter(): 
	os.system('netsh interface show interface')

	networkAdapter = str(input("Please type the interface name of the network adapter you wish to enable and press the \"Enter\" key (Example: Wi-Fi): "))
	
	print("")
	return networkAdapter


def checkParameters(networkAdapter): 
	print("Started checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
	valid = True
	
	print("Parameter(s):")
	print("------------------------------------------")
	print("networkAdapter: {0}".format(networkAdapter))
	print("------------------------------------------")
	
	if networkAdapter == None or networkAdapter == "": 
		print(Fore.RED + "networkAdapter is not set." + Style.RESET_ALL)
		valid = False
		
	if valid == True: 
		print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)
		
		print("Finished checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
		print("")
		
	else: 
		raise Exception("One or more parameters are incorrect.")
		

def enableNetworkAdapter(): 
	print("\nEnable network adapter on Windows.\n")

	try: 
		checkOsForWindows()
	
		if len(sys.argv) >= 2:
			networkAdapter = str(sys.argv[1])

		else: 
			networkAdapter = getNetworkAdapter()

		checkParameters(networkAdapter)

		startDateTime = datetime.now()
		
		print("Started enabling {0} at {1}".format(networkAdapter, startDateTime.strftime("%m-%d-%Y %I:%M: %p")))

		enableNetworkAdapter = "netsh interface set interface {0} enable".format(networkAdapter)
		
		if os.system(enableNetworkAdapter) != 0: 
			raise Exception("Coudln't enable network adapter.")

		time.sleep(5)
		os.system('netsh interface show interface')

		print(Fore.GREEN + "Successfully enabled {0}.".format(networkAdapter) + Style.RESET_ALL)		

		finishedDateTime = datetime.now()
		print("Finished enabling {0} at {1}".format(networkAdapter, finishedDateTime))

		duration = finishedDateTime - startDateTime
		print("Total execution time: {0} second(s)".format(duration.seconds))
		print("")

	except Exception: 
		print(Fore.RED + "Failed to enable {0}.".format(networkAdapter))
		traceback.print_exc()
		exit("" + Style.RESET_ALL)


enableNetworkAdapter()
