/*This is Pacman, but minus the maze walls, ghosts, timers, points, lives, etc.
So basically it's Pacman, but Lame.
Much comments here bc future smol brain me will need hand holding.
Change window size as desired.
*/

//decl object instances
Dot [] dots;
Pacboi mr;
Ghost blinky;

public void setup() {
 size(800, 800);
 background(0);

//dots calcs
 int dotsRow = width/100;
 int dotsCol = height/100;
 int numDots = (dotsRow * dotsCol);

//init dots array
 dots = new Dot[numDots];

//init individual dots
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

//init paccy boi
 mr = new Pacboi();

 //init blinky
 blinky = new Ghost(255, 0,  0);
}

public void draw() {
  //showing dots, setting eaten status
  for (int i=0; i<dots.length; i++) {
      fill(255);
      dots[i].show();
      if (dots[i].myX == mr.myX && dots[i].myY == mr.myY) {
        dots[i].setMyAte(true);
      }
  }

  //covering dots with blk rects if eaten
  for (int i=0; i<dots.length; i++) {
    if (dots[i].myAte == true) {
      fill(0);
      rect(dots[i].myX-5, dots[i].myY-5, 10, 10);
    }
  }

  //showing paccy boi
  fill(245, 238, 42);
  mr.wowee();

  //showing blinky
  blinky.show();

  //if ghost and paccy boi touch, die
  if (blinky.getGhoX() == mr.getPacX() && blinky.getGhoY() == mr.getPacY()) {
    death();
  }

  //moving blinky every 1 sec
  if (frameCount % 90 == 0)
  {
    blinky.haunt(mr.getPacX(), mr.getPacY());
  }
}

//paccy boi keyboard to movement controls
void keyPressed() {
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

//the dots
class Dot {

//decl dot class member variables
  protected int myX, myY;
  protected boolean myAte;

//constructor, init dot class member variables
  Dot(int x, int y) {
    myX = x;
    myY = y;
    myAte = false;
  }

//setter function for eaten or not bool
  public void setMyAte(boolean ate) {
    myAte = ate;
  }

//show single dot
  public void show() {
    noStroke();
    ellipse(myX, myY, 10, 10);
  }
}

//paccy boi
class Pacboi {

//decl pacboi class member variables
  protected int myX, myY, myDir; //1 is right, 2 is left, 3 is up, 4 is down

//constructor, init pacboi class member variables
  Pacboi() {
    myX = myY = 50;
    myDir = 1;
  }

//getter for paccy x coord
  public int getPacX() {
    return myX;
  }

//getter for paccy y coord
  public int getPacY() {
    return myY;
  }
//show paccy boi depending on dir facing
//don't fuck with the radians. p l e a s e. sometimes diff ways to say an
//angle makes the whole paccy boi go poof. i'm probably doing something wrong.
  public void wowee() {
    noStroke();
    fill(245, 238, 42);
    if(myDir == 1) {
      arc(myX, myY, 50, 50, QUARTER_PI, PI+3*QUARTER_PI, PIE);
    } else if (myDir == 2) {
      arc(myX, myY, 50, 50, 5*QUARTER_PI, TWO_PI+3*QUARTER_PI, PIE);
    } else if (myDir == 3) {
      arc(myX, myY, 50, 50, 7*QUARTER_PI, TWO_PI+5*QUARTER_PI, PIE);
    } else if (myDir == 4) {
      arc(myX, myY, 50, 50, 0-5*QUARTER_PI, QUARTER_PI, PIE);
    } else {
      System.out.println("wowee() error");
    }
  }

//covering paccy bois old pos with blk rect when he moves
  public void clear() {
    fill(0);
    rect(myX-25, myY-25, 50, 50);
  }

  public void moveRight() {
    //check if in a pos to move right
    if (myX!=width-50) {
      //erase old paccy
      clear();
      //fix dir facing if needed
      if (myDir != 1) {
        myDir = 1;
      }
      //the actual move
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

//the ghosts
class Ghost {

//decl ghost class member variables
  protected int myX, myY, myCol;

//constructor, init ghost class member variables
  Ghost(int r, int g, int b) {
    myX = width - 50;
    myY = height - 50;
    myCol = color(r, g, b);
  }

//getter for ghost x coord
  public int getGhoX() {
    return myX;
  }

//getter for ghost y coord
  public int getGhoY() {
    return myY;
  }

//show ghost at bottom right corner
  public void show() {
    noStroke();
    fill(myCol);
    ellipse(myX, myY, 25, 25);
    ellipse(myX-9, myY+8, 7, 15);
    ellipse(myX, myY+8, 7, 15);
    ellipse(myX+9, myY+8, 7, 15);
  }

//covering ghost's old pos with blk rect when he moves
  public void ghostClear() {
    fill(0);
    rect(myX-25, myY-25, 50, 50);
  }

//chase pacman
  public void haunt(int pacX, int pacY) {
    if (pacX > myX) {
      if (myX != width - 50) {
        ghostClear();
        myX+=100;
      }
    } else {
      if (myX != 50) {
        ghostClear();
        myX-=100;
      }
    }
    if(pacY < myY) {
      if (myY !=50) {
        ghostClear();
        myY-=100;
      }
    } else {
      if(myY != height - 50) {
        ghostClear();
        myY+=100;
      }
    }
  }

//random walk
  public void randomHaunt() {
    int random = (int) (Math.random() * 4) + 1;
    if (random == 1) {
      if (myX != width - 50){
        ghostClear();
        myX+=100;
      }
    } else if (random == 2) {
      if (myX != 50) {
        ghostClear();
        myX-=100;
      }
    } else if (random == 3) {
      if (myY != 50) {
        ghostClear();
        myY-=100;
      }
    } else if (random == 4) {
      if (myY != height - 50) {
        ghostClear();
        myY+=100;
      }
    } else {
      System.out.println("haunt() error");
    }
  }
}

//restart game with right click
public void mousePressed() {
  if(mouseButton == RIGHT) {
    background(0);
    setup();
    loop();
  }
}

//death screen
public void death() {
  noLoop();
  background(0);
  textAlign(CENTER);
  text("you died. right click mouse twice to restart.", width/2, height/2);
}
