.data               # start of data section
# put any global or static variables here

myArr: .quad 1, 2, 3, 4, 5   # array of 5 integers (quadwords)
myArrSize: .quad 5              # size of the array (number of elements)

.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!
myMultString: .string "The answer is %d\n"   # format string for printf

.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution

# === functions here ===
# int divideByTwo(int n) {}
# divideByTwo, takes a number, n, and divides by 2
# Takes: an number n, %rdi
# Return: whole number division of n/2
divideByTwo:
    # save any callee-saved registers
        # 1. save all the callee-saved registers
        # 2. just save callee-saved registers that we use
        # 3. not use any callee-saved registers
        # 4. ignore the rules
    # set-up variables
        # n in rdi
        movq %rdi, %rax   # move n into rax for division
        # set-up 2
        movq $2, %rcx       # 2 in rcx for division
    # division
        cqto                # sign-extend rax into rdx, convert quadword to octoword for division
        idivq %rcx          # rdx:rax (n) / rcx --> rax
                            # rdx:rax (n) % rcx (2) --> rdx

    # place the answer in rax
        # done

    #restore any callee-saved registers


    ret


main:               # start of main() function
# preamble
pushq %rbp
movq %rsp, %rbp

# === main() code here ===
# a = 7, b = 5, c = a * b
# set-up variables
# int a = 7;
movq $7, %rax       # a = 7 in rax

# int b = 5;
movq $5, %rbx       # b = 5 in rbx

# multiply, int c = a * b;
imulq %rbx    # rbx(b) * rax(a) -> rdx:rax

    movq (%rax, %rbx, 8), %r12 # not working
    movq %r13, (%rax, %rbx, 8) # not working

# divideByTwo(-5)
# 1. save any caller-saved registers
    # none
# 2. set-up registers: 1st arg in %rdi, 2nd arg in %rsi
movq $-5, %rdi      # n = -5 in rdi
# 3. place 0 in rax
xorq %rax, %rax   # 0 in rax, no floating point registers in use
# 4. call function
call divideByTwo     # call divideByTwo(-5), answer in rax





# printf("The answer is %d\n", c);
# 1. save any caller-saved registers


# 2. set-up registers: 1st arg in %rdi, 2nd arg in %rsi
movq $myMultString, %rdi   # format string in rdi
movq %rax, %rsi           # c in rsi

# 3. put a 0 in %rax, no floating point registers in use
xorq %rax, %rax       # 0 in rax

# 4. call function
call printf


# clean up and return
movq $0, %rax       # place return value in rax
leave               # undo preamble, clean up the stack
ret                 # return

.section .note.GNU-stack,"",@progbits
# line above sets the stack as non-executable, and removes the compiler warning
# instead of the line above we could also compile with the flag: -z noexecstack
# This creates a new section, with a name the GNU linker recognizes, "" means no section flags, such as: noalloc noexec nowrite
# progbits is program bits, signifying that the section contains actual program data (even if it's an empty section acting as a marker)
