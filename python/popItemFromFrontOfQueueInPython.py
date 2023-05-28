#!/bin/python

# pop item from front of queue in Python

import colorama, os, sys, traceback
from collections import deque
from colorama import Fore, Style
from datetime import datetime
colorama.init()


def checkOs(): 
    print("Started checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    if sys.platform == "win32": 
        print(Fore.GREEN + "Operating System:", end=""); sys.stdout.flush()
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
    
    print("Finished checking operating system at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
    print("")
    return operatingSystem


def addItemsToQueue(operatingSystem): 
    queue = deque()

    if operatingSystem == "Windows": 
        answer = int(input("Please type how many items you would like to add to the queue and press the \"Enter\" key (Example: 4): "))
        print("")

        def getAppendOnWin(answer): 
            if answer > 0:
                queueItem = str(input("Please type the item you wish to add into the queue and press the \"Enter\" key (Example: 1): "))

                queue.append(queueItem)
                getAppendOnWin(answer-1)

        getAppendOnWin(answer)
            
    elif operatingSystem == "macOS" or operatingSystem == "Linux": 
        answer = int(input("Please type how many items you would like to add to the queue and press the \"return\" key (Example: 4): "))
        print("")

        def getAppendOnMacOrLinux(answer): 
            if answer > 0: 
                queueItem = str(input("Please type the item you wish to add into the queue and press the \"return\" key (Example: 1): "))
                
                queue.append(queueItem)
                getAppendOnMacOrLinux(answer-1)

        getAppendOnMacOrLinux(answer)
        
    print(Fore.BLUE + "Here is your queue: {0}".format(queue) + Style.RESET_ALL)
    print("")
    return queue


def popItemFromFrontOfQueue(): 
    print("\nPop item from front of queue in Python.\n")
    operatingSystem = checkOs()

    queue = addItemsToQueue(operatingSystem)

    try: 
        startDateTime = datetime.now()
        print("Started popping item from front of queue at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        frontQueueItem = queue.popleft()
        print("Popping this item from the front of the queue: {0}".format(frontQueueItem))
        print(Fore.BLUE + "Your queue is now: {0}".format(queue))
        print(Fore.GREEN + "Successfully popped item from front of queue." + Style.RESET_ALL)

        finishedDateTime = datetime.now()
        print("Finished popping item from front of queue at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p"))

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")

    except Exception: 
        print(Fore.RED + "Failed to add items to queue.")
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


popItemFromFrontOfQueue()
