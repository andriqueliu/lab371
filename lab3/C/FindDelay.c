/*
EE 371 Lab 3 Project
FindDelay.c
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

FindDelay prompts the user for the total number of logic devices in a signal path
and displays the total delay along that path.
This program also prints out a graphical representation of the signal's path.

For reference:
Delay of signal propagating along a trace is 180 ps (10^-12 s) per inch.
Delay of a signal through a logic device is 5 ns (10^-9 s).

Assume:
Logic devices are placed with a trace of 0.1 in. connecting the output of
one device to the input of the next device.
*/

#include <stdio.h>
#include <math.h>

#define LOGICDEVICEDELAY (5 * pow(10, -9)) // Delay per logic device
#define PATHDELAY (180 * pow(10, -13))     // Delay per 0.1 inch

void printWelcome(void);
int promptNumberDevices(void);
double calculateDelay(int logicDevices);
void printDelay(int logicDevices, double totalDelay);

int main()
{
	int logicDevices;
	double totalDelay;

	logicDevices = promptNumberDevices();
	totalDelay = calculateDelay(logicDevices);
	printDelay(logicDevices, totalDelay);

	return 0;
}

// printWelcome prints out a short welcome message for the user, and also gives 
// instructions on how to quit the program.
void printWelcome(void)
{
	printf("Welcome to FindDelay.c\n");
	printf("Press Ctrl + C at any time to quit program.\n");
}

// promptNumberDevices prompts the user for the total number of logic devices in
// the signal's path.
// This function returns that number.
int promptNumberDevices(void)
{
	int number;

	printf("How many logic devices are there in the signal path? ");
	scanf("%i", &number);
	getchar();

	return number;
}

// calculateDelay calculates the delay necessary for a signal to propagate.
// calculateDelay takes an input int logicDevices, indicating how many logic
// devices are in the path.
// calculateDelay returns a double expressing the total delay.
double calculateDelay(int logicDevices)
{
	double logicDelay, pathDelay, totalDelay;

	logicDelay = logicDevices * LOGICDEVICEDELAY;
	pathDelay = (logicDevices - 1) * PATHDELAY;
	totalDelay = logicDelay + pathDelay;

	return totalDelay;
}

// printDelay prints out the total delay for the signal to propagate.
// printDelay takes two inputs: the number of logic devices and the total delay.
// printDelay prints out the total delay in units of nanoseconds.
void printDelay(int logicDevices, double totalDelay)
{
	int i;

	totalDelay *= pow(10, 9); // Units of ns
	printf("Total signal propagation delay for %i device(s): %.5lf ns\n",
		   logicDevices, totalDelay);

	// Print out graphical representation.
	if (logicDevices > 0) {
		printf(">");
		for (i = 0; i < (logicDevices - 1); i++) {
			printf("--->");
		}
	}
	printf("\n");
}
