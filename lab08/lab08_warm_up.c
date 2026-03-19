#include <stdio.h>

int main() {
    int a = 5;
    int *ptr1 = &a; // pointer to a
    int **ptr2 = &ptr1; // pointer to pointer to a
    printf("%x\n", ptr2); // address of ptr1

    /* What will this print?
    a. 5
    b. The address of ptr1
    c. The address of a
    d. The value of ptr1
    
    */
    return 0;
}