#include <stdio.h>
#include <time.h>
#include <stdlib.h>
#include <math.h>

typedef struct t_moon {
  long x;
  long y;
  long z;

  long vx;
  long vy;
  long vz;
} moon;


moon moons[4] = {
  { 6, 10, 10, 0, 0, 0 },
  { -9, 3, 17, 0, 0, 0 },
  { 9, -4, 14, 0, 0, 0 },
  { 4, 14, 4, 0, 0, 0 }
  };

void printmoon(moon m) {
  printf("<x=%ld y=%ld z=%ld vx=%ld vy=%ld vz=%ld>\n", m.x, m.y, m.x, m.vx, m.vy, m.vz);
}

void apply_gravity() {
  for(int i=0; i<4; i++) {
    for(int j=i+1;j<4; j++) {
      printf("moon %d and %d\n", i, j);
    }
  }
}

int main() {


  apply_gravity();

}
