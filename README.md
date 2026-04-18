CS330 – Computer Organization & Assembly Language

Author: Do Minh Duy
Course: CS330 (Spring 2026)

⸻

📌 Overview

This repository contains all labs and assignments completed for CS330 – Computer Organization & Assembly Language.

The course focuses on low-level programming concepts, including:

* C programming
* x86-64 Assembly (AT&T syntax)
* Memory management
* Function calling conventions
* Debugging and program execution

⸻

📂 Repository Structure

Each folder corresponds to a specific lab or assignment:

* lab01 → Introduction and setup
* lab02_thur → Early C programming exercises
* lab03, lab03_thur → Basic logic and control structures
* lab04, lab04_thur → Functions and memory concepts
* lab05, lab05_assignment5 → Intermediate C programming
* lab06, lab06_assignment6 → Assembly basics and translation
* lab07, lab07_assignment7 → Sokoban game implementation
* lab08_assignment8 → Final assignment
* lab09 – lab13 → Advanced topics and continued practice

⸻

⚙️ Technologies Used

* C Programming Language
* x86-64 Assembly (AT&T syntax)
* GCC Compiler
* Makefile
* ncurses library (for Sokoban game)

⸻

▶️ Compilation & Execution

Compile C programs:

gcc -Wall -g program.c -o program
./program

Compile Assembly programs:

gcc -Wall -g program.s -o program
./program

Compile Sokoban (example):

gcc -Wall -g cs330_sokoban_code.c -L. -lsok_helper_vulcan -o cs330_sokoban -lncurses
./cs330_sokoban

⸻

🎮 Key Project – Sokoban Game

* Implemented core game mechanics:
    * Player movement (up, down, left, right)
    * Valid move checking (validMove())
    * Player actions (movePlayer())
* Used ncurses for terminal-based graphics
* Goal: push all boxes (stars) onto target locations

⸻

🧠 Learning Outcomes

Through this course, I learned:

* How high-level code translates into assembly
* Register usage and stack management
* Debugging low-level programs
* Understanding memory and pointers
* Building interactive terminal applications

⸻

⚠️ Notes

* All work in this repository is individual work
* Code is intended for educational purposes only
* Some assignments rely on provided starter code from the instructor

⸻

📬 Contact

Do Minh Duy
University of Alabama at Birmingham (UAB)
Computer Science Major