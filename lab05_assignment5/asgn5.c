#include <stdio.h>

/*
1) Declares an integer array (you may hardcode a few values).
2) Uses pointers (e.g., *(myarr + i)) to visit each element of the array.
3) Replaces every element in the array with its square (for example, if an element is 4, it
becomes 16).
4) Prints the array after modification.

Convert your code into Assembly language with `gcc -S filename.c`.

run file is asgn5.

*/

int main() {
    int arr[5] = {1, 2, 3, 4, 5};   // Step 1: Declare an integer array with hardcoded values
    int *ptr = arr;   // Step 2: Use a pointer to visit each element of the array

    // Step 3: Replace every element in the array with its square
    for (int i = 0; i < 5; i++) {
        *(ptr + i) = (*(ptr + i)) * (*(ptr + i));   // Square the value at the current pointer position and store it back
    }

    // Step 4: Print the array after modification
    for (int i = 0; i < 5; i++) {
        printf("%d \n", *(ptr + i));  // Print the squared values using the pointer
    }

    return 0;
}