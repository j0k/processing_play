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
     balanceArcsC();
    
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
  
  boolean focusFace(){
    return (level%2 != 0);
  }
  
  boolean focusVase(){
    return (level%2 == 0);
  }
  
  float levelSpeed = 0.02;
  int maxArcs = 100;
  boolean influenceOppacity = true;
  boolean nextLevel(float A, float M){
    if (focusVase()){
      // levels; 0,2,4,6,8,10
        if ((A >= highAttThreshold) && (AttTimer.itsDurationEnough())){
          highAttThreshold += 5;
          if (highAttThreshold>100)
            highAttThreshold = 100;
            
          //arcsAdding.changeStartEndV(0, highAttThreshold );
          level += 1;
          levelChanged = true;
          
        }
    } else {
      if ((M >= highMedThreshold) && (MedTimer.itsDurationEnough())){
          highMedThreshold += 5;
          if (highMedThreshold > 100)
            highMedThreshold = 100;
            
          //arcsAdding.changeStartEndV(M, 10);
          level += 1;
          levelChanged = true;
          
          // VASA appearing!
          
          //          arcs.active = true;
          //arcs.changeStartEndV(0, highAttThreshold, 0, highAttThreshold * 2);
        }
    }
    
    arcs.active = true;
    
    if (levelChanged)
    {
      String message = "";
      notify.addText("Level: " + str(this.level) + "!");
      AttTimer.refresh();
      MedTimer.refresh();
      if (focusFace()){
        message = "Clear your mind, clear Vase. Try to see faces...";
        arcs.changeStartEndV(0,highMedThreshold*2/3, arcs.realV, 0);
      } else {
        arcs.changeStartEndV((highAttThreshold/5), highAttThreshold, 0, maxArcs * 2);
        message = "Focus on Vase. Try to see faces!";
      }
      notify.addText(message, (int) random(width/1.75), 1);
      print(message+"!"+"\n");
      
    }
    
    if (levelChanged)
    {
      if (focusFace())
        vasa.startAppear();
      else
        // focusVasa()
        vasa.startDisapper();
      
      
      if (level >= 4){ // 4,6,8
        
        if ((vasa.appearing) && focusFace()){
          // HERE WE NEED A PARAMS for speed and details!!!
          leftFace.startAppear();
          rightFace.startAppear();
        } else {
          leftFace.startDisapper();
          rightFace.startDisapper();
        }
      }
      
      if (level >= 6){ // 4,6,8
        levelSpeed = 0.02 * ((level - 4)/2);
      }
      
      if (level >= 10){ // 4,6,8
        influenceOppacity = false;
        colorizing = true;
      }
      
      if (level >= 12){
        strokeWeight = 4;
      }
      
      maxArcs = 50+100*(level/2);
    }
    
    return levelChanged;
    
  }
  
  void vaseUpdate(){
    
  }
}