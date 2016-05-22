import SimpleOpenNI.*;
import processing.sound.*;

SimpleOpenNI context = new SimpleOpenNI(this);

void setup() {
  size(640, 480);

  context.setMirror(true);
  context.enableDepth();
  context.enableUser();
}

void draw() {
  context.update();
  int[] line = binUsers(context.userMap());
  // image(context.depthImage(), 0, 0);
  background(0);
  image(drawLine(line), 0, 0);
}

PImage drawLine(int[] line) {
  PImage result = createImage(width, height, RGB);
  result.loadPixels();
  for (int x = 0; x < width; x++) {
    result.pixels[width * line[x] + x] = color(255, 0, 0);
  }
  result.updatePixels();
  return result;
}

int[] binUsers(int[] userMap) {
  int[] result = new int[width];

  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      int value = userMap[width * y + x];
      if (value > 0) {
        // result[x] = value;
        result[x] = y;
        break;
      }
      result[x] = 0;
    }
  }
  return result;
}
