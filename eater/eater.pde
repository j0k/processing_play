int NC = 20;

Coin[] coins = new Coin[NC];

void setup() {
  size(900, 650);
  
  hsAtt = new HScrollbar(width/16, height/4, width/4, 16, 16, "Attention", 10);
  hsMed = new HScrollbar(width/16, height/4 + 32, width/4, 16, 16, "Meditation", 10);
  hsState = new HScrollbar(width/16, height/4 + 64, width/4, 16, 16, "", 10);
  
  eater = new Player(0, 0, 0.5, 0.5);
  
  for(int i = 0;i<coins.length;i++){
    coins[i] = new Coin((width/2 - random(width))/1.2, (height/2 - random(height))/1.2, 10 + random(10),0.1);
  }
}

Player eater;

void draw() {
  background(0);
  //image(img, 0, 0, width/2, height/2);
  hsAtt.update();  
  hsAtt.display();
  
  hsMed.update();  
  hsMed.display();
  eater.draw();
  eater.update_choords(hsAtt.value, hsMed.value);
  
  for(int i = 0;i<coins.length;i++){
    coins[i].update();
    coins[i].draw();
  }
  
  for(int i = 0;i<coins.length;i++){
    if (coins[i].if_eaten(eater)){
      coins[i].x = (width/2 - random(width))/1.2;
      coins[i].y = (height/2 - random(height))/1.2;
      eater.rad += 1;
    }
  }
}

void keyPressed() {
  keyPressedScrolls();
}