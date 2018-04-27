boolean inScreen(Rect r){
  if ((r.x > 0 && r.x < width) && (r.y > 0 && r.y < height))
    return true;
    
  if ((r.x + r.w > 0 && r.x + r.w < width) && (r.y > 0 && r.y < height))
    return true;
  
  if ((r.x > 0 && r.x < width) && (r.y + r.h > 0 && r.y + r.h < height))
    return true;
    
  return false;
    
}

int[] randSeq(int n){
  HashMap<Integer, Integer> hm = new HashMap<Integer, Integer>();
  
  int[] rseq = new int[n];
  
  for(int i = 0;i<n;i++){
    rseq[i] = i;
  }
  
  for(int i = 0;i<n;i++){
    int ic = (int) (n * random(1));
    int c = rseq[ic];
    rseq[ic] = rseq[i];
    rseq[i] = c;
  }
  
  return rseq;  
}

ArrayList<Imaginative> permutateImg(ArrayList<Imaginative> list){
  HashMap<Integer, Integer> hm = new HashMap<Integer, Integer>();
  
  int n = list.size();
  int[] rseq = new int[n];
  
  for(int i = 0;i<n;i++){
    rseq[i] = i;
  }
  
  for(int i = 0;i<n;i++){
    int ic = (int) (n * random(1));
    int c = rseq[ic];
    rseq[ic] = rseq[i];
    rseq[i] = c;
  }
  
  ArrayList<Imaginative> al = new ArrayList<Imaginative>();
  for(int i : rseq){
    al.add(list.get(i));
  }
  
  return al;  
}

void printSeq(int[] seq){
  for(int i = 0;i<seq.length;i++){
    print("" + seq[i] + " ");   
  }
  println();
  
}