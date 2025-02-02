#include "sys/alt_stdio.h"
#include "sys/unistd.h"
#define switches (volatile char *) 0x00050c0
#define leds (volatile char *) 0x00050b0
#define keys (volatile char *) 0x00050a0
#define hex0 (volatile char *) 0x0005090
#define hex1 (volatile char *) 0x0005080
#define hex2 (volatile char *) 0x0005070
#define hex3 (volatile char *) 0x0005060
#define hex4 (volatile char *) 0x0005050
#define hex5 (volatile char *) 0x0005040
#define readyToTransfer (volatile char *) 0x0005010
#define xfer (volatile char *) 0x0005020
#define startScanning (volatile char *) 0x0005030
#define data_in (volatile char *) 0x0005000

int main()
{ 
  alt_putstr("SCANNER CTRL BASE I/O\n");
  char input = 'a';

  /* Event loop never exits. */
  while (1) {
	  *startScanning = 0;
	  *xfer = 0;

	  if((*readyToTransfer &= 0x1) == 0x1) {
		  alt_putstr("\n ready to transfer!\n");
	  }

  	  input = alt_getchar();
  	  if(input == 's') {
  		  *startScanning = 1;
  		  alt_putstr("\n start scanning...\n");
  	  	  usleep(1000000);
  	  }
  	  if(input == 't') {
  		  *xfer = 1;
  		  alt_putstr("\n transferring...\n");
  	  	  usleep(1000000);
  	  }
  }
  return 0;
}
