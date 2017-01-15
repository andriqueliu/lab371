// Part2.c
// 
// EE 371 Lab 2 Project
// This program is aimed towards developing skills with pointers.
// Techniques such as pointing to addresses and dereferencing pointers
// are included.
// 
// Authors: Andrique Liu, Nikhil Grover, Emraj Sidhu

#include <stdio.h> // Standard I/O

int main()
{
	// Declare and initialize integer variables
	int A, B, C, D, E;
	A = 22;
	B = 17;
	C = 6;
	D = 4;
	E = 9;
	int result;

	// Declare pointer variables
	int * APtr;
	int * BPtr;
	int * CPtr;
	int * DPtr;
	int * EPtr;
	APtr = &A;
	BPtr = &B;
	CPtr = &C;
	DPtr = &D;
	EPtr = &E;

	// Perform computation ((A - B) * (C + D)) / E
	// Refer to variables through their pointers
	result = ((*APtr - *BPtr) * (*CPtr + *DPtr)) / (*EPtr);

	// Print result
	printf("Result: %i\n", result);
}
