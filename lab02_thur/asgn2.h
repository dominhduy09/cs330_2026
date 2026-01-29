#ifndef __asgn2__
#define __asgn2__
#include <math.h>

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

float calculateDiscount(float price, float discount) {

    float discountedPrice;
    discountedPrice = price * (100 - discount) / 100;
    return discountedPrice;

} // end calculateDiscount

/*

function greaterThanIndex(arrayOfNumbers, size)
takes: an array of integers(arrayOfNumbers) and the size of the array(size, also an integer)
return: int

The function check every number's value and their indices
Count the number of integers in the list whose value is greater than index and return total

*/

int greaterThanIndex(int arrayOfNumbers[], int size) {

    int count = 0;

    for (int i = 0; i < size; i++) {
        if (arrayOfNumbers[i] > i) {
            count++;
        }
    }

    return count;

} // end greaterThanIndex

/*

function sumOfDigits(n)
takes: an integer n
return: int, the sum of the digits of its digits (also an integer)
assume n is positive integer

*/

int sumOfDigits(int n) {

    int sum = 0;
    while (n > 0) {
        sum += n % 10;
        n = n / 10;
    }
    return sum;

} // end sumOfDigits

/*

function grader(avg_exams, avg_hw, attendance)
takes: 2 floats avg_exams and avg_hw and 1 integer attendance 
return: nothing, prints pass or fail based on the criteria
the function uses student grades and attendance to decide student pass or fail
 - attendance must be greater than 22
 - avg_exams and avg_hw must both be greater than 75
 - at least 1 of avg_exams or avg_hw must be greater than 80

*/

void grader(float avg_exams, float avg_hw, int attendance) {

    if (attendance > 22 && avg_exams > 75 && avg_hw > 75 && (avg_exams > 80 || avg_hw > 80)) {
        printf("Pass\n");
    }

    else {
        printf("Fail\n");
    }

}

/*

function monthlyPayment(principal, rate, years)
takes: 3 positive floats values
 - principal: the principal amount of a loan
 - rate: annual interest rate
 - years: number of years for the loan
return: float, the monthly payment amount using the formula for a fixed-rate mortgage

*/

float monthlyPayment(float principal, float rate, float years) {

    float P = principal;
    float r = rate / 100 / 12;
    float n = years * 12;
    float M;

    M = (P * r * (pow(1 + r, n))) / (pow(1 + r, n) - 1);

    return M;

}

#endif