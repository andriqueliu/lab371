/*
EE 371 Lab 4 Project
Building and Working with a Simple Microprocessor
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

The ARM processor is used to supplement the behavior of the FPGA in this lab's
project. 

Inputs:
The processor takes the "ReadyToTransfer" signal from an active scanner

Outputs:
The processor outputs the "StartScanning" and the "Transfer" signal to the scanner system.
These signals initiate the scanning and transferring processes, respectively.
*/

#include <stdio.h> // Standard I/O

#define TRUE 1
#define FALSE 0

/* Declare volatile pointers to I/O registers (volatile means that the locations will not be cached,
* even in registers) */
volatile int * LED_ptr = (int *) 0xFF200000; // red LED address
volatile int * HEX3_HEX0_ptr = (int *) 0xFF200020; // HEX3_HEX0 address
volatile int * SW_switch_ptr = (int *) 0xFF200040; // SW slider switch address
volatile int * KEY_ptr = (int *) 0xFF200050; // pushbutton KEY address

// Forward Declarations
void printWelcome(void);
int confirmScan(void);

int main()
{
	char userInput = '\0';
	
	printWelcome();
	
	while (!confirmScan()) {
		
	}
	
	
	return 0;
}

// Prints a welcome message for the user
void printWelcome(void)
{
	printf("This program aims to supplement the DE1-SoC's FPGA operations.\n");
	printf("This program issues the StartScanning and Transfer commands,\n");
	printf("And also takes the ReadyToTransfer command.\n");
}

// Prompts the user to start the scanning process
// Returns boolean
int confirmScan(void)
{
	char input = '\0';
	
	printf("Enter S to begin scanning.\n");
	scanf("%c", &input);
	if (input == 'S') {
	getchar();
		// Send out the StartScan
		printf("Scanning!\n");
		return TRUE;
	} else {
		return FALSE;
	}
}
