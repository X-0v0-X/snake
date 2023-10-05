LDFLAGS=-framework Foundation -lncurses
snake: snake.o userfunc.o
	$(CC) $(LDFLAGS) $^ -o $@