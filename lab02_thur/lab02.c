#include <stdio.h>
#include "asgn2.h"

int main() {

    printf("hello, world\n");

    for(int i = 2; i <= 10; i++) {
        printf("This is the Collatz sequence for %d: ", i);
        printCollatz(i);
    }

    calculateDiscount(50.0, 15.0);

    return 0;
    
}
