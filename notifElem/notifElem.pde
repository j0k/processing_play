String desc = "You can tap on each block. You change it's speed using your relaxing state. Relax and the speed will increase.";
BallNotif not = new BallNotif(100,100,50,1000 * 2,color(0), "Level X", 40, "Master of Relax", 45, desc, 20);

void setup(){
  size(400,700);
  not.start();
}

void draw(){
  background(255);
  not.draw();
}