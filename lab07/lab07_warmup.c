#include <stdio.h>

int* myFunct() {
    int myArr[] = {4, 5, 6};

    return &myArr; 

}

int main() {
    int myArr1[] = {1, 2, 3};
    int* myArrPtr = myArr1; // myArrPtr is a pointer to the first element of myArr1, so it holds the address of myArr1[0]
    myArrPtr = myFunct(); // myArrPtr now holds the address of the first element of the array returned by myFunct, which is myArr
    for(int i = 0; i < 3; i++) {
        printf("%d ", *(myArrPtr + i)); // myArrPtr[i] is equivalent to *(myArrPtr + i), so it will print the elements of the array returned by myFunct
    }
    /* What is printed out?
        a. 1 2 3
        b. 4 5 6
        c. error
        d. something else
    */

    return 0;
}