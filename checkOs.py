#!/bin/python 

# check OS

import colorama, os, sys
from colorama import Fore, Style
from datetime import datetime
colorama.init()

def checkOs(): 
    print("Started checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))

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
    elif sys.platform == 'linux': 
        print(Fore.GREEN + "Operating System: ")
        print(os.system('uname -r'))
        print(Style.RESET_ALL)
        operatingSystem = "Linux"

    print("Finished checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))

    print("")
    return operatingSystem

operatingSystem = checkOs()
