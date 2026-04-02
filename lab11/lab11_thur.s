.data               # start of data section
# put any global or static variables here
myArr: .quad 1, 2, 3, 4, 5   # array of 5 integers (quadwords)
myArrSize: .quad 5              # size of the array (number of elements)

.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!
elementPrintString: .string "%d "   # format string for printf to print an element of the array
newlineString: .string "\n"          # format string for printf to print a newline

.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution

# === functions here ===
# void printMyArray(int* arr, int arrSize) {}
# prints the elements of an int array
# takes: ptr to arr in rdi
#        myArrSize in rsi
# returns: nothing, void function

printMyArray:
    # save any callee-saved registers
    # set-up variables
        movq %rdi, %rax   # arr in rax
        movq %rsi, %rbx   # arrSize in rbx
        movq $0, %rcx     # i = 0 in rcx

    # for(int i = 0; i < size; i++) {
    _startForLoop:

        # printf("%d ", *(arr + i) );
            # 1. save any caller-saved registers
                # TODO
                pushq %rax
                pushq %rcx
            # 2. set-up registers: 1st arg in rdi, 2nd arg in rsi

                movq $elementPrintString, %rdi   # format string in rdi
                # (ptr, index, width)
                # *(myArr + i)
                movq (%rax, %rcx, 8), %rsi      # *(arr + i) in rsi, scale by 8 for quadword indexing
            # 3. 0 in rax, no floating point regs
                xorq %rax, %rax   # set rax to 0 for variadic function (printf)    
            # 4. call function
                call printf

            # restore any caller-saved registers
                popq %rcx
                popq %rax

                        
        # inc i, i++
            inc %rcx
        # check to see if we're done looping
            cmpq %rbx, %rcx   # compare i and arrSize
            jl _startForLoop  # if i < arrSize, jump to start of loop

    # printf("\n");
        # 1. save any caller-saved registers
        # 2. set-up regs: 1st arg rdi
            movq $newlineString, %rdi   # format string in rdi
        # 3. 0 in rax, no floating point regs
            xorq %rax, %rax   # set rax to 0 for variadic function (printf)
        # 4. call function
            call printf

    # restore any callee-saved registers
    ret

main:               # start of main() function
# preamble
pushq %rbp
movq %rsp, %rbp

# === main() code here ===

# write 10 to 2nd element of the array (index = 3)
    movq $myArr, %rax      # address of myArr in rax
    movq $3, %rbx        # index 3 in rbx

    # (ptr, index, width)
    movq $10, (%rax, %rbx, 8)        # value 10 in rcx


# printMyArray(myArr, myArrSize)
    # 1. save any caller-saved registers
    # 2. set-up registers: 1st arg in rdi, 2nd arg in rsi
        movq $myArr, %rdi      # address of myArr in rdi
            # (ptr, index, width)
            # *(myArrSize)
        movq (myArrSize), %rsi   # value of myArrSize in rsi
    # 3. 0 in rax, no floating point regs
        xorq %rax, %rax   # set rax to 0 for variadic function (printf)
    # 4. call function
        call printMyArray


# clean up and return
movq $0, %rax       # place return value in rax
leave               # undo preamble, clean up the stack
ret                 # return

.section .note.GNU-stack,"",@progbits
# line above sets the stack as non-executable, and removes the compiler warning
# instead of the line above we could also compile with the flag: -z noexecstack
# This creates a new section, with a name the GNU linker recognizes, "" means no section flags, such as: noalloc noexec nowrite
# progbits is program bits, signifying that the section contains actual program data (even if it's an empty section acting as a marker)
