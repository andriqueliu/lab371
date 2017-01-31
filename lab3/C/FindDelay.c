/*
EE 371 Lab 3 Project
FindDelay.c
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

FindDelay prompts the user for the total number of logic devices in a signal path
and displays the total delay along that path.

For reference:
Delay of signal propagating along a trace is 180 ps (10^-12 s) per inch.
Delay of a signal through a logic device is 5 ns (10^-9 s).

Assume: logic devices are placed with a trace of 0.1 in. connecting the output of
one device to the input of the next device.
*/

#include <stdio.h>

#define 

void printWelcome(void);
int promptNumberDevices(void);

int main()
{
	int logicDevices;

	logicDevices = promptNumberDevices();

	return 0;
}

// 
void printWelcome(void)
{
	printf("Welcome to FindDelay.c\n");
	printf("Press Ctrl + C at any time to quit program.\n");
}

// 
int promptNumberDevices(void)
{
	int number;

	printf("How many logic devices are there in the signal path? ");
	scanf("%i", &number);
	getchar();

	return number;
}
