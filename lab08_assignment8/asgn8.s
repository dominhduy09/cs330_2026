.data               # start of data section
# put any global or static variables here


array: .long 2, 4, 6, 8, 10   # an array of 5 integers
array_size: .long 5           # size of the array

.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!

fmt_prime: .string "%ld "    # format string for printing a long integer
fmt_newline: .string "\n"   # format string for printing a newline

fmt_fib: .string "Fibonacci(%ld) = %ld\n"  # format string for printing Fibonacci results
fmt_found: .string "Found %ld in the array at index %ld\n"  # format string for printing search results
fmt_not_found: .string "%ld not found in the array\n"  # format string for printing search results when not found


.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution
.extern printf      # required, tells the assembler that printf is defined elsewhere (in the C standard library)

# === functions here ===

# prime_factors
# Input:
#   %rdi = number n
# Output:
#   prints prime factors of n
#
# Registers used:
#   %r12 = current n
#   %r13 = divisor i
#   %rax, %rdx = used by idiv
# Logic:
#   while n % 2 == 0: print 2, n /= 2
#   i = 3
#   while i*i <= n:
#       while n % i == 0: print i, n /= i
#       i += 2
#  if n > 2: print n

prime_factors:  
    pushq %rbp          # set up stack frame
    movq %rsp, %rbp     # standard function prologue
    # save callee-saved registers used
    pushq %r12          # r12 will hold the current n during factorization
    pushq %r13          # r13 will be used as the divisor i
    movq %rdi, %r12     # r12 = n

# handle factor 2
pf_loop_two:
    movq %r12, %rax         # move current n into rax for division
    cqto                    # sign-extend rax into rdx:rax for division
    movq $2, %r13           # r13 = 2
    idivq %r13              # rax = n/2, rdx = n%2
    cmpq $0, %rdx           # check if n is divisible by 2
    jne pf_start_odd        # if not divisible, move to odd factors

    # print 2
    leaq fmt_prime(%rip), %rdi # format string for printing prime factor
    movq $2, %rsi       # prime factor to print
    movq $0, %rax       # number of vector registers used (0 for integer arguments)
    call printf         # call printf to print the prime factor
    movq %r12, %rax     # move current n into rax for division

    cqto                    # sign-extend rax into rdx:rax for division
    movq $2, %r13           # r13 = 2
    idivq %r13              # rax = n/2, rdx = n%2
    movq %rax, %r12         # n = n / 2
    jmp pf_loop_two         # repeat to check for more factors of 2

# start odd divisor loop
pf_start_odd:
    movq $3, %r13            # i = 3

pf_outer_loop:
    # check if i*i > n
    movq %r13, %rax     # rax = i
    imulq %r13, %rax    # rax = i*i
    cmpq %r12, %rax     # compare i*i with n
    jg pf_done_check    # if i*i > n, we are done with the loop

pf_inner_loop:
    movq %r12, %rax         # move current n into rax for division
    cqto                    # sign-extend rax into rdx:rax for division
    idivq %r13              # divide n by i
    cmpq $0, %rdx           # check if n is divisible by i
    jne pf_next_i           # if not divisible, move to next i

    # print i
    leaq fmt_prime(%rip), %rdi  # format string for printing prime factor
    movq %r13, %rsi             # prime factor to print
    movq $0, %rax               # number of vector registers used (0 for integer arguments)
    call printf                 # call printf to print the prime factor

    # n = n / i
    movq %r12, %rax         # move current n into rax for division
    cqto                    # sign-extend rax into rdx:rax for division
    idivq %r13              # divide n by i
    movq %rax, %r12         # n = n / i
    jmp pf_inner_loop       # repeat to check for more factors of i

pf_next_i:
    addq $2, %r13           # i += 2
    jmp pf_outer_loop       # repeat the outer loop

