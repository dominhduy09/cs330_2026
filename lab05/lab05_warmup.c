#include <stdio.h>

int main() {
    int a = 4, b = 2;
    a += 6;             // a = a + 6 == 10
    a *= b + 3;         // a = a * (b + 3) == 10 * (2 + 3) == 10 * 5 == 50
    a -= b + 8;         // a = a - (b + 8) == 50 - (2 + 8) == 50 - 10 == 40
    a /= b;             // a = a / b == 40 / 2 == 20
    a %= b + 1;         // a = a % (b + 1) == 20 % (2 + 1) == 20 % 3 == 2
    printf("a is now: %d\n", a);
    return 0;
}

/*
What is a?
(a) 0
(b) 1
(c) 2
(d) 3
(e) 6

*/