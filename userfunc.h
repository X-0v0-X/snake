#import <Foundation/Foundation.h>
#include <fcntl.h>
#include <ncurses.h>
#include <stdio.h>
#include <termios.h>
#include <unistd.h>
#ifndef USERFUNC_H
#define USERFUNC_H

#define U_ARROW 'w'
#define D_ARROW 's'
#define L_ARROW 'a'
#define R_ARROW 'd'
#define SPACE ' '

#define START_X COLS / 2
#define START_Y LINES / 2

void title();

void gameover();

@interface Joint : NSObject {
  float x, y;
}
- (id)init;
- (void)move:(Joint *)xjoint;
- (void)setXY:(float)sx float:(float)sy;
- (void)view;
- (float)getX;
- (float)getY;
- (BOOL)check:(Joint *)head;
@end

@interface Apple : NSObject {
  int x, y;
  int max;
  int cnt;
}
- (id)init;
- (void)spone;
- (void)despone;
- (void)view;
- (BOOL)check:(Joint *)head;
@end

@interface Snake : NSObject {
 @public
  NSMutableArray *joints;
  int vx, vy;
  float speed;
 @public
  int key;
}
- (id)init;
- (void)view;
- (int)input;
- (void)move;
- (void)add;
- (void)sub;
- (Joint *)head;
- (BOOL)check:(Apple *)obj;
@end
#endif