pf_done_check:  
    # if n > 2, print n     
    cmpq $2, %r12               # check if n is greater than 2
    jle pf_finish               # if n <= 2, we are done
    leaq fmt_prime(%rip), %rdi  # format string for printing prime factor
    movq %r12, %rsi             # prime factor to print (the remaining n)
    movq $0, %rax               # number of vector registers used (0 for integer arguments)
    call printf                 # call printf to print the remaining prime factor

pf_finish:
    # print newline
    leaq fmt_newline(%rip), %rdi    # format string for printing newline
    movq $0, %rax                   # number of vector registers used (0 for integer arguments)
    call printf                     # call printf to print the newline
    popq %r13                       # restore r13
    popq %r12                       # restore r12
    leave                           # undo stack frame setup
    ret                             # return from function

# fibonacci (recursive)
# Input:
#   %edi = n
# Output:
#   %rax = fib(n)
# Base cases:
#   fib(0) = 0
#   fib(1) = 1
# Registers used:
#   %edi = argument n
#   %rbx = stores original n
#   stack = temporarily stores fib(n-1)
fibonacci:
    pushq %rbp              # set up stack frame
    movq %rsp, %rbp         # standard function prologue
    pushq %rbx              # save rbx since we will use it to store original n
    cmp $0, %edi            # compare n with 0
    je fib_zero             # if n == 0, jump to fib_zero

    cmp $1, %edi            # compare n with 1
    je fib_one              # if n == 1, jump to fib_one    

    movl %edi, %ebx          # save original n
    subq $8, %rsp            # align stack before first recursive call

    subl $1, %edi            # n-1
    call fibonacci           # fib(n-1) result will be in rax
    addq $8, %rsp            # restore stack after first recursive call
    pushq %rax               # save fib(n-1)
    movl %ebx, %edi          # restore original n into edi
    subl $2, %edi            # n-2
    call fibonacci           # fib(n-2) result will be in rax

    popq %rbx                # restore fib(n-1)
    addq %rbx, %rax          # fib(n) = fib(n-1) + fib(n-2)
    jmp fib_done             # jump to end to clean up and return

fib_zero:
    movq $0, %rax            # fib(0) = 0
    jmp fib_done             # jump to end to clean up and return

fib_one:
    movq $1, %rax            # fib(1) = 1

fib_done:
    popq %rbx                # restore rbx 
    leave                    # undo stack frame setup
    ret                      # return from function

# linear_search
# Input:
#   %edi = key
# Output:
#   %rax = index if found, -1 if not found
# Registers used:
#   %r8d = key
#   %rcx = index i

linear_search:
    pushq %rbp               # set up stack frame
    movq %rsp, %rbp          # standard function prologue
    movl %edi, %r8d          # key
    movq $0, %rcx            # i = 0

ls_loop:
    cmpq $5, %rcx               # compare i with array size (5)
    jge ls_not_found            # if i >= 5, key is not found
    movl array(,%rcx,4), %eax   # load array[i] into eax
    cmpl %r8d, %eax             # compare array[i] with key
    je ls_found                 # if they are equal, key is found at index i
    incq %rcx                   # increment i
    jmp ls_loop                 # repeat the loop

ls_found:
    movq %rcx, %rax             # move found index into rax for return
    leave                       # undo stack frame setup
    ret                         # return from function

ls_not_found:
    movq $-1, %rax              # key not found, return -1
    leave                       # undo stack frame setup    
    ret                         # return from function

# binary_search
# Input:
#   %edi = key
# Output:
#   %rax = index if found, -1 if not found
# Registers used:
#   %r8d = key
#   %r9  = left
#   %r10 = right
#   %r11 = mid

binary_search:
    pushq %rbp               # set up stack frame
    movq %rsp, %rbp          # standard function prologue
    movl %edi, %r8d          # key
    movq $0, %r9             # left = 0
    movq $4, %r10            # right = 4

