#!/bin/python

# check Terraform in Python 

import colorama, os, sys, subprocess, traceback
from colorama import Fore, Style
from datetime import datetime
colorama.init()

def checkOs():
    print("Started checking operating system at", datetime.now().strftime("%Y-%m-"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System: ")
        print(os.system('ver'))
        print(Style.RESET_ALL)
        operatingSystem = "Windows"

    elif sys.platform == "darwin": 
        print(Fore.GREEN + "Operating System: ")
        print(os.system('sw_vers'))
        print(Style.RESET_ALL)
        operatingSystem = "macOS"

    elif sys.platform == "linux": 
        print(Fore.GREEN + "Operating System: ")
        print(os.system('uname -r'))
        print(Style.RESET_ALL)
        operatingSystem = "Linux"

    print("Finished checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))

    print("")
    return operatingSystem

def checkTerraform(): 
    print("\nCheck Terraform in Python.\n")
    operatingSystem = checkOs()

    try:
        startDateTime = datetime.now()
        
        print("Started checking Terraform at", startDateTime.strftime("%Y-%m-%d %H:%M %p"))

        FNULL = open(os.devnull,'w')

        if operatingSystem == "macOS" or operatingSystem == "Linux":

            checkTerraformOnMacOrLinux = subprocess.call(['which', 'terraform'], stdout=FNULL) 

            if checkTerraformOnMacOrLinux == 0:
                print(Fore.GREEN + "Terraform is installed."+ Style.RESET_ALL)
                os.system('terraform --version')
                print(Fore.GREEN + "Successfully checked terraform." + Style.RESET_ALL)

                finishedDateTime = datetime.now()

                print("Finished checking Terraform at", finishedDateTime.strftime("%Y-%m-%d %H:%M %p"))

                duration = finishedDateTime - startDateTime
                print("Total execution time: {0} second(s)".format(duration.seconds))
                print("")

            else: 
                print(Fore.RED + "Terraform is not installed." + Style.RESET_ALL)
                
                finishedDateTime = datetime.now()

                print("Finished checking Terraform at", finishedDateTime.strftime("%Y-%m-%d %H:%M %p"))

                duration = finishedDateTime - startDateTime
                print("Total execution time: {0} second(s)".format(duration.seconds))
                exit("")

        elif operatingSystem == "Windows": 
            
            checkTerraformOnWindows = subprocess.call(['where', 'terraform'], stdout=FNULL)

            if checkTerraformOnWindows == 0:
                print(Fore.GREEN + "Terraform is installed."+ Style.RESET_ALL)
                os.system('terraform --version')
                print(Fore.GREEN + "Successfully checked terraform." + Style.RESET_ALL)

                finishedDateTime = datetime.now()

                print("Finished checking Terraform at", finishedDateTime.strftime("%Y-%m-%d %H:%M %p"))

                duration = finishedDateTime - startDateTime
                print("Total execution time: {0} second(s)".format(duration.seconds))
                print("")

            else: 
                print(Fore.RED + "Terraform is not installed." + Style.RESET_ALL)
                
                finishedDateTime = datetime.now()

                print("Finished checking Terraform at", finishedDateTime.strftime("%Y-%m-%d %H:%M %p"))

                duration = finishedDateTime - startDateTime
                print("Total execution time: {0} second(s)".format(duration.seconds))
                exit("")
                
    except Exception as e: 
        print(Fore.RED + "Failed to check Terraform in Python.")
        print(e)
        print(traceback.print_stack)
        exit("" + Style.RESET_ALL)

checkTerraform()
