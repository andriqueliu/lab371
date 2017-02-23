volatile int *switches = (int *) 0x00011030;
volatile int *gpio_out = (int *) 0x00011000;
volatile int *gpio_in = (int *) 0x00011020;

int main()
{
	while (1) {
		// *(gpio_out) = 0x01;
		// *(gpio_out) = (~(0x03) | (*(switches)&0x01<<1) | (*(switches)&0x02>>1));
		
		if ((*(switches)&0x02) && (*(switches)&0x01)) {
			*(gpio_out) = 0x03;
		} else if (*(switches)&0x02) {
			*(gpio_out) = 0x01;
		} else if (*(switches)&0x01) {
			*(gpio_out) = 0x02;
		} else {
			*(gpio_out) = 0x00;
		}
	}
}
