#include <stdio.h>
#define switches (volatile char *) 0x0005010
#define leds (volatile char *) 0x0005000
int main() {
	while (1)
		*leds = *switches;
	return 0;
}
