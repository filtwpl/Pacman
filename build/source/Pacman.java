import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class Pacman extends PApplet {

Dot [] dots;
Pacboi mr;

public void setup() {
 
 background(0);

 int dotsRow = width/100;
 int dotsCol = height/100;
 int numDots = (dotsRow * dotsCol);
 dots = new Dot[numDots];

int r=50;
int c=50;
 for (int i=0; i<dots.length; i++) {
  if (i%dotsCol == 0) {
    dots[i] = new Dot(r, c);
    c+=100;
  } else {
    dots[i] = new Dot(r, c);
    c+=100;
    if (c>height) {
      r+=100;
      c=50;
    }
  }
 }

 mr = new Pacboi();
}

public void draw() {
  for (int i=0; i<dots.length; i++) {
      fill(255);
      dots[i].show();
      if (dots[i].myX == mr.myX && dots[i].myY == mr.myY) {
        dots[i].setMyAte(true);
      }
  }
  for (int i=0; i<dots.length; i++) {
    if (dots[i].myAte == true) {
      fill(0);
      rect(dots[i].myX-5, dots[i].myY-5, 10, 10);
    }
  }
  fill(245, 238, 42);
  mr.wowee();
}

public void keyPressed() {
  if(key == CODED) {
    if (keyCode == RIGHT) {
      mr.moveRight();
    }
    if (keyCode == LEFT) {
      mr.moveLeft();
    }
    if (keyCode == UP) {
      mr.moveUp();
    }
    if (keyCode == DOWN) {
      mr.moveDown();
    }
  }
}

class Dot {

  protected int myX, myY;
  protected boolean myAte;

  Dot(int x, int y) {
    myX = x;
    myY = y;
    myAte = false;
  }

  public void setMyAte(boolean ate) {
    myAte = ate;
  }

  public void show() {
    noStroke();
    ellipse(myX, myY, 10, 10);
  }

}

class Pacboi {

  protected int myX, myY, myDir; //1 is right, 2 is left, 3 is up, 4 is down

  Pacboi() {
    myX = myY = 50;
    myDir = 1;
  }

  public void wowee() {
    noStroke();
    fill(245, 238, 42);
    if(myDir == 1) {
      arc(myX, myY, 50, 50, QUARTER_PI, PI+3*QUARTER_PI, PIE);
    } else if (myDir == 2) {
      arc(myX, myY, 50, 50, 5*QUARTER_PI, TWO_PI+3*QUARTER_PI, PIE);
    } else if (myDir == 3) {
      arc(myX, myY, 50, 50, 7*QUARTER_PI, TWO_PI+5*QUARTER_PI, PIE);
    } else {
      arc(myX, myY, 50, 50, 0-5*QUARTER_PI, QUARTER_PI, PIE);
    }
  }

  public void clear() {
    fill(0);
    rect(myX-25, myY-25, 50, 50);
  }

  public void moveRight() {
    if (myX!=width-50) {
      clear();
      if (myDir != 1) {
        myDir = 1;
      }
      myX+=100;
    }
  }

  public void moveLeft() {
    if (myX!=50) {
      clear();
      if (myDir != 2) {
        myDir = 2;
      }
      myX-=100;
    }
  }

  public void moveUp() {
    if (myY!=50) {
      clear();
      if (myDir != 3) {
        myDir = 3;
      }
      myY-=100;
    }
  }

  public void moveDown() {
    if (myY!=height-50) {
      clear();
      if (myDir != 4) {
        myDir = 4;
      }
      myY+=100;
    }
  }

}
  public void settings() {  size(600, 500); }
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "Pacman" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
