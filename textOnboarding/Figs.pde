class FCircle extends Figure2D<Circle>{
  FCircle(Point2D p, float rad, color c){
    super(new Circle(p, rad),c);
    this.fig.rad = rad;
  }
  
  FCircle(float x, float y, float rad, color c){
    super(new Circle(x, y, rad), c);
    this.fig.rad = rad;
  }
  
  void draw(){
    fill(c);
    ellipse(x, y, fig.rad, fig.rad);
  }
}