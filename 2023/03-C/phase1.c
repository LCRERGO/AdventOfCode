#include <ctype.h>
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LENGTH(X) ((sizeof(X)) / sizeof(X[0]))
#define DIFLENGTH(begin, end) ((end) - (begin)-1)
#define FIRSTINDEX(curline, width) ((1 + (curline)) * ((width) + 2) + 1)

// Symbol range 0x21...0x2F
// Symbol range 0x3A...0x40
// Symbol range 0x5B...0x60
// Invalid symbol 0x2E (.)

struct {
  size_t width, height;
  unsigned char values[32768];
} schematic;

void initSchematic() { memset(schematic.values, 0xFF, 2048); }

int issymbol(unsigned char c) {
#if 0
  if (!isdigit(c) && c != 0xFF && c != 0x2E) {
    return 1;
  }
#endif
  if (c >= 0x21 && c < 0x30 && c != 0x2E) {
    return 1;
  }
  if (c >= 0x3A && c < 0x41) {
    return 1;
  }
  if (c >= 0x5B && c < 0x61) {
    return 1;
  }

  return 0;
}

int myisdigit(unsigned char c) { return isdigit(c); }

int isgear(unsigned char c) {
  if (c == 0x2A) {
    return 1;
  }

  return 0;
}

int predindex(int i, int j, int *predi, int *predj,
              int (*pred)(unsigned char)) {
  if (pred(schematic.values[(j - 1) * (schematic.width + 2) + i - 1])) {
    *predi = i - 1;
    *predj = j - 1;
    return 1;
  }
  if (pred(schematic.values[(j - 1) * (schematic.width + 2) + i])) {
    *predi = i;
    *predj = j - 1;
    return 1;
  }
  if (pred(schematic.values[(j - 1) * (schematic.width + 2) + i + 1])) {
    *predi = i + 1;
    *predj = j - 1;
    return 1;
  }
  if (pred(schematic.values[(j) * (schematic.width + 2) + i - 1])) {
    *predi = i - 1;
    *predj = j;
    return 1;
  }
  if (pred(schematic.values[(j) * (schematic.width + 2) + i + 1])) {
    *predi = i + 1;
    *predj = j;
    return 1;
  }
  if (pred(schematic.values[(j + 1) * (schematic.width + 2) + i - 1])) {
    *predi = i - 1;
    *predj = j + 1;
    return 1;
  }
  if (pred(schematic.values[(j + 1) * (schematic.width + 2) + i])) {
    *predi = i;
    *predj = j + 1;
    return 1;
  }
  if (pred(schematic.values[(j + 1) * (schematic.width + 2) + i + 1])) {
    *predi = i + 1;
    *predj = j + 1;
    return 1;
  }

  return 0;
}

int checkneighbors(int i, int j, int (*pred)(unsigned char)) {
  if (pred(schematic.values[(j - 1) * (schematic.width + 2) + i - 1])) {
    return 1;
  }
  if (pred(schematic.values[(j - 1) * (schematic.width + 2) + i])) {
    return 1;
  }
  if (pred(schematic.values[(j - 1) * (schematic.width + 2) + i + 1])) {
    return 1;
  }
  if (pred(schematic.values[(j) * (schematic.width + 2) + i - 1])) {
    return 1;
  }
  if (pred(schematic.values[(j) * (schematic.width + 2) + i + 1])) {
    return 1;
  }
  if (pred(schematic.values[(j + 1) * (schematic.width + 2) + i - 1])) {
    return 1;
  }
  if (pred(schematic.values[(j + 1) * (schematic.width + 2) + i])) {
    return 1;
  }
  if (pred(schematic.values[(j + 1) * (schematic.width + 2) + i + 1])) {
    return 1;
  }

  return 0;
}

void getnumbounds(int index, int *begin, int *end) {
  size_t i;

  i = index;
  while (isdigit(schematic.values[i])) {
    i--;
  }
  *begin = i + 1;

  i = index;
  while (isdigit(schematic.values[i])) {
    i++;
  }
  *end = i;
}

int extractint(int begin, int end) {
  char buf[1024] = {0};

  for (size_t i = 0; i < (end - begin + 1); i++) {
    buf[i] = schematic.values[begin + i];
  }

  return atoi(buf);
}

int extractintbounded(int index) {
  int begin, end;

  getnumbounds(index, &begin, &end);
  return extractint(begin, end);
}

void printschematic() {
  for (size_t j = 0; j < schematic.height + 1; j++) {
    for (size_t i = 0; i < schematic.width + 2; i++) {
      if ((schematic.values[j * (schematic.width + 2) + i] & 0xFF) == 0xFF) {
#if DEBUG > 0
        printf("FF ");
#else
        continue;
#endif
      } else {
        printf("%2c ", schematic.values[j * (schematic.width + 2) + i]);
      }
    }
#if DEBUG > 1
    printf(" [%04ld]", (j + 1) * (schematic.width + 2));
#endif
    putchar(0x0A);
  }
}

void solve() {
  int left, right;
  int isdigit = 0;
  int isvalid = 0;
  int sum = 0;
  int auxi, auxj;
  int bounds1[2], bounds2[2];
  int increment;


  for (size_t j = 0; j < schematic.height + 1; j++) {
    for (size_t i = 0; i < schematic.width + 2; i++) {
      // Not invalid check
      if ((schematic.values[j * (schematic.width + 2) + i] & 0xFF) == 0xFF) {
        continue;
      }

      if (myisdigit(schematic.values[j * (schematic.width + 2) + i])) {
	getnumbounds(j * (schematic.width + 2) + i, &bounds1[0], &bounds1[1]);
	// check if valid
	isvalid = 0;
	auxj = j;
	for (int ci = bounds1[0]; ci < bounds1[1] && !isvalid; ci++) {
	  auxi = ci - j * (schematic.width + 2);
	  if (checkneighbors(auxi, auxj, issymbol)) {
	    isvalid = 1;
	  }
	}

	if (isvalid) {
	  right = extractint(bounds1[0], bounds1[1]);
#if DEBUG > 0
	  printf("num: %d\n", right);
#endif
	  sum += right;
        }
        increment = DIFLENGTH(bounds1[0], bounds1[1]);
	i += increment;
#if DEBUG > 0
	printf("Partial SUM: %d\n", sum);
#endif
      }
    }
  }

  printf("SUM: %d", sum);
}

int main(int argc, char *argv[]) {
  FILE *input;
  size_t width, height, curline;
  char buf[4096] = {0};
  memset(buf, 0xFF, 4096);

  if (argc < 2) {
    fprintf(stderr, "Usage: %s filename\n", argv[0]);
    return 1;
  }

  setvbuf(stdout, NULL, _IONBF, 0);

  input = fopen(argv[1], "r");

  fgets(buf, LENGTH(buf), input);
  initSchematic();
  width = strlen(buf) - 1;
  schematic.width = width;
  curline = 0;
  height = 1;
  fseek(input, 0, SEEK_SET);
  while (fgets(buf, LENGTH(buf), input)) {
    buf[width + 1] = 0;
#if DEBUG > 0
    printf("buf: %s\n", buf);
#endif
    memcpy(schematic.values + FIRSTINDEX(curline, width), buf, width);
    curline++;
    height++;
  }
  schematic.height = height;
#if DEBUG > 0
  putchar(0x0A);
  printschematic();
#endif

  solve();

  return 0;
}
