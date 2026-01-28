#include <stdio.h>
#include "asgn2.h"

int main() {

    // test hello world
    printf("hello, world\n");

    // test printCollatz
    for(int i = 2; i <= 10; i++) {
        printf("This is the Collatz sequence for %d: ", i);
        printCollatz(i);
    }

    // test calculateDiscount
    float price = 100.0;
    float discount = 15.0;
    float discountedPrice = calculateDiscount(price, discount);
    printf("After applying for the original price: $%.1f with the discount of: %.1f\n", price, discount);
    printf("The discounted price is: $%.1f\n", discountedPrice);

    // test greaterThanIndex
    int arrayOfNumbers[5] = {1, 3, 5, 7, 9};
    printf("%d\n", greaterThanIndex(arrayOfNumbers, 5));

    // test sumOfDigits
    int number = 123456;
    printf("The sum of digits of %d: %d\n", number, sumOfDigits(number));


    
    return 0;
    
}
