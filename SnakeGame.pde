import processing.sound.*;
SoundFile eat;
SoundFile over;
SoundFile turn;

Snake snake;
PImage img;
float[] xpos = new float[1]; 
float[] ypos = new float[1];
float array_len;

int x=1;
int y=0;;
int easy=1;
int speed;
float appleX;
float appleY;
int counter=0;
int num=0;
boolean check=false;
boolean s=true;

void setup() {
  size(580, 570);
  xpos[0]=width/2; // Setting value of inital x-position of the snake
  ypos[0]=height/2; // Setting value of inital y-position of the snake
  array_len=xpos.length*0.5;
  
  img=loadImage("image.jpg"); // Loading image of apple
  appleX=random(20,width-20); // Setting apple's x-position to some random value
  appleY=random(20,height-20); // Setting apple's y-position to some random value
  snake=new Snake(); // Initializing object snake
  eat = new SoundFile(this, "eat.wav"); // Initializing soundfile eat
  over = new SoundFile(this, "over.mp3"); // Initializing soundfile over
  turn = new SoundFile(this, "turn.mp3"); // Initializing soundfile turn
}

void draw() {
  background(255);
  frameRate(10);
  
  if(num==0){
    startPage(); // Calling function startPage(), i.e. menu
  }
 
  else if(num==1){
    imageMode(CENTER);
    image(img,appleX,appleY,20,20);
    snake.display();
    snake.eat();
    snake.hitEdge();
    fill(0);
    textSize(30);
    text("Score:"+counter,30,50); // Displaying the score
  }
  
  else if(num==2){
    gameOver(); // Calling function gameOver()
  }
}

class Snake{
  int dirX;
  int dirY;
  
