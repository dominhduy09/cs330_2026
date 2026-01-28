#ifndef __asgn2__
#define __asgn2__

/* 

the two lines above check to ensure
we haven't already included this header 

*/


/* your functions go here */

// Note: main() goes in the asgn2.c file

/*

Collatz Conjecture

n ==> even: n/2
      odd: 3(n) + 1

    10/2    3(5) + 1    16/2    8/2    4/2    2/2    1
    5       16          8       4      2      1

*/

/*
descr: this function prints the Collatz sequence for n
takes: int n, to calc the Collatz
return: nothing, just prints Collatz as side effect
*/

void printCollatz(int n) {
    // loop
    while (n != 1)
    {
        if (n % 2 == 0) {
            n = n / 2;
        }

        else {
            n = 3 * n + 1;
        }

        printf("%d ", n);
    }
    printf("\n");
} // end printCollatz

/*

function calculateDiscount(price, discount)
takes: 2 positive floats
value: the original price and the discount percentage
return: float, the price after applying discount

*/
void calculateDiscount(float price, float discount) {

    float discountedPrice;
    discountedPrice = price * (100 - discount) / 100;
    printf("After applying for the original price: $%.1f with the discount of: %.1f\n", price, discount);
    printf("The discounted price is: $%.1f\n", discountedPrice);

}

/*

function greaterThanIndex(arrayOfNumbers, size)
takes: an array of integers(arrayOfNumbers) and the size of the array(size, also an integer)
return: int

The function check every number's value and their indices
Count the number of integers in the list whose value is greater than index and return total

*/
void greaterThanIndex(int arrayOfNumbers[], int size) {
    
}


#endif