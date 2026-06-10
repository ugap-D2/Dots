// beastie_saver.c
#include <curses.h>
#include <unistd.h>
#include <string.h>

const char *beastie[] = {
"               ,        ,",
"              /(        )`",
"              \\ \\___   / |",
"              /- _  `-/  '",
"             (/\\/ \\ \\   /\\",
"             / /   | `    \\",
"             O O   ) /    |",
"             `-^--'`<     '",
"            (_.)  _  )   /",
"             `.___/`    /",
"               `-----' /",
"  <----.     __ / __   \\",
"  <----|====O)))==) \\) /====",
"  <----'    `--' `.__,' \\",
"               |        |",
"                \\       /",
"           ______( (_  / \\______",
"  (BSD)   ,'  ,-----'   |        \\",
"         `--{__________)        \\/ "
};

#define ART_H (sizeof(beastie) / sizeof(beastie[0]))

int is_trident(int row, int col) {
    return row >= 11 && row <= 13 && col <= 35;
}

int is_face(int row, int col) {
    return row >= 3 && row <= 10 && col >= 13 && col <= 30;
}

int is_feet_or_signature(int row) {
    return row >= 16;
}

void draw_beastie(int y, int x) {
    for (int r = 0; r < ART_H; r++) {
        for (int c = 0; beastie[r][c] != '\0'; c++) {
            char ch = beastie[r][c];

            if (ch == ' ')
                continue;

            if (is_trident(r, c)) {
                attron(COLOR_PAIR(3));       // trident
            } else if (is_feet_or_signature(r)) {
                attron(COLOR_PAIR(4));       // lower part / signature
            } else if (is_face(r, c) && (ch == 'O' || ch == '^' || ch == '_' || ch == '.' || ch == '-')) {
                attron(COLOR_PAIR(2));       // face details
            } else {
                attron(COLOR_PAIR(1));       // Beastie body
            }

            mvaddch(y + r, x + c, ch);

            attroff(COLOR_PAIR(1));
            attroff(COLOR_PAIR(2));
            attroff(COLOR_PAIR(3));
            attroff(COLOR_PAIR(4));
        }
    }
}

int main(void) {
    initscr();
    noecho();
    curs_set(0);
    nodelay(stdscr, TRUE);
    keypad(stdscr, TRUE);

    start_color();
    use_default_colors();

    init_pair(1, COLOR_RED, -1);      // Beastie body
    init_pair(2, COLOR_WHITE, -1);    // face / eyes
    init_pair(3, COLOR_YELLOW, -1);   // trident
    init_pair(4, COLOR_CYAN, -1);     // lower part

    int art_w = 0;
    for (int i = 0; i < ART_H; i++) {
        int len = strlen(beastie[i]);
        if (len > art_w)
            art_w = len;
    }

    int x = 5;
    int y = 2;
    int dx = 1;
    int dy = 1;

    while (1) {
        int ch = getch();
    
        if (ch != ERR && ch != KEY_RESIZE) {
            break;
        }
    
        int h, w;
        getmaxyx(stdscr, h, w);
    
        clear();
        draw_beastie(y, x);
        refresh();
    
        usleep(70000);
    
        x += dx;
        y += dy;
    
        if (x <= 0 || x + art_w >= w)
            dx = -dx;
    
        if (y <= 0 || y + ART_H >= h)
            dy = -dy;
    }

    endwin();
    return 0;
}
