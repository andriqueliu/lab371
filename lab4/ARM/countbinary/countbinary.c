/*
EE 371 Lab 4 Project
Building and Working with a Simple Microprocessor

Authors: Nikhil Grover, Andrique Liu

This program uses the DE1-SoC's LEDRs to print an 8-bit binary value,
and increments through values. This value cycles through the sequence.
*/

#include <stdio.h> // Standard I/O

/* Declare volatile pointers to I/O registers (volatile means that the locations will not be cached,
* even in registers) */
volatile int * LED_ptr = (int *) 0xFF200000; // red LED address
volatile int * HEX3_HEX0_ptr = (int *) 0xFF200020; // HEX3_HEX0 address
volatile int * SW_switch_ptr = (int *) 0xFF200040; // SW slider switch address
volatile int * KEY_ptr = (int *) 0xFF200050; // pushbutton KEY address

volatile int delay_count; // volatile so C compiler does not remove loop

int main()
{
	char value = 0x00;
	
	printf("Count binary sequence...\n");
	while (1) {
		if (value == 0xFF) {
			value = 0x00;
		} else {
			value++;
		}
		*(LED_ptr) = value;
		for (delay_count = 500000; delay_count != 0; --delay_count) {
			
		}
	}
	
	return 0;
}
