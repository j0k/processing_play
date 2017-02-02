class StageController{
  int toStage = 0;
  String stage = "none";
  
  
  boolean defVasa = false;
  boolean defLeftVasaDetails = false;
  boolean defRightVasaDetails = false;
  
  void draw(){
    //if(defVasa){
        vasa.draw();
        vasa.update();
    //}
    //if(defLeftVasaDetails){
        leftFace.draw();
        leftFace.update();
    //}
    //if(defRightVasaDetails){
        rightFace.draw();
        rightFace.update();
    //}
  }
  
  void update(){
     switch(toStage){
      case 1:{
        stageAtt1();
        toStage = 0;
        stage  = "vasa";
        break;
      }
      case 2:{
        stageAtt2();
        toStage = 0;
        stage = "vasa";
        break;
      }
      case 3:{
        stageAtt3();
        toStage = 0;
        stage  = "det_Lvasa";
        break;
      }
      case 4:{
        stageAtt4();
        toStage = 0;
        stage = "det_Lvasa";
        break;
      }
      case 5:{
        stageAtt5();
        toStage = 0;
        stage  = "det_Rvasa";
        break;
      }
      case 6:{
        stageAtt6();
        toStage = 0;
        stage = "det_Rvasa";
        break;
      }
      default:return;
    }
    
    if (stage=="vasa"){
      defVasa = true;
    } else
    if (stage=="det_Lvasa"){
      defLeftVasaDetails = true;
    } else
    if (stage=="det_Rvasa"){
      defRightVasaDetails = true;
    }
  }
  
  void stageAtt1(){
    vasa.startAppear();
  }
  
  void stageAtt2(){
    vasa.startDisapper(); // !startDisappear();
  }
  
  void stageAtt3(){
    leftFace.startAppear();
  }
  
  void stageAtt4(){
    leftFace.startDisapper(); // !startDisappear();
  }
  
  void stageAtt5(){
    rightFace.startAppear();
  }
  
  void stageAtt6(){
    rightFace.startDisapper(); // !startDisappear();
  }
  
  int level=0;
  boolean levelChanged = false;
  int highMedThreshold=50, highAttThreshold=50;
  
  ActionTimer AttTimer = new ActionTimer(1000), MedTimer = new ActionTimer(1000);
  boolean nextLevel(float A, float M){
    if (level%2 == 0){
      // levels; 0,2,4,6,8,10
        if ((A >= highAttThreshold) && (AttTimer.itsDurationEnough())){
          highAttThreshold += 5;
          if (highAttThreshold>100)
            highAttThreshold = 100;
          level += 1;
          levelChanged = true;
        }
    } else {
      if ((M >= highMedThreshold) && (MedTimer.itsDurationEnough())){
          highMedThreshold += 5;
          if (highMedThreshold > 100)
            highMedThreshold = 100;
          level += 1;
          levelChanged = true;
        }
    }
    
    if (levelChanged)
    {
      AttTimer.refresh();
      MedTimer.refresh();
    }
    
    if (levelChanged)
    {
      vasa.reverseAppearing();
    }
    
    return levelChanged;
    
  }
  
  void vaseUpdate(){
    
  }
}