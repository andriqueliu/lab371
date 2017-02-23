volatile int *switches = (int *) 0x00021030;
volatile int *gpio_out = (int *) 0x00021000;
volatile int *gpio_in = (int *) 0x00021020;

int main()
{
	while (1) {
		*(gpio_out) = (*(switches) & ~(0x03));
	}
}
