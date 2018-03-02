float xRatio = 1, yRatio = 1;

void nextImage() {
  background(255);
  loop();
  
  go = false;
  
  conf = confs[imgIndex];
  
  img = loadImage(conf.file);
  img.loadPixels();
  frameCount = 0;
  //go = true;
  
  toDrawDefImage = true;
  
  imgIndex += 1;
  if (imgIndex >= confs.length) {
    imgIndex = 0;
  }
}


void paintStroke(float strokeLength, color strokeColor, int strokeThickness) {
  float stepLength = strokeLength/4.0;
  
  // Determines if the stroke is curved. A straight line is 0.
  float tangent1 = 0;
  float tangent2 = 0;
  
  float odds = random(1.0);
  
  if (odds < 0.7) {
    tangent1 = random(-strokeLength, strokeLength);
    tangent2 = random(-strokeLength, strokeLength);
  } 
  
  // Draw a big stroke
  noFill();
  stroke(strokeColor);
  strokeWeight(strokeThickness);
  curve(tangent1, -stepLength*2, 0, -stepLength, 0, stepLength, tangent2, stepLength*2);
  
  int z = 1;
  
  // Draw stroke's details
  for (int num = strokeThickness; num > 0; num --) {
    float offset = random(-50, 25);
    color newColor = color(red(strokeColor)+offset, green(strokeColor)+offset, blue(strokeColor)+offset, random(100, 255));
    
    stroke(newColor);
    strokeWeight((int)random(0, 3));
    curve(tangent1, -stepLength*2, z-strokeThickness/2, -stepLength*random(0.9, 1.1), z-strokeThickness/2, stepLength*random(0.9, 1.1), tangent2, stepLength*2);
    
    z += 1;
  }
}

void processImage(int npoints, int order){
  randomSeed(random(200000));
  pushMatrix();
  translate(width/2, height/2);
  
  int maxdim = img.height * img.width;
  for(int ig = 0; ig < npoints ; ig ++){
    int index = 0;
    
    x = (int)random(img.width  );
    y = (int)random(img.height );
    
    int y2 = y - 1;
    if (y2 < 0)
      y2 = 0;
    
    index = x + img.width * (y);    
    //index = y + img.height * x;    

    //int odds = (int)random(200);

    if (true) {
      color pixelColor = img.pixels[index];
      pixelColor = color(red(pixelColor), green(pixelColor), blue(pixelColor), 100);

      pushMatrix();
      translate((x-img.width/2) * xRatio, (y-img.height/2) * yRatio);
      //rotate(radians(random(-90, 90)));

      // Paint by layers from rough strokes to finer details
      if (order == 1){
        if (frameCount < 40) {
          // Big rough strokes
          paintStroke(random(150, 250), pixelColor, (int)random(20, 40));
        } else if (frameCount < 100) {
          // Thick strokes
          paintStroke(random(75, 125), pixelColor, (int)random(8, 12));
        } else if (frameCount < 400) {
          // Small strokes
          //paintStroke(random(30, 60), pixelColor, (int)random(8, 12));
          paintStroke(random(30, 60), pixelColor, (int)random(1, 4));
        } else if (frameCount < 550) {
          // Big dots
          paintStroke(random(5, 20), pixelColor, (int)random(5, 15));
        } else if (frameCount < 6000) {
          // Small dots
          paintStroke(random(1, 10), pixelColor, (int)random(1, 7));
        }
      } else if (order == 2){
        if (frameCount < 40) {
          // Big rough strokes
          paintStroke(random(1, 10), pixelColor, (int)random(1, 7));
        } else if (frameCount < 100) {
          // Thick strokes
          paintStroke(random(5, 20), pixelColor, (int)random(5, 15));
        } else if (frameCount < 400) {
          // Small strokes
          //paintStroke(random(30, 60), pixelColor, (int)random(8, 12));
          paintStroke(random(30, 60), pixelColor, (int)random(1, 4));
        } else if (frameCount < 550) {
          // Big dots
          
          paintStroke(random(75, 125), pixelColor, (int)random(8, 12));
        } else if (frameCount < 6000) {
          // Small dots
          
          paintStroke(random(150, 250), pixelColor, (int)random(20, 40));
        }
      }

      popMatrix();
    }

    //index += 1;
  }
  
  if (frameCount > 6000) {
    noLoop();
  }
  popMatrix();
}