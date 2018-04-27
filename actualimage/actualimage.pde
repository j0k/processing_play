// Clean the Day

Sequence seq;

Manip manip;
PsyDyn gmetrics;

void setup(){
  size(600,600);
  
  gmetrics = new PsyDyn(PSY.BASIC);  
  manip = new Manip(width/2, height/2, 50);
  
  seq = new Sequence();
  seq.add( new Imaginative(300, 300, true,  "positive.png", 2) );
  seq.add( new Imaginative(200, 200, false,  "negative.png", 2) );
  
  ArrayList<Imaginative> list = new ArrayList<Imaginative>();
  list.add( new Imaginative(300, 300, true,  "1.jpg", 2) );
  list.add( new Imaginative(300, 300, true,  "1.jpg", 2) );
  list.add( new Imaginative(200, 200, true,  "2.png", 1) );
  list.add( new Imaginative(300, 300, false, "3n.jpg", 3) );
  list.add( new Imaginative(300, 300, false, "4n.jpg", 1) );
  list.add( new Imaginative(300, 300, true , "5p.jpg", 2) );
  list.add( new Imaginative(300, 300, false, "6n.jpg", 1) );
  list.add( new Imaginative(300, 300, true , "7p.jpg", 2) );
  
  list = permutateImg(list);
  for(Imaginative im: list){
    seq.add(im);
  }
  
  seq.setup();
  setupIndicators();
}

void draw(){
  background(200);
  time.up_time(millis());
  mouseCheck();
  seq.draw();
  seq.up(time, gmetrics);
  
  manip.draw();
  
  indicatorsUp(gmetrics);
  drawIndicators();
}

void mouseReleased(){
  if (!manip.dragged){
    seq.goNext();
  }
  manip.dragged = false;
}

Timing time = new Timing();


void mouseCheck(){
  manip.up(time);
  
  gmetrics.up_att(manip.x * 100 / width);
  gmetrics.up_med(manip.y * 100 / height);    
}