FILE = lab06_thur
# note: The line above should match your C file name, without the extension
# also, there cannot be a space after the file name

build: $(FILE).c
	# next line compiles with all warnings on, debug info, and links math lib
	gcc -Wall -g $(FILE).c -o $(FILE) -lm -fno-pie -no-pie


.PHONY: db

db:
	gdb -tui $(FILE)

run:
	./$(FILE)