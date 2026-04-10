.data               # start of data section
# put any global or static variables here
myScanfVariable: .quad 0

.section .rodata    # start of read-only data section
# constants here, such as strings
# modifying these during runtime causes a segmentation fault, so be cautious!
scanfString: .string "%d"
printString: .string "The answer is %d\n"

.text               # start of text /code
# everything inside .text is read-only, which includes your code!
.global main        # required, tells gcc where to begin execution

# === functions here ===

main:               # start of main() function
# preamble
pushq %rbp
movq %rsp, %rbp

# === main() code here ===
# int a = 0;
# scanf("%d", &a);
    # 1. save any caller-saved regs
        # none
    # 2. set-up regs: 1st rdi, 2nd arg in rsi
        movq $scanfString, %rdi   # format string in rdi
        movq $myScanfVariable, %rsi  # address of myScanfVariable in rsi
    # 3. 0 in rax
        xorq %rax, %rax   # set rax to 0 for variadic function (scanf)
    # 4. call function
        call scanf

    # get the value out of myScanfVariable
    movq (myScanfVariable), %rax  # move the value of myScanfVariable into rax

# printf("The answer is %d\n", a);
    # 1. save any caller-saved registers
        # none
    # 2. set-up regs: 1st rdi, 2nd arg in rsi
        movq $printString, %rdi   # format string in rdi
        movq %rax, %rsi   # value of a in rsi
    # 3. 0 in rax
        xorq %rax, %rax   # set rax to 0 for variadic function (printf)
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
