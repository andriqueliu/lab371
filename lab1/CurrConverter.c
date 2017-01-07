// Currency Conversion Module
// EE 371, Lab 1
//
// Note: Currency values are current as of Jan. 6 2017 on 
// the currency authority www.xe.com

#include <stdio.h>  // Standard I/O
#include <string.h> // For string operations (copy, compare, etc.)

// Forward declarations
void printOptions(void);
void USDtoF(void);
void FtoUSD(void);
double findCurrency(char uinput, char currency[]);

char uinput; // Expresses user input

int main()
{
   printf("Convert from USD to foreign (1) or foreign to USD (2)?\n");
   printf("Press 'Q' to quit\n");
   scanf("%c", &uinput);
   getchar();
   if (uinput == '1') {
      USDtoF();
   } else if (uinput == '2') {
      FtoUSD();
   } else if (uinput == 'Q') {
      return 0;
   } else {
      printf("Invalid input\n");
      return -1; // Invalid
   }
   return 0;
}

// printOptions prints out available currency options
// This function also allows for custom currency input
void printOptions(void)
{
   printf("Euro (E)\n");
   printf("British Pound (G)\n");
   printf("Pakistani Rupee (P)\n");
   printf("Canadian Dollar (C)\n");
   printf("Australian Dollar (A)\n");
   printf("Custom currency ($)\n");
}

// USDtoF converts USD currency to a foreign currency rate
// Outputs to console
void USDtoF(void)
{
   char currency[3];
   double foreignVal;
   
   while (uinput != 'Q') {
      printf("Enter foreign currency\n");
      printf("0 for options, Q to quit program\n");
      scanf("%c", &uinput);
      getchar();
      
      if (uinput == '0') {
         printOptions();
      } else if (uinput == 'Q') {
         printf("Quitting program...\n");
      } else {
         foreignVal = findCurrency(uinput, currency);
      }
      // If there is a valid currency input
      if (strcmp(currency,"") > 0) {
         printf("%lf %s per 1.00 USD\n", foreignVal, currency);
      }
      strcpy(currency,"");
   }
}

// FtoUSD converts a foreign currency rate to USD currency
// Outputs to console
void FtoUSD(void)
{
   char currency[3];
   double foreignVal;
   double finalVal;
   
   while (uinput != 'Q') {
      printf("Enter foreign currency\n");
      printf("0 for options, Q to quit program\n");
      scanf("%c", &uinput);
      getchar();
      
      if (uinput == '0') {
         printOptions();
      } else if (uinput == 'Q') {
         printf("Quitting program...\n");
      } else {
         foreignVal = findCurrency(uinput, currency);
      }
      // If there is a valid currency input
      if (strcmp(currency,"") > 0) {
         finalVal = 1.00 / foreignVal;
         printf("%lf %s per dollar USD\n", finalVal, currency);
      }
      strcpy(currency,"");
   }
}

// findCurrency finds the appropriate currency and returns the
// desired currency value
// findCurrency takes in user input and an array of chars, currency 
// this array is modified to reflect the appropriate currency
double findCurrency(char uinput, char currency[])
{
   double foreignVal;

   switch (uinput) {
      case 'E':
         strcpy(currency, "EUR");
         foreignVal = 0.949420;
         break;
      case 'G':
         strcpy(currency, "GPB");
         foreignVal = 0.813981;
         break;
      case 'P':
         strcpy(currency, "PKR");
         foreignVal = 104.800;
         break;
      case 'C':
         strcpy(currency, "CAD");
         foreignVal = 1.32403;
         break;
      case 'A':
         strcpy(currency, "AUD");
         foreignVal = 1.37030;
         break;
      case '$':
         strcpy(currency, "CTM");
         printf("Enter custom currency value: ");
         scanf("%lf", &foreignVal);
         // scanf needs to read in a double pointer type
         getchar();
         break;
      default:
         printf("Invalid input\n");
         break;
   }
   return foreignVal;
}

