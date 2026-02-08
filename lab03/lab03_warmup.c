#include <stdio.h>

int main() {
    
    int x;      // auto int x; x= garbage value
    int y, z;   // y = ? z = ?
    y = z = 2;  // y = 2, z = 2
    int answer = x + y + z; // answer = garbage + 2 + 2 = garbage value
    printf("The answer is: %d\n", answer);

    return 0;
}

/*
What is the answer?
a. 4
b. 5
c. 6
d. Something else

*/