bs_loop:
    cmpq %r9, %r10           # compare left and right
    jl bs_not_found          # if left > right, key is not found
    movq %r9, %r11           # r11 = left
    addq %r10, %r11          # r11 = left + right
    shrq $1, %r11            # mid = (left + right)/2

    movl array(,%r11,4), %eax   # load array[mid] into eax
    cmpl %r8d, %eax             # compare array[mid] with key
    je bs_found                 # if they are equal, key is found at index mid
    jl bs_go_right              # if array[mid] < key, search in the right half

    # key < array[mid]
    leaq -1(%r11), %r10         # right = mid - 1
    jmp bs_loop                 # repeat the loop

bs_go_right:
    leaq 1(%r11), %r9           # left = mid + 1
    jmp bs_loop                 # repeat the loop

bs_found:
    movq %r11, %rax             # move found index into rax for return   
    leave                       # undo stack frame setup
    ret                         # return from function

bs_not_found:
    movq $-1, %rax              # key not found, return -1
    leave                       # undo stack frame setup
    ret                         # return from function


main:               # start of main() function
# preamble
pushq %rbp          # save old base pointer
movq %rsp, %rbp     # set up new base pointer

# === main() code here ===



    # Problem 1: Prime Factorization
    # Example input: 15
    # Expected output: 3 5
    movq $15, %rdi      # move input number into rdi for prime_factors function
    call prime_factors  # call prime_factors function to print prime factors of 15

    # Problem 2: Fibonacci Recursive
    # Example input: 6
    # Expected output: 8
    movl $6, %edi               # move input number into edi for fibonacci function
    call fibonacci              # call fibonacci function to compute fib(6), result will be in rax
    leaq fmt_fib(%rip), %rdi    # format string for printing Fibonacci result
    movq $6, %rsi               # n = 6 for the format string
    movq %rax, %rdx             # fib(n) result in rdx for the format string
    movq $0, %rax               # number of vector registers used (0 for integer arguments)
    call printf                 # call printf to print the Fibonacci result

    # Problem 3: Linear Search
    # Example input: 6
    # Expected output: Found at index 2
    movl $6, %edi           # move input number into edi for linear_search function
    call linear_search      # call linear_search function to search for 6 in the array, result will be in rax
    cmpq $-1, %rax          # check if the result is -1 (not found)
    je print_ls_not_found   # if not found, jump to print_ls_not_found

    leaq fmt_found(%rip), %rdi
    movq $6, %rsi           # searched value for the format string
    movq %rax, %rdx         # found index
    movq $0, %rax           # number of vector registers used (0 for integer arguments)
    call printf             # call printf to print the search result
    jmp after_linear        # jump to after_linear to continue with the next problem

print_ls_not_found:
    leaq fmt_not_found(%rip), %rdi      # format string for not found case   
    movq $6, %rsi                       # searched value
    movq $0, %rax                       # number of vector registers used (0 for integer arguments)
    call printf                         # call printf to print the not found message

after_linear:
    # Problem 4: Binary Search
    # Example input: 10
    # Expected output: Found at index 4
    movl $10, %edi              # move input number into edi for binary_search function
    call binary_search          # call binary_search function to search for 10 in the array, result will be in rax
    cmpq $-1, %rax              # check if the result is -1 (not found)
    je print_bs_not_found       # if not found, jump to print_bs_not_found

    leaq fmt_found(%rip), %rdi  # format string for found case
    movq $10, %rsi              # searched value for the format string
    movq %rax, %rdx             # found index
    movq $0, %rax               # number of vector registers used (0 for integer arguments)
    call printf                 # call printf to print the search result
    jmp after_binary            # jump to after_binary to continue with the rest of the code

print_bs_not_found:
    leaq fmt_not_found(%rip), %rdi      # format string for not found case
    movq $10, %rsi                      # searched value
    movq $0, %rax                       # number of vector registers used (0 for integer arguments)
    call printf                         # call printf to print the not found message

after_binary:


    # clean up and return
    movq $0, %rax       # place return value in rax
    leave               # undo preamble, clean up the stack
    ret                 # return
