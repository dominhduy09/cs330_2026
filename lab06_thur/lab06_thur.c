#include <stdio.h>
#include <stdlib.h>

float *myFoo() {
    // float mySecondArray[] = {1.1, 2.2, 3.3};
    int size = 3;
    float *mySecondArray = malloc(size * sizeof(float)); // allocate memory for 3
    *(mySecondArray + 1) = 42.0;

    return mySecondArray;
}

void printMe(float *myArr, int size) {
    // how to keep track of the array size
    // 1. declare a seperate variable for size
    // 2. setinel. mark end of array. e.g. string '\0'
    // 3. number, make the first element the size

    printf("[ ");

    for (int i = 0; i < size; i++) {
        printf("%0.2f ", *(myArr + i)); 
    }
    
    printf("]\n");

    return;   

}


int main() {

    int size = 5;
    float arr[5] = {1.1, 2.2, 3.3, 4.4, 5.5};

    float *myArrptr = myFoo();

    printMe(myArrptr, 3);
    printMe(arr, size);
    

    // return 0;
} // end of main