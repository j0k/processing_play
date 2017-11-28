float curtime = millis();

float mintime = 100.0;
boolean dtEps(){
  return (millis() - curtime) > mintime;
}

void upEps(){
  curtime = millis();
}