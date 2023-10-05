#include "userfunc.h"

void title() {
  NSString *msg = @"SNAKE GAME";
  mvprintw(START_Y - [msg length] / 2, START_X - [msg length] / 2, "%s",
           [msg cStringUsingEncoding:NSUTF8StringEncoding]);
}

void gameover() {
  NSString *msg = @"GAME OVER";
  mvprintw(START_Y - [msg length] / 2, START_X - [msg length] / 2, "%s",
           [msg cStringUsingEncoding:NSUTF8StringEncoding]);
}

@implementation Joint
- (id)init {
  [super init];
  x = START_X;
  y = START_Y;
  return self;
}
- (void)move:(Joint *)xjoint {
  x = [xjoint getX];
  y = [xjoint getY];
}
- (void)view {
  // setpos((int)x, (int)y);
  mvprintw(y, x, "~");
}
- (void)setXY:(float)sx float:(float)sy {
  x = sx;
  y = sy;
}
- (float)getX {
  return x;
}
- (float)getY {
  return y;
}
- (BOOL)check:(Joint *)head {
  if (x == [head getX] && y == [head getY]) {
    return YES;
  } else
    return NO;
}
@end

@implementation Apple
- (id)init {
  [super init];
  max = 1;
  cnt = 1;
  x = rand() % (COLS - 0 + 1) + 0;
  y = rand() % (LINES - 0 + 1) + 0;
  return self;
}
- (void)spone {
  int amax = 10000, amin = 0;
  if (cnt < max) {
    x = rand() % COLS;
    y = rand() % LINES;
    cnt = 1;
  }
}
- (void)despone {
  cnt = 0;
}
- (void)view {
  if (cnt > 0) mvprintw(y, x, "@");
  // mvprintw(3, 0, "%d", cnt);
}
- (BOOL)check:(Joint *)head {
  if (x == [head getX] && y == [head getY]) {
    [self despone];
    return YES;
  } else
    return NO;
}
@end

@implementation Snake
- (id)init {
  [super init];
  Joint *joint = [Joint new];
  joints = [@[ joint ] mutableCopy];
  vx = 1;
  vy = 0;
  speed = 1;
  NSLog(@"Init");
  return self;
}
- (void)view {
  [joints enumerateObjectsUsingBlock:^(Joint *joint, NSUInteger idx, BOOL *stop) {
    [joint view];
  }];
  Joint *head = [joints objectAtIndex:0];
  // mvprintw(0, 0, "%f, %f, %d", [head getX], [head getY], [joints count]);
  // mvprintw(1, 0, "%d, %d", vx, vy);
  // mvprintw(2, 0, "%c", key);
}
- (int)input {
  key = getch();
  if (key == 'a' && vx != 1)
    vx = -1, vy = 0;
  else if (key == 'w' && vy != 1)
    vx = 0, vy = -1;
  else if (key == 'd' && vx != -1)
    vx = 1, vy = 0;
  else if (key == 's' && vy != -1)
    vx = 0, vy = 1;
  return key;
}
- (void)move {
  for (int i = [joints count] - 1; i > 0; i--) {
    [[joints objectAtIndex:i] move:[joints objectAtIndex:i - 1]];
  }
  Joint *head = [joints objectAtIndex:0];
  [head setXY:[head getX] + vx * speed float:[head getY] + vy * speed];
}
- (void)add {
  Joint *joint = [Joint new];
  [joints addObject:joint];
}
- (void)sub {
}
- (Joint *)head {
  return [joints objectAtIndex:0];
}
- (BOOL)check:(Apple *)obj {
  BOOL result = NO;
  if ([obj check:[self head]]) [self add];
  Joint *head = [joints objectAtIndex:0];
  for (int i = 1; i < [joints count]; i++) {
    result = [[joints objectAtIndex:i] check:head];
  }
  float x = [head getX];
  float y = [head getY];
  if (x < 0 || x > COLS || y < 0 || y > LINES) result = YES;
  return result;
}
@end
