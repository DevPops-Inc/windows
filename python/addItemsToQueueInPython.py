#!/bin/python

# add items to queue in Python

import colorama, os, sys, traceback
from collections import deque
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOs(): 
    print("Started checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System: ", end="")
        os.system('ver')
        print(Style.RESET_ALL, end="")
        operatingSystem = "Windows"

    if sys.platform == "darwin": 
        print(Fore.GREEN + "Operating System: ")
        os.system('sw_vers')
        print(Style.RESET_ALL, end="")
        operatingSystem = "macOS"

    if sys.platform == "linux": 
        print(Fore.GREEN + "Operating System: ")
        os.system('uname -r')
        print(Style.RESET_ALL, end="")
        operatingSystem = "Linux"
    
    print("Finished checking operating system at", datetime.now().strftime("%Y-%m-%d %H:%M %p"))
    print("")
    return operatingSystem


def addItemsToQueue(): 
    print("\nAdd items to queue in Python.\n")
    operatingSystem = checkOs()

    try: 
        startDateTime = datetime.now()
        print("Started adding items to queue at", startDateTime.strftime("%Y-%m-%d %H:%M %p"))

        queue = deque()
  
        if operatingSystem == "Windows": 
            answer = int(input("Please type how many items you would like to add to the queue and press the \"Enter\" key (Example: 4): "))
            print("")

            def getAppendOnWin(answer): 
                if answer > 0:
                    queueItem = str(input("Please type the item you wish to add into the queue and press the \"Enter\" key (Example: 1): "))
                    print("")
        
                    queue.append(queueItem)
                    getAppendOnWin(answer-1)

            getAppendOnWin(answer)
                
        elif operatingSystem == "macOS" or operatingSystem == "Linux": 
            answer = int(input("Please type how many items you would like to add to the queue and press the \"return\" key (Example: 4): "))
            print("")

            def getAppendOnMacOrLinux(answer): 
                if answer > 0: 
                    queueItem = str(input("Please type the item you wish to add into the queue and press the \"return\" key (Example: 1): "))
                    print("")

                    queue.append(queueItem)
                    getAppendOnMacOrLinux(answer-1)

            getAppendOnMacOrLinux(answer)
            
        print(Fore.BLUE)
        print("Here is your queue: {0}".format(queue))
        print(Fore.GREEN + "Successfully added items to queue." + Style.RESET_ALL)

        finishedDateTime = datetime.now()
        print("Finished adding items to queue at", finishedDateTime.strftime("%Y-%m-%d %H:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception as e: 
        print(Fore.RED + "Failed to add items to queue.")
        print(e)
        print(traceback.print_stack)
        exit("" + Style.RESET_ALL)


addItemsToQueue()