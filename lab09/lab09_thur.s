.data               # start of data section
# put any global or static variables here

.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!
myString: .string "the answer is %d\n"   # format string for printf

.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution

# === functions here ===

main:               # start of main() function
# preamble
pushq %rbp
movq %rsp, %rbp

# === main() code here ===
# set-up int a = 2
movq $2, %rax   # a = 2 in %rax

# set-up int b = 3
movq $3, %rbx   # b = 3 in %rbx

# add, int c = a + b
addq %rbx, %rax #rbx(b) + rax(a) -> rax(c=a+b)

# printf("the answer is %d\n", c);
    #1. save any caller-saved registers
        # a. movq to a different register
            movq %rax, %r12  # c in %r12
        # b. copy to the heap (lab11)
        # c. push to the stack
            pushq %rax  # #rax(c) on stack, will be popped after the call to printf
    #2. set-up registers:
        # rdi = format string
        # rsi = first argument (c)
    movq $myString, %rdi   # ptr to string in %rdi
    movq %rax, %rsi # c in %rsi
    
    #3. put 0 in %rax, indicates we're using 0 floating point registers
    movq $0, %rax       # 0 in %rax
    xorq %rax, %rax       # 0 in %rax
    #4. call function
    call printf

    popq %rax   #  c in %rax 
    

# clean up and return
movq $0, %rax       # place return value in rax
leave               # undo preamble, clean up the stack
ret                 # return

.section .note.GNU-stack,"",@progbits
# line above sets the stack as non-executable, and removes the compiler warning
# instead of the line above we could also compile with the flag: -z noexecstack
# This creates a new section, with a name the GNU linker recognizes, "" means no section flags, such as: noalloc noexec nowrite
# progbits is program bits, signifying that the section contains actual program data (even if it's an empty section acting as a marker)
