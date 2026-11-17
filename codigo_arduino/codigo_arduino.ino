int E1=9, E2=6, L1=8, L2=7;
bool estadoAnteriorE1 = LOW;
bool estadoAnteriorE2 = LOW;

void setup() {
  Serial.begin(9600);
  pinMode(L1, OUTPUT);
  pinMode(L2,OUTPUT);
  pinMode(E1,INPUT);
  pinMode(E2,INPUT);
}

void loop(){
  if (Serial.available()>0){
    char comando = Serial.read();
    if(comando == 'A'){
      digitalWrite(L1,HIGH);
    }else if (comando == 'a'){
      digitalWrite(L1,LOW);
    }
    if(comando == 'B'){
      digitalWrite(L2,HIGH);
    }else if (comando == 'b'){
      digitalWrite(L2,LOW);
    }
  }
 bool estadoActualE1 = digitalRead(E1);
  if (estadoActualE1 == HIGH && estadoAnteriorE1 == LOW) {
    int estadoL1Actual = digitalRead(L1);
    digitalWrite(L1, !estadoL1Actual);
    if(digitalRead(L1)==HIGH){
      Serial.print("C");
    } else{
      Serial.print("c");
    }
    delay(200); // Pequeña pausa antirrebote casera
  }
  estadoAnteriorE1 = estadoActualE1;
  bool estadoActualE2 = digitalRead(E2);
  if (estadoActualE2 == HIGH && estadoAnteriorE2 == LOW) {
    int estadoL2Actual = digitalRead(L2);
    digitalWrite(L2, !estadoL2Actual);
    if(digitalRead(L2)==HIGH){
      Serial.print("D");
    } else{
      Serial.print("d");
    }
    delay(200); // Pequeña pausa antirrebote casera
  }
  estadoAnteriorE2 = estadoActualE2;
}