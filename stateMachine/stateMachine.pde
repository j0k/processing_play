import java.util.Map.Entry;

float[][] bounds; //  = new Entry<Double, Double>();

int N = 10;
void setup(){
  int[] is = new int[20];
  size(500,500);
  bounds = new float[N][2]; 
  for(int i=0; i<N; i++){
    bounds[i] = new float[2];
  }
  
  print(bounds[1].length);
}

void draw(){
}