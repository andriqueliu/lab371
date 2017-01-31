/*
EE 371 Lab 3 Project
Temperature.c
Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

This program prompts the user for a temperature value, scale, and then converts the value
to a desired temperature scale.

Reference Formulas:
C = (F - 32 / 1.8)
K = C + 273
*/



#include <stdio.h>


void printWelcome(void);
double askForValue(void);
char askForScale(void);
char askForFromScale(void);
char askForToScale(void);   // 
// 
double convertTemprature(double value, char fromScale, char toScale);


int main()
{
	double value;
	char fromScale;
	char toScale;

	value = askForValue();
	fromScale = askForScale();

	return 0;
}

// 
void printWelcome(void)
{
	printf("Welcome to the Temperature Program.\n");
	printf("Press Ctrl + C at any time to quit program.\n");
}

//
double askForValue(void)
{
	double value;

	printf("Enter in temperature value: ");
	scanf("%lf", &value);
	getchar();

	return value;
}

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

// 
char askForFromScale(void)
{	
	printf("Enter in desired FROM scale (C, F, K): ");
	return askForScale();
}

// 
char askForToScale(void)
{
	printf("Enter in desired TO scale (C, F, K): ");
	return askForScale();
}

// 
double convertTemperature(double value, char fromScale, char toScale)
{

}
