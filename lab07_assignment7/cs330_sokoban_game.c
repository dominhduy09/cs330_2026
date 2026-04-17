#include <ncurses.h>
#include <stdlib.h>  /* for malloc, exit() */
#include <unistd.h>  /* for sleep, EOF */
#include <string.h>  /* for strcmp(), strcat()  */
#include "sok_header.h"
// compile this with ncurses linked:
// and link static file
// gcc -Wall -g cs330_sokoban_code.c -L. -lsok_helper_vulcan -o cs330_sokoban -lncurses

/* ======= TO DO ======= */
/* 
- compile and run to ensure everything is working correctly
- write validMove() function
- write movePlayer() function
- test
*/

// Note: in starPusherLevels, largest map is 20 rows x 32 columns
// Note: to dereference a value: *((map + newPlayerY*MAP_COLS) + newPlayerX)

/* some variables we'll use in the game */

    /* these are declared 'extern' in the header since they're used
    in the library and in this c file */
        // these need to match the map (in case you change maps.txt)
        int MAP_COLS = 10;
        int MAP_ROWS = 10;
        // dX and dY are helpers for movement: up, right, down, left
        int dX[4] = {0,1,0,-1};
        int dY[4] = {-1,0,1,0};
        int numStarsSolved = 0;  // to represent the number of stars in the correct spot
        int NUM_STEPS = 0;      // to keep score

    /* the windows */
    WINDOW *title_bar;
    WINDOW *main_win;
    WINDOW *score_win;
    int WIN_OFFSET_X = 5;  // offset the upper left of the windows
    int WIN_OFFSET_Y = 0;
    int WIN_WIDTH = 25;
    int WIN_TITLE_HEIGHT = 3;
    int WIN_MAIN_HEIGHT = 22;    // can adjust this if it doesn't fit on screen
    int WIN_SCORE_HEIGHT = 4;
/*
Map values where 0=empty square, 1=wall, 2=player, 3=star, 4=goal square, 5=star on goal, 6 =player on goal
    Note: the following map is just a reference
    The real map is read in from the maps.txt file
       via the read_in_maps() function
int secondMap[10*10] = {
    1,1,1,1,1,1,1,1,1,1,
    1,0,2,0,1,1,0,0,0,1,
    1,0,3,0,0,0,0,0,0,1,
    1,0,4,0,0,0,0,0,0,1,
    1,0,0,0,0,3,0,4,0,1,
    1,0,0,0,0,0,0,0,0,1,
    0,1,1,0,0,0,0,0,0,1,
    1,1,0,0,0,0,0,0,0,1,
    1,0,0,0,0,0,0,0,0,1,
    1,1,1,1,1,1,1,1,1,1};
*/


/* draw the screen, given the map, number of rows, and number of columns */
int drawScreen(int rows, int cols, int *map){
    int i = 0;
    int j = 0;
    int windowI = i + 1;
    int windowJ = j + 1;
    for(i=0; i<MAP_ROWS; i++){
        for(j = 0; j<MAP_COLS; j++){
            windowI = i + 1;  // adding one gets the map inside the border
            windowJ = j + 1;
            int thisSquare = *((map + i*rows) + j);  // this works because this is really a 1D array in memory
            if (thisSquare == 1){
                mvwprintw(main_win, windowI,windowJ,"%c", '#');
            } else if (thisSquare == 2){
                attron(A_BOLD);  // turn on bold
                attron(COLOR_PAIR(2));  // turn on color previously defined for the player
                mvwprintw(main_win,windowI,windowJ,"%c", 'P');
                mvwchgat(main_win,windowI,windowJ,1,A_BOLD,2,NULL);
                attroff(A_BOLD);  // turn off bold
                attroff(COLOR_PAIR(2));  // turn off color previously defined
            } else if (thisSquare == 3){
                attron(COLOR_PAIR(3));  // turn on color previously defined for the star
                mvwprintw(main_win,windowI,windowJ,"%c", '$');
                mvwchgat(main_win,windowI,windowJ,1,A_BOLD,3,NULL);
                attroff(COLOR_PAIR(3));
            } else if (thisSquare == 4){
                mvwprintw(main_win,windowI,windowJ,"%c", 'O');
            } else if (thisSquare == 5){
                attron(COLOR_PAIR(5));
                mvwprintw(main_win,windowI,windowJ,"%c", '$');
                mvwchgat(main_win,windowI,windowJ,1,A_BOLD,5,NULL);
                attroff(COLOR_PAIR(5));
            } else if (thisSquare == 6){
                attron(A_BOLD);  // turn on bold
                attron(COLOR_PAIR(2));  // turn on color previously defined for the player
                mvwprintw(main_win,windowI,windowJ,"%c", 'P');
                mvwchgat(main_win,windowI,windowJ,1,A_BOLD,2,NULL);
                attroff(A_BOLD);  // turn off bold
                attroff(COLOR_PAIR(2));  // turn off color previously defined
            } else {
                attron(COLOR_PAIR(4));
                mvwprintw(main_win,windowI,windowJ,"%c", '.');
                mvwchgat(main_win,windowI,windowJ,1,0,4,NULL);
                attroff(COLOR_PAIR(4));
            }
        }  // end for j
    } // end for i
    //refresh();
    wrefresh(main_win);
    return 0;
}  // end drawScreen

