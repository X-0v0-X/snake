#import "userfunc.h"

int main() {
  stdscr = initscr();
  noecho();     //キーが入力されても表示しない
  curs_set(0);  //カーソルを非表示
  cbreak();     //入力した文字を即時利用可能にする
  keypad(stdscr, TRUE);
  nodelay(stdscr, TRUE);

  srand((unsigned)time(NULL));

  int mode = 0;
  int ch;
  Snake *snake = [Snake new];
  Apple *apple = [Apple new];
  while ((ch = [snake input]) != 'q') {
    clear();
    if (mode == 0) {
      title();
      if (ch == 'o') mode = 1;
    } else if (mode == 1) {
      [snake move];
      [snake view];
      [apple spone];
      [apple view];
      if ([snake check:apple]) mode = 2;
    } else if (mode == 2) {
      gameover();
      if (ch == 'o') break;
    }

    refresh();
    [NSThread sleepForTimeInterval:1.0 / 6.0];
  }
EXIT:
  // system("stty echo");
  endwin();
  return 0;
}
