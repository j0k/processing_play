import java.util.Collections;
import java.util.Comparator;

class anint implements Comparable<anint>{
  int i;
  
  anint(int i){
    this.i = i;
  }
  
  //@Override
  public int compareTo(final anint pb) {
    int ret;
    if (this.i < pb.i)
      ret = -1;
    else 
      ret = 1;
      
    //return -1;
      
    //print(" cmp " + this.i + "@" + pb.i + " ="+ret);
    return ret;
  }
}

ArrayList<anint> xs;

void setup(){
  xs = new ArrayList<anint>();
  xs.add(new anint(3));
  xs.add(new anint(1));
  xs.add(new anint(5));

  for(int i=0;i<xs.size();i++)
    print(xs.get(i).i + " _ ");
    
  print("\n");
  Collections.sort(xs);
  print("\n");
  
  for(int i=0;i<xs.size();i++)
    print(xs.get(i).i + " _ ");
  
  
}