/* ========== TO DO ========== */
/* create the two functions: validMove() and movePlayer() */

/* 
Takes an int to represent the direction: 0 = up, 1=right, 2=down, 3=left
    see also dX and dY
    a pointer to a Player structure, 
    and a pointer to the map
returns an int to represent whether this move is valid:
    0 = not a valid move
            out of bounds
            into a wall
            push star into another star, or star into a wall
    1 = valid move: simple player move into an empty square,
            push star to empty square,
            push star into goal,
            push star off goal
*/

// Note: this function is called when the user inputs a move, to check if it's valid before we move the player
int validMove(int direction, Player *p, int *map){
    int newX = p->x + dX[direction];    // this is the new player position if they move in the direction they input
    int newY = p->y + dY[direction];    // this is the new player position if they move in the direction they input

    // Out of bounds
    if(newX < 0 || newX >= MAP_COLS || newY < 0 || newY >= MAP_ROWS){   // if the new position is out of bounds, it's not a valid move
        return 0;   // note: we don't need to check the current position since the player is always in bounds, and they can only move one square at a time, so if the new position is out of bounds, it's not a valid move
    }

    int next = *((map + newY * MAP_COLS) + newX);   // this is the value of the square in the new position, which we need to check to see if it's a valid move

    // Wall
    if(next == 1){  // if the new position is a wall, it's not a valid move
        return 0;   // note: we don't need to check the current position since the player can always move off of a wall, and they can only move one square at a time, so if the new position is a wall, it's not a valid move
    }

    // Star or star on goal
    if(next == 3 || next == 5){     // if the new position is a star or star on goal, we need to check if we can push it
        int pushX = newX + dX[direction];   // this is the position the star would be pushed to if we move in the direction we input
        int pushY = newY + dY[direction];   // this is the position the star would be pushed to if we move in the direction we input

        if(pushX < 0 || pushX >= MAP_COLS || pushY < 0 || pushY >= MAP_ROWS){   // if the position the star would be pushed to is out of bounds, it's not a valid move
            return 0;   // note: we don't need to check the current position since the player is always in bounds, and they can only move one square at a time, so if the position the star would be pushed to is out of bounds, it's not a valid move
        }

        int beyond = *((map + pushY * MAP_COLS) + pushX);   // this is the value of the square in the position the star would be pushed to, which we need to check to see if it's a valid move

        // Can't push into wall or another star
        if(beyond == 1 || beyond == 3 || beyond == 5){  // if the position the star would be pushed to is a wall, star, or star on goal, it's not a valid move
            return 0;   // note: we don't need to check the current position since the player can always move off of a wall, and they can only move one square at a time, so if the position the star would be pushed to is a wall, star, or star on goal, it's not a valid move
        }
    }

    return 1;   // if we haven't returned 0 by now, it's a valid move
}


/* function won't be called unless we know it's a valid move
takes direction (of move), Player, and map
(a) determines which type of move, (b) updates map, (c) increments number of steps
    Types of moves include:
    (1) player moves from blank space
        (1.a) into blank space,
        (1.b) or onto goal space
        (don't forget to restore goal when player moves off goal space)
        also player walks from goal space to blank space, or goal space
    (2) player pushes star:
        (2.a) pushes star into blank space
        (2.b) pushes star onto goal
        (2.c) pushes star off goal onto blank space
        (2.d) pushes star off goal and onto another goal
returns: nothing
*/

