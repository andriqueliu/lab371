/*
EE 371 Lab 4 Project
Building and Working with a Simple Microprocessor

Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

This program allows the user to turn on LEDRs corresponding to enabled switches.
This behavior is reversed if LEDR[0] is enabled.
*/

#include <stdio.h> // Standard I/O

/* Declare volatile pointers to I/O registers (volatile means that the locations will not be cached,
* even in registers) */
volatile int * LED_ptr = (int *) 0xFF200000; // red LED address
volatile int * HEX3_HEX0_ptr = (int *) 0xFF200020; // HEX3_HEX0 address
volatile int * SW_switch_ptr = (int *) 0xFF200040; // SW slider switch address
volatile int * KEY_ptr = (int *) 0xFF200050; // pushbutton KEY address

// Forward declarations
void clearLEDRs(void);
int askUser(void);
void turnOnLEDRs(void);
int power(int number, int power);

int main()
{
	clearLEDRs();
	while (1) {
		if (*(SW_switch_ptr) & 0x01) {
			turnOnLEDRs();
		} else {
			complementLEDRs();
		}
	}
	
	return 0;
}

// Clear all of the LEDRs (LEDR[9:0])
void clearLEDRs(void)
{
	*(LED_ptr) &= ~(0x03FF);
}

// Ask for user input; G to execute program, else to quit
int askUser(void)
{
	char input;
	
	printf("Waiting for user... ");
	scanf("%c", &input);
	getchar();
	return (input == 'G');
}

// Turns on the active LEDRs, and also turns off inactive LEDRs.
void turnOnLEDRs(void)
{
	*(LED_ptr) |= *(SW_switch_ptr);
	*(LED_ptr) &= *(SW_switch_ptr);
}

// Return number to the power of...
// Takes 2 int inputs: base and the power to which it will be raised
// Returns int value, the result of the calculation
int power(int number, int power)
{
	int i, value;
	
	value = power;
	if (power == 0) {
		return 1;
	} else if (power >= 1) {
		for (i = 1; i < power; i++) {
			value = value * number;
		}
	}
	
	return value;
}
