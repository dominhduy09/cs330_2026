.data               # start of data section
# put any global or static variables here


array: .long 4 , 1, 4, 5, 4, 9  # example array of integers
array_len: .quad 6  # length of the array
fact_num: .long 5   # example value for factorial function


.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!


sum_fmt: .string "Sum of array elements: %d\n"  # format string for printing sum of array elements
fact_fmt: .string "Factorial of %d is %ld\n" # format string for printing factorial result


.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution
.extern printf  # declare external function printf, so we can call it in code



# 1. Sum of Array Elements
# o Write a function that takes an array of integers and its length as arguments.
# o The function should iterate through each element using registers and compute
# file.
# the sum of all elements.
# o Return the final sum in the appropriate register according to the calling
# convention.

# Takes an integer array and its length, returns the sum of the elements.
sum_array:  # arguments: rdi = array address, rsi = array length
    # preamble
    pushq %rbp   # save base pointer        
    movq %rsp, %rbp  # set base pointer to current stack pointer

    movl $0, %eax   # sum = 0
    movq $0, %rcx   # i = 0

sum_loop:   # start of loop
    cmpq %rsi, %rcx  # compare i with length
    jge sum_done    # if i >= length, stop loop

    movl (%rdi,%rcx,4), %edx    # load array[i] into edx
    addl %edx, %eax # sum += array[i]

    incq %rcx    # i++
    jmp sum_loop    # repeat loop

sum_done:   # end of loop, sum is in eax
    leave   # undo preamble, clean up the stack
    ret # return from sum_array, result is in eax


# 2. Factorial Function
# o Write a function that takes a single integer argument and returns its factorial
# value.
# o The function should correctly handle inputs 0 and 1 (both return 1).
# o You may implement the factorial either iteratively or recursively.

# Takes one integer and returns its factorial.
factorial: # argument: rdi = n
    # preamble
    pushq %rbp  # save base pointer
    movq %rsp, %rbp # set base pointer to current stack pointer

    cmpl $1, %edi   # check if n <= 1
    jle fact_base   # if n is 0 or 1, return 1

    movq $1, %rax   # result = 1
    movl $2, %ecx   # i = 2

fact_loop:
    imulq %rcx, %rax    # result *= i
    incl %ecx    # i++

    cmpl %edi, %ecx # compare i to n
    jle fact_loop   # continue while i <= n

    leave   # undo preamble, clean up the stack
    ret # return from factorial

fact_base:
    movq $1, %rax   # return 1 for 0! and 1!
    leave   # undo preamble, clean up the stack
    ret # return from factorial



# === functions here ===

main:               # start of main() function
# preamble
pushq %rbp  # save base pointer
movq %rsp, %rbp # set base pointer to current stack pointer

subq $16, %rsp # allocate space for local variables (sum result and factorial result)
# === main() code here ===


# main program should:
# • Define an integer array and a test value for the factorial function.
# • Call both functions.
# • Print the sum of the array elements and the factorial result


# Call sum_array(array, array_len)
leaq array(%rip), %rdi  # first argument = address of array
movq array_len(%rip), %rsi # second argument = array length
call sum_array  # call the sum_array function

movl %eax, -4(%rbp)        # save sum result in local stack variable 

# Print sum result
leaq sum_fmt(%rip), %rdi    # format string in rdi
movl -4(%rbp), %esi   # sum result in rsi
movl $0, %eax   # 0 in rax for variadic function (printf)
call printf # call printf to print sum result

# Call factorial(fact_num)
movl fact_num(%rip), %edi   # first argument = value for factorial function
call factorial  # call the factorial function

movq %rax, -16(%rbp)       # save factorial result

# Print factorial result
leaq fact_fmt(%rip), %rdi   # format string in rdi
movl fact_num(%rip), %esi   # value for factorial function in rsi
movq -16(%rbp), %rdx    # factorial result in rdx (for 64-bit result)
movl $0, %eax   # 0 in rax for variadic function (printf)
call printf # call printf to print factorial result

# clean up and return
movq $0, %rax   # place return value in rax 
leave   # undo preamble, clean up the stack 
ret # return from main

.section .note.GNU-stack,"",@progbits
# line above sets the stack as non-executable, and removes the compiler warning
# instead of the line above we could also compile with the flag: -z noexecstack
# This creates a new section, with a name the GNU linker recognizes, "" means no section flags, such as: noalloc noexec nowrite
# progbits is program bits, signifying that the section contains actual program data (even if it's an empty section acting as a marker)
