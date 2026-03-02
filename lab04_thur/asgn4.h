#ifndef __asgn4__
#define __asgn4__

/* the two lines above check to ensure
we haven't already included this header*/


/* your functions go here */
// Note: main() goes in the asgn4.c file

/*

    Function: isBitSet
   
    takes: an integer number and a bit position
    return: 1 if the bit at that position is set, 0 otherwise

*/
 
int isBitSet(int number, int position) {
    if (position < 0 || position >= sizeof(int) * 8) {
        return 0; // Invalid position
    }

    return (number >> position) & 1;
} // end isBitSet

/*

    Function: setBit
   
    takes: an integer number and a bit position
    return: new number with the bit at that position set to 1

*/

int setBit(int number, int position) {
    if (position < 0 || position >= sizeof(int) * 8) {
        return number; // Invalid position, return original number
    }

    return number | (1 << position);
} // end setBit

/*

    Function: clearBit
   
    takes: an integer number and a bit position
    return: new number with the bit at that position cleared to 0

*/

int clearBit(int number, int position) {
    if (position < 0 || position >= sizeof(int) * 8) {
        return number; // Invalid position, return original number
    }

    return number & ~(1 << position);
} // end clearBit

/*

    Function: toggleBit
   
    takes: an integer number and a bit position and flips the bit at that position

*/

int toggleBit(int number, int position) {
    if (position < 0 || position >= sizeof(int) * 8) {
        return number; // Invalid position, return original number
    }

    return number ^ (1 << position);
} // end toggleBit

/*

    Function: multiplyBy2 and divideBy2
   
    takes: an integer number and multiplies it by number 2, or divides number by 2, respectively
    return: the result of the multiplication or division

*/

int multiplyBy2(int number) {
    return number << 1;
} // end multiplyBy2

int divideBy2(int number) {
    return number >> 1;
} // end divideBy2

/*

    Function: countSetBits
   
    takes: an integer number
    return: number of bits set to 1 in the number

*/

int countSetBits(int number) {
    int count = 0;

    while (number) {
        count += number & 1; // Increment count if the least significant bit is set
        number >>= 1; // Shift right to check the next bit
    }
    return count;
} // end countSetBits

#endif