  void display(){
    // Shift array values
    for (int i = 0; i < xpos.length-1; i ++ ) {
      // Shift all elements down one spot 
      // xpos[0] = xpos[1], xpos[1] = xpos = [2], and so on. 
      // Stop at the second to last element
      xpos[i] = xpos[i+1];
      ypos[i] = ypos[i+1];
      
    }
  
    // New location
    // Update the last spot in the array with the key
    
    xpos[xpos.length-1]+=dirX; 
    ypos[ypos.length-1]+=dirY;
  
    // Draw rectangles
    for (int i = 0; i < xpos.length; i ++ ) {
      noStroke();
      fill(#FC12AF);
      rectMode(CENTER);
      rect(xpos[i], ypos[i], 20, 20);
    }
    
    //When 'UP' key is pressed draw head, tongue and tail
    if(x==0){
      circle(xpos[xpos.length-1]+10,ypos[ypos.length-1]-10,20);
      circle(xpos[xpos.length-1]-10,ypos[ypos.length-1]-10,20);
      circle(xpos[0],ypos[0]+10,20);
      
      if(dist(xpos[xpos.length-1],ypos[ypos.length-1],appleX,appleY)<=50){
        fill(0);
        rect(xpos[xpos.length-1],ypos[ypos.length-1]-20,5,20);
      }  
    }
    
    //When 'DOWN' key is pressed draw head, tongue and tail
    else if(x==1){
      circle(xpos[xpos.length-1]+10,ypos[ypos.length-1]+10,20);
      circle(xpos[xpos.length-1]-10,ypos[ypos.length-1]+10,20);
      circle(xpos[0],ypos[0]-10,20);

      if(dist(xpos[xpos.length-1],ypos[ypos.length-1],appleX,appleY)<=50){
        fill(0);
        rect(xpos[xpos.length-1],ypos[ypos.length-1]+20,5,20);
      } 
    }
    
    //When 'RIGHT' key is pressed draw head, tongue and tail
    else if(x==2){
      circle(xpos[xpos.length-1]+10,ypos[ypos.length-1]+10,20);
      circle(xpos[xpos.length-1]+10,ypos[ypos.length-1]-10,20); 
      circle(xpos[0]-10,ypos[0],20);
      
      if(dist(xpos[xpos.length-1],ypos[ypos.length-1],appleX,appleY)<=50){
        fill(0);
        rect(xpos[xpos.length-1]+20,ypos[ypos.length-1],20,5);
      } 
    }

    //When 'LEFT' key is pressed draw head, tongue and tail
    else if(x==3){
      circle(xpos[xpos.length-1]-10,ypos[ypos.length-1]+10,20);
      circle(xpos[xpos.length-1]-10,ypos[ypos.length-1]-10,20); 
      circle(xpos[0]+10,ypos[0],20);
      
      if(dist(xpos[xpos.length-1],ypos[ypos.length-1],appleX,appleY)<=50){
        fill(0);
        rect(xpos[xpos.length-1]-20,ypos[ypos.length-1],20,5);
      } 
    }
  }
  
  void eat(){
    // Checks whether snake hits apple
    if(xpos[xpos.length-1]>=appleX-15 && xpos[xpos.length-1]<=appleX+15 && ypos[ypos.length-1]>=appleY-15 && ypos[ypos.length-1]<=appleY+15){
      // Set x and y position of apple to random values, when snake hits apple
      appleX=random(20,width-20);
      appleY=random(20,height-20);
      xpos = (float[]) append(xpos, xpos[xpos.length-1]);
      ypos = (float[]) append(ypos, ypos[ypos.length-1]);
      // Add score
      counter=counter+1;
      // Play eat sound
      eat.play();
    }
  }
  
  void hitEdge(){
    // Checks whether snake hits edges of the window
    if(s==true && xpos[xpos.length-1]<=20 ||xpos[xpos.length-1]>=width-20 || ypos[ypos.length-1]<=20 || ypos[ypos.length-1]>=height-20){
      // Play over sound
      over.play();      
      // Set x and y position of snake to initial value
      xpos[xpos.length-1]=width/2;
      ypos[ypos.length-1]=height/2;
      // Stop the snake
      dirX=0;
      dirY=0;    
      num=2;
    }
  }
  
  
}
  


// Menu page
void startPage(){
  fill(255);
  stroke(0);
  rect(width/15,height/1.4,width/4,height/5); // Easy mode button
  rect(width/2.7,height/1.4,width/4,height/5); // Moderate mode button
  rect(width/1.5,height/1.4,width/4,height/5); // Hard mode button
  fill(0);
  textSize(20);
  text("Snake game",width/3,height/8);
  text("Your snake must eat as much of the apples. The more apples snake eats, the bigger in size it becomes.",width/15,height/5,width/1.1,height/4);
  text("Control snake's moving using up, down, right, left buttons.",width/15,height/2.8,width/1.1,height/4);
  text("If you hit the edge of the window or snake's body, you lose.", width/15,height/1.9,width/1.1,height/4);
  text("Easy mode",width/11,height/1.2);
  text("Moderate mode",width/2.5,height/1.28,width/4,height/10);
  text("Hard mode",width/1.45,height/1.2);
  
  // When one of the buttons are pressed
  if(check==true){
    if(mouseX>=width/15 && mouseX<=width/15+width/4 && mouseY>=height/1.4 && mouseY<=height/1.4+height/5){
    num=1;
    // Set speed to easy level
    speed=easy;
    }
    else if(mouseX>=width/2.7 && mouseX<=width/2.7+width/4 && mouseY>=height/1.4 && mouseY<=height/1.4+height/5){
    num= 1;
    // Set speed to moderate level
    speed=easy*2;
    }
    else if(mouseX>=width/1.5 && mouseX<=width/1.5+width/4 && mouseY>=height/1.4 && mouseY<=height/1.4+height/5){
    num=1;
    // Set speed to hard level
    speed=easy*4;
    }
  }
  check=false;
}

void keyPressed() {
  // When 'UP' key is pressed
  if(keyCode==UP){
    turn.play(); // Play turn sound
    snake.dirX=0; // dirX is 0 since snake travels in y direction
    snake.dirY=-5*speed; // dirY is negative since snake travels upward
    x=0;
  }
  // When 'DOWN' key is pressed
  else if(keyCode==DOWN){
    turn.play(); // Play turn sound
    snake.dirX=0; // dirX is 0 since snake travels in y direction
    snake.dirY=5*speed; // dirY is positive since snake travels downward
    x=1;
  }
  // When 'RIGHT' key is pressed
  else if(keyCode==RIGHT){
    turn.play(); // Play turn sound
    snake.dirX=5*speed; // dirX is positive since snake travels along +x axis
    snake.dirY=0; // dirY is 0 since snake travels in x direction
    x=2;
  }
  // When 'LEFT' key is pressed
  else if(keyCode==LEFT){
    turn.play(); // Play turn sound
    snake.dirX=-5*speed; // dirX is positive since snake travels along -x axis
    snake.dirY=0; // dirY is 0 since snake travels in x direction
    x=3;
  }
}

void mousePressed(){
  check=true;
}

void gameOver(){
  
      background(255);
      fill(0);
      textSize(30);
      text("Game over",width/2.8,height/2);
      text("Score:"+counter,width/2.5,height/1.7);
      fill(255);
      stroke(0);
      rectMode(CORNER);
      rect(width/6,height/1.5,width/4,height/6);
      rect(width/2,height/1.5,width/4,height/6);
      fill(0);
      textSize(20);
      text("Back to menu",width/5.5,height/1.3);
      text("Exit",width/1.7,height/1.3);
      
      if(check==true && mouseX>=width/6 && mouseX<=width/6+width/4 && mouseY>=height/1.5 && mouseY<=height/1.5+height/6){
        num=0;
      }
      else if(check==true && mouseX>=width/2 && mouseX<=width/2+width/4 && mouseY>=height/1.5 && mouseY<=height/1.5+height/6){
        exit();
      }
      check=false;
}