// Note: this function is called after we check that the move is valid, to update the map and player position
void movePlayer(int direction, Player *p, int *map){    // we know this is a valid move, so we just need to update the map and player position

    int oldX = p->x;    // this is the current player position, which we need to update the map to reflect the player moving off of this square
    int oldY = p->y;    // this is the current player position, which we need to update the map to reflect the player moving off of this square

    int newX = oldX + dX[direction];    // this is the new player position, which we need to update the map to reflect the player moving onto this square
    int newY = oldY + dY[direction];    // this is the new player position, which we need to update the map to reflect the player moving onto this square

    int *current = (map + oldY * MAP_COLS) + oldX;  // this is the value of the square the player is currently on, which we need to check to see if we need to restore a goal when the player moves off of it
    int *next = (map + newY * MAP_COLS) + newX;     // this is the value of the square the player is moving onto, which we need to check to see if it's a star that needs to be pushed, and to update it to reflect the player moving onto it

    // ===== PUSHING STAR =====
    if(*next == 3 || *next == 5){   // if the player is moving onto a star or star on goal, we need to push it
        int pushX = newX + dX[direction];   // this is the position the star is being pushed to, which we need to update the map to reflect the star moving onto it
        int pushY = newY + dY[direction];   // this is the position the star is being pushed to, which we need to update the map to reflect the star moving onto it

        int *beyond = (map + pushY * MAP_COLS) + pushX;     // this is the value of the square the star is being pushed to, which we need to check to see if we need to update the number of stars solved, and to update it to reflect the star moving onto it

        // star to goal
        if(*beyond == 4){   // if the star is being pushed onto a goal, we need to update the number of stars solved and update the map to reflect the star on goal
            *beyond = 5;    // update map to reflect star on goal
            numStarsSolved++;   // update number of stars solved
        }
        else{
            *beyond = 3;    // update map to reflect star on blank space
        }

        // star was on goal
        if(*next == 5){     // if the star being pushed was on a goal, we need to update the number of stars solved and update the map to reflect the goal being uncovered
            *next = 4;      // update map to reflect goal uncovered
            numStarsSolved--;   // update number of stars solved
        }
        else{
            *next = 0;   // update map to reflect star moved off of blank space
        }
    }

    // ===== MOVE PLAYER =====
    if(*current == 6){      // if the player is currently on a goal, we need to update the map to reflect the goal being uncovered when the player moves off of it
        *current = 4;       // update map to reflect goal uncovered
    }
    else{
        *current = 0;       // update map to reflect player moved off of blank space
    }

    if(*next == 4){         // if the player is moving onto a goal, we need to update the map to reflect the player on goal
        *next = 6;          // update map to reflect player on goal
    }
    else{
        *next = 2;          // update map to reflect player on blank space
    }

    p->x = newX;            // update player position
    p->y = newY;            // update player position

    NUM_STEPS++;            // update number of steps
}

/* ========== END TO DO FUNCTIONS ========== */


