/*




*/

#include <stdio.h> // Standard I/O

/* Declare volatile pointers to I/O registers (volatile means that the locations will not be cached,
* even in registers) */
volatile int * LED_ptr = (int *) 0xFF200000; // red LED address
volatile int * HEX3_HEX0_ptr = (int *) 0xFF200020; // HEX3_HEX0 address
volatile int * SW_switch_ptr = (int *) 0xFF200040; // SW slider switch address
volatile int * KEY_ptr = (int *) 0xFF200050; // pushbutton KEY address

int main()
{
	
	
	
	return 0;
}
