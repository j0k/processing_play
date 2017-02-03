int defW = 1029;

void AddRandArcs(int c){
  float scale = (float) img_width / defW;
  
  for (int i = 0; i< c; i++){
    int row = (int) random(defW);
    
    if (LeftBoundX[row] != 0){
    
    
      int y = (int) (scale * row);
      int x = (int) (scale * LeftBoundX[row]);
      int cenX = (int) (defW/2 * scale);
    
      bounds.add(add_arc(img_x + cenX, img_y + y, abs(cenX-x)*2, abs(cenX-x)*2/3, random(0.010)));
    } else i --;
    //bounds.add(add_arc(vasaCenX, x, abs(vasaCenX-mouseX)*2, abs(vasaCenX-mouseX)*2/3, random(0.10)));
  }
  
  
    
    //bounds.sort();
    Collections.sort(bounds);
}

void RemoveRandArcs(int c){
  int i = 0;
  while ((bounds.size() > 0) && (i<c)){
    bounds.remove((int) random(bounds.size()));
    i++;
  }
}