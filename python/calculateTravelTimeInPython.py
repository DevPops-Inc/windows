#!/bin/python

# calculate travel time

# you can run this script with: python3 calculateTravelTimeInPython.py < rate > < distance >

import colorama, os, sys, traceback
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

    elif sys.platform == "darwin": 
        print(Fore.GREEN + "Operating System: ")
        os.system('sw_vers')
        print(Style.RESET_ALL, end="")
        operatingSystem = "macOS"

    elif sys.platform == "linux": 
        print(Fore.GREEN + "Operating System: ")
        os.system('uname -r')
        print(Style.RESET_ALL, end="")
        operatingSystem = "Linux"

    print("Finished checking operating system at ", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

    print("")
    return operatingSystem


def getRate(operatingSystem):
    if operatingSystem == "Windows": 
        rate = float(input("Please type the rate (miles per hour) and press \"Enter\" key (Example: 45): "))

    elif operatingSystem == "macOS" or operatingSystem == "Linux": 
        rate = float(input("Please type the rate (miles per hour) and press \"return\" key (Example: 45): "))

    print("")
    return rate 


def getDistance(operatingSystem):
    if operatingSystem == "Windows": 
        distance = float(input("Please type the distance (miles) and press \"Enter\" key (Example: 100): "))

    elif operatingSystem == "macOS" or operatingSystem == "Linux": 
        distance = float(input("Please type the distance (miles) and press \"return\" key (Example: 100): "))

    print("")
    return distance


def checkParameters(rate, distance): 
    print("Started checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))
    valid = True

    print("Parameter(s):")
    print("------------------------------")
    print("rate    : {0}".format(rate))
    print("distance: {0}".format(distance))
    print("------------------------------")

    if rate == None or rate == "": 
        print(Fore.RED + "rate is not set." + Style.RESET_ALL)
        valid = False

    if distance == None or distance == "": 
        print(Fore.RED + "distance is not set." + Style.RESET_ALL)
        valid = False

    if valid == True: 
        print(Fore.GREEN + "All parameter check(s) passed." + Style.RESET_ALL)

        print("Finished checking parameter(s) at", datetime.now().strftime("%m-%d-%Y %I:%M %p"))

        print("")

    else: 
        raise Exception("One or more parameter checks are incorrect.")


def calculateTravelTime(): 
    print("\nCalculate travel time in Python!\n")
    operatingSystem = checkOs()

    if len(sys.argv) > 2: 
        rate     = float(sys.argv[1])
        distance = float(sys.argv[2])

    else: 
        rate = getRate(operatingSystem)
        distance = getDistance(operatingSystem)

    checkParameters(rate, distance)

    try: 
        startDateTime = datetime.now()
        print("Started calculating travel time at", startDateTime.strftime("%m-%d-%Y %I:%M %p"))

        travelTime = distance / rate
        roundedTravelTime = round(travelTime, 2)
        print(Fore.BLUE + "Travel time: {0} hours ".format(roundedTravelTime))
        print(Fore.GREEN + "Successfully calcuated travel time." + Style.RESET_ALL)

        finishedDateTime = datetime.now()

        print("Finished calculating travel time at", finishedDateTime.strftime("%m-%d-%Y %I:%M %p")) 

        duration = finishedDateTime - startDateTime
        print("Total execution time: {0} second(s)".format(duration.seconds))
        print("")
        
    except Exception as e:
        print(Fore.RED + "Failed to calculate travel time" + Style.RESET_ALL)
        traceback.print_exc()
        exit("" + Style.RESET_ALL)


calculateTravelTime()
