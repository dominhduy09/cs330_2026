#include <stdio.h>

int main() {

    int firstNum, secondNum;                    // ?
    firstNum = secondNum = 10;                  // firstNum = 10, secondNum = 10
    secondNum /= 2;                             // secondNum = secondNum / 2 == 5 remainder 0
    int answer = ++firstNum + secondNum--;      // answer = ++(10) + 5-- == 11 + 5 == 16, firstNum = 11, secondNum = 4
    printf("Answer is: %d\n", answer);          // 16

    return 0;
}