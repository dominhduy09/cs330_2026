#include <stdio.h>

void myFunction(int *n) {
    *n += 5;    // *n = *n + 5 == (5) + 5 == 10
    return;
}

int main() {
    int x = 5;
    int *ptrToX = &x;   // ptrToX is a pointer to x, so it holds the address of x
    myFunction(ptrToX); //
    printf("x is now %d\n", x);
    return 0;
}

/*
    What is x?
    a. 5
    b. 10
    c. error
    d. 15
*/