int main(){
    // finish setting up variables
    int numCols = MAP_COLS;
    int numRows = MAP_ROWS;
    int *map = malloc((MAP_ROWS * MAP_COLS) * sizeof(int));

    Player *p = malloc(sizeof(Player));
    //p->x = 2;    // These values are assigned when the map is read in
    //p->y = 1;
    p->prevSquareValue = 0;

    // read in the map
    int numberOfStars = 0;
    read_in_maps(p, map, &numberOfStars);  // calls function to read in the maps file

    /* ======= set-up ncurses (graphics package) ======= */
    /* you don't need to modify this, unless you want to customize the graphics */
        initscr();  // initializes the screen
        raw();      // line buffering disabled
        keypad(stdscr, TRUE);   // allows for special keys like F1, F2, arrow keys
        noecho();               // don't echo() keypresses
        cbreak();               // don't wait for enter
        if(has_colors() == FALSE)
        {	endwin();
            printf("Your terminal does not support color\n");
            exit(1);
        }
        // for colors:
        start_color();          // start the color functionality
        // create some color combinations (ref num, forground color, background color):
        init_pair(2, COLOR_RED, COLOR_BLACK);  // create a new player color combo with red font and black background
        init_pair(3, COLOR_YELLOW, COLOR_BLACK);  // create a new color combo with red font and black background
        init_pair(4, COLOR_BLUE, COLOR_BLACK); 
        init_pair(5, COLOR_GREEN, COLOR_BLACK);
        // for the three windows
        title_bar = newwin(WIN_TITLE_HEIGHT, WIN_WIDTH, WIN_OFFSET_Y, WIN_OFFSET_X);
        main_win = newwin(WIN_MAIN_HEIGHT, WIN_WIDTH, WIN_OFFSET_Y + WIN_TITLE_HEIGHT, WIN_OFFSET_X);
        score_win = newwin(WIN_SCORE_HEIGHT, WIN_WIDTH, WIN_OFFSET_Y + WIN_TITLE_HEIGHT + WIN_MAIN_HEIGHT, WIN_OFFSET_X);
        // set up the window borders
        wborder(title_bar, '|', '|', '-', '-', '+', '+', '+', '+');  // a border  // was sdrscr
        // order is left side, right side, top side, bottom side, top left (corner), top right (corner), bottom left (corner), bottom right (corner)
        // can also access via their struct, e.g. title_bar->border.ls = '|';
        wborder(main_win, '|', '|', '-', '-', '+', '+', '+', '+');
        wborder(score_win, '|', '|', '-', '-', '+', '+', '+', '+');
        // set up the title bar window
        mvwprintw(title_bar, 1, (WIN_WIDTH-16)/2, "STAR PUSHER GAME");   // prints in win, y, x, string, (16 # chars in string)
        mvwchgat(title_bar,0, 0, -1, A_BOLD, 1, NULL);	
            /* decoder for mvwchgat:
            * First two parameters specify the position at which to start 
            * Third parameter number of characters to update. -1 means till 
            * end of line
            * Forth parameter is the normal attribute you wanted to give 
            * to the charcter
            * Fifth is the color index. It is the index given during init_pair()
            * use 0 if you didn't want color
            * Sixth one is always NULL 
            */
        refresh();
        wrefresh(title_bar);  // refreshes screen to match what's in memory (was refresh() for default win)
        wrefresh(main_win);
        wrefresh(score_win);
    /* ============================== */
    

    /* ======= game loop ======= */
    int keepLooping = 1;
    while(keepLooping){
        // draw the screen
        drawScreen(numRows, numCols, map);
        // draw score screen
        mvwprintw(score_win, 1, 1, "Steps: %d", NUM_STEPS);
        wrefresh(score_win);
        
        // get user input
        int input = getch();  // get user input
        //printw("%d", input);
        int delta = -1;  // -1 not a value. 0=Up, 1=Right. 2=Down, 3-left (see dX, dY values)
        switch(input){
            case KEY_UP:
                delta = 0;
                break;
            case KEY_RIGHT:
                delta = 1;
                break;
            case KEY_DOWN:
                delta = 2;
                break;
            case KEY_LEFT:
                delta = 3;
                break;
            case 113:           // lower case 'q'
            case 81:            // upper case 'Q'
            case 10:            // enter key
                keepLooping = 0;
                break;
        }
  
        /* ======= TODO ======= */

        // if it's a valid move, move player (and star)
        /* uncomment this section as you write the functions above
        if (validMove(delta, p, map)){
            // move player (and star)
            movePlayer(delta, p, map);
        }
        */
        

        /* comment this section out and uncomment the section above
          NOTE:  There should be no TA_... in your code
        */
        if (delta != -1 && validMove(delta, p, map)){       // if the input is a valid direction and it's a valid move, move the player
            movePlayer(delta, p, map);      // move player (and star)
     }
        

        /* ======= END TO DO ======= */

        /* check to see if the player won */
        if(numStarsSolved == numberOfStars){  
            // update and draw score screen
            mvwprintw(score_win, 2, (WIN_WIDTH-10)/2, "YOU WIN !!");  // 10 is length of string, just so it's centered
            wrefresh(score_win);
            // draw screen one last time (for satisfaction, it's nice to see our hard work pay off)
            drawScreen(numRows, numCols, map);
            sleep(2);  // pause for 2 seconds so we can admire our work some more
            keepLooping = 0;  // set variable to hop out of loop
            // alternatively, load the next map
        }
    }
    
    // else keep looping

    endwin();  // deallocate memory and end ncurses
    return 0;
}