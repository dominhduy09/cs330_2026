#include <stdio.h>
#include "asgn4.h"

int main() {
    
    // test isBitSet
    printf("Testing isBitSet function:\n");
    printf("isBitSet(23, 4) = %d\n", isBitSet(23, 4)); // 1

    // test setBit
    printf("\nTesting setBit function:\n");
    printf("setBit(5, 3) = %d\n", setBit(5, 3)); // 13

    // test clearBit
    printf("\nTesting clearBit function:\n");
    printf("clearBit(15, 1) = %d\n", clearBit(15, 1)); // 13

    // test toggleBit
    printf("\nTesting toggleBit function:\n");
    printf("toggleBit(8, 3) = %d\n", toggleBit(8, 3)); // 0

    // test multiplyBy2 and divideBy2
    printf("\nTesting multiplyBy2 and divideBy2 functions:\n");
    printf("multiplyBy2(7) = %d\n", multiplyBy2(7)); // 14
    printf("divideBy2(18) = %d\n", divideBy2(18)); // 9

    // test countSetBits
    printf("\nTesting countSetBits function:\n");
    printf("countSetBits(23) = %d\n", countSetBits(23)); // 4

    // test for error handling
    printf("\nTesting invalid positions:\n");
    printf("isBitSet(23, -1) = %d\n", isBitSet(23, -1)); // 0
    printf("setBit(5, 100) = %d\n", setBit(5, 100)); // 5
    printf("toggleBit(8, -3) = %d\n", toggleBit(8, -3)); // 8

    return 0;
    
}