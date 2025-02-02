/*
EE 371 Lab 3 Project
Temperature.c
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

This program prompts the user for a temperature value, scale, and then converts the value
to the desired temperature scale.

Reference Formulas:
C = (F - 32 / 1.8)
K = C + 273
*/

// Include standard library functions
#include <stdio.h>

// Forward declarations
void printWelcome(void);
double askForValue(void);
char askForScale(void);
char askForFromScale(void);
char askForToScale(void);
double convertTemperature(double value, char fromScale, char toScale);
void printConversion(double value, double finalValue, char fromScale, char toScale);

int main()
{
	double value, finalValue;
	char fromScale;
	char toScale;

	value = askForValue();
	fromScale = askForFromScale();
	toScale = askForToScale();
	finalValue = convertTemperature(value, fromScale, toScale);
	printConversion(value, finalValue, fromScale, toScale);

	return 0;
}

// printWelcomes prints out a short welcome message for the user, and also
// gives instructions on how to quit the program.
void printWelcome(void)
{
	printf("Welcome to the Temperature Program.\n");
	printf("Press Ctrl + C at any time to quit program.\n");
}

// askForValue prompts the user for the initial temperature value.
double askForValue(void)
{
	double value;

	printf("Enter in temperature value: ");
	scanf("%lf", &value);
	getchar();

	return value;
}

// askForScale is used to prompt the user for his or her desired scale.
char askForScale(void)
{
	char scale, valid;

	valid = 0;
	while (!valid) {
		scanf("%c", &scale);
		getchar();
		if (scale == 'C' || scale == 'c') {
			return 'C';
		} else if (scale == 'F' || scale == 'f') {
			return 'F';
		} else if (scale == 'K' || scale == 'k') {
			return 'K';
		} else {
			printf("Invalid input.\n");
		}
	}
}

// askForFromScale prompts the user for the desired FROM scale.
char askForFromScale(void)
{	
	printf("Enter in desired FROM scale (C, F, K): ");
	return askForScale();
}

// askForFromScale prompts the user for the desired TO scale.
char askForToScale(void)
{
	printf("Enter in desired TO scale (C, F, K): ");
	return askForScale();
}

// Converts temperature from one scale to another
double convertTemperature(double value, char fromScale, char toScale)
{
	double result;
	if(fromScale == 'C' && toScale == 'F') {
		result = ((value * 9) / 5) + 32;
	}
	if(fromScale == 'C' && toScale == 'K') {
		result = value + 273.15;
	}
	if(fromScale == 'F' && toScale == 'C') {
		result = ((value - 32) * 5) / 9;
	}
	if(fromScale == 'F' && toScale == 'K') {
		result = (((value - 32) * 5) / 9) + 273;
	}
	if(fromScale == 'K' && toScale == 'C') {
		result = value - 273.15;
	}
	if(fromScale == 'K' && toScale == 'F') {
		result = (((value - 273) * 9) / 5) + 32;
	}
}

// Prints the final conversion, including the initial value and scale,
// followed by the final value and scale.
void printConversion(double value, double finalValue, char fromScale, char toScale)
{
	printf("Temperature in %.3lf degrees %c is %.3lf degrees %c\n",
		   value, fromScale, finalValue, toScale);
}
