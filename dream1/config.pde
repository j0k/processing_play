public class ImgConfig{
  String file;
  int order = 1;
  int strokes = 40;  
  bool drawBegin = false;

  ImgConfig(String file, int order, int strokes){
    this.file = file;
    this.order = order;
    this.strokes = strokes;
    if (order == 2)
      this.drawBegin = true;
  }
};

void initConf(){
  confs = new ImgConfig[4];

  //  {"finesleep.jpg", "cantsleep-min.jpg", "dream2-min.jpg", "tired.jpg"};
  int i = 0;
  confs[i] = new ImgConfig("finesleep.jpg", 1, 40);
  i ++ ;
  confs[i] = new ImgConfig("cantsleep-min.jpg", 2, 40);
  i ++; 
  confs[i] = new ImgConfig("dream2-min.jpg", 1, 40);
  i ++;
  confs[i] = new ImgConfig("tired.jpg", 2, 40);
}