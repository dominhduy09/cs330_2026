#include <stdio.h>

int main() {

    float myFloat = 3.141592;
    float *myFloatPtr = &myFloat;
    printf("myFloat is %.2f, at address %p, pointer is %p\n", myFloat, &myFloat, myFloatPtr);

    float mySecondFloat = *myFloatPtr;
    printf("mySecondFloat is %.6f\n", mySecondFloat);

    *myFloatPtr = 42.0;
    printf("myFloat is %.2f, mySecondFloat is %.2f\n", myFloat, mySecondFloat);

    char myChar = 'J';
    char *myCharPtr = &myChar;
    printf("size of char is %ld, size of myCharPtr is %ld\n", sizeof(char), sizeof(myCharPtr));

    return 0;
}