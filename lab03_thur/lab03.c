#include <stdio.h>
#include "asgn2.h"

int main() {

    //test Hello World
    printf("hello, world\n");

    // test addOne
    int answer = addOne(1);
    printf("The answer is: %d\n", answer);
    printf("The second answer is: %d\n", addOne(2));
    printf("The addTwo answer is: %d\n", addTwo(2));


    return 0;
}