import processing.serial.*;

Serial puertoSerial;

int ancho_pantalla=720;
int alto_pantalla=540;
float tamano_fuente= alto_pantalla*0.05;
float ancho_boton=(ancho_pantalla/3);
float alto_boton=(alto_pantalla/5);
float primer_posicionx=(ancho_pantalla/5)-(ancho_boton/2), primer_posiciony=(alto_pantalla/5)-(alto_boton/2);
float segunda_posicionx=3*(ancho_pantalla/4)-(ancho_boton/2);
float segunda_posiciony=3*(alto_pantalla/4)-(alto_boton/2);
int led1_on=0, led2_on=0;
void settings (){
  size(ancho_pantalla,alto_pantalla);
}

void setup(){
  println("El programa inicio correctamente");
  textSize(tamano_fuente);  
  printArray(Serial.list());
  puertoSerial = new Serial(this, "COM3",9600);
}

void draw () {
  int P=detectar_boton_fisico();
  if(P==1){
    led1_on=1;
  }
  if(P==2){
    led1_on=0;
  }
  if(P==3){
    led2_on=1;
  }
  if(P==4){
    led2_on=0;
  }
  background (137, 199, 192);
  fill(0, 0, 255);
  stroke(0,0,0);
  rect(primer_posicionx,primer_posiciony,ancho_boton,alto_boton);
  fill(0,0,0);
  textAlign(CENTER,CENTER);
  text("ENTRADAS",((primer_posicionx)+ancho_boton/2),((primer_posiciony)+alto_boton/2));
  fill(255, 0, 0);
  stroke(0,0,0);
  rect(primer_posicionx,segunda_posiciony,ancho_boton,alto_boton);
  fill(0,0,0);
  textAlign(CENTER,CENTER);
  text("SALIDAS",((primer_posicionx)+ancho_boton/2),((segunda_posiciony)+alto_boton/2));
  //ACA DIBUJO LOS PULSADORES DE ENTRADA
  if(mouseX>segunda_posicionx-(ancho_boton/4) && mouseX<segunda_posicionx-(ancho_boton/4)+ancho_boton/2 && mouseY>primer_posiciony && mouseY<primer_posiciony+alto_boton && mousePressed || P==1 || P==2){
    fill(0,0,255);
  }else{
    fill(128, 128, 255);
  }
  stroke(0,0,0);
  rect(segunda_posicionx-(ancho_boton/4),primer_posiciony,ancho_boton/2,alto_boton);
  fill(0,0,0);
  textAlign(CENTER,CENTER);
  text("E1",segunda_posicionx,primer_posiciony+(alto_boton/2));
  if(mouseX>segunda_posicionx+(segunda_posicionx/2)-(ancho_boton/4) && mouseX<segunda_posicionx+(segunda_posicionx/2)+ancho_boton/4 && mouseY>primer_posiciony && mouseY<primer_posiciony+alto_boton && mousePressed|| P==3 || P==4){
    fill(0,0,255);
  }else{
    fill(128, 128, 255);
  }
  stroke(0,0,0);
  rect(segunda_posicionx+(segunda_posicionx/2)-(ancho_boton/4),primer_posiciony,ancho_boton/2,alto_boton);
  fill(0,0,0);
  textAlign(CENTER,CENTER);
  text("E2",segunda_posicionx+(segunda_posicionx/2),primer_posiciony+(alto_boton/2));
  //ACA DIBUJO LOS LEDS DE SALIDA
  if(led1_on==0){
    fill(255, 128, 128);
  }else{
    fill(255,0,0);
  }
  stroke(0,0,0);
  circle(segunda_posicionx,segunda_posiciony+(alto_boton/2),alto_boton);
  fill(0,0,0);
  textAlign(CENTER,CENTER);
  text("L1",segunda_posicionx,segunda_posiciony+(alto_boton/2));
  if(led2_on==0){
    fill(255, 128, 128);
  }else{
    fill(255,0,0);
  }
  stroke(0,0,0);
  circle(segunda_posicionx+(segunda_posicionx/2),segunda_posiciony+(alto_boton/2),alto_boton);
  fill(0,0,0);
  textAlign(CENTER,CENTER);
  text("L2",segunda_posicionx+(segunda_posicionx/2),segunda_posiciony+(alto_boton/2));
}

void mousePressed() {
  // Comprobar clic en E1
  if (mouseX>segunda_posicionx-(ancho_boton/4) && mouseX<segunda_posicionx-(ancho_boton/4)+ancho_boton/2 && mouseY>primer_posiciony && mouseY<primer_posiciony+alto_boton){
    led1_on = 1 - led1_on;
    if(led1_on == 1){
      puertoSerial.write('A');
    }else{
      puertoSerial.write('a');
    }
  }
  
  // Comprobar clic en E2
  if (mouseX>segunda_posicionx+(segunda_posicionx/2)-(ancho_boton/4) && mouseX<segunda_posicionx+(segunda_posicionx/2)+ancho_boton/4 && mouseY>primer_posiciony && mouseY<primer_posiciony+alto_boton){
    led2_on = 1 - led2_on;
    if(led2_on == 1){
      puertoSerial.write('B');
    }else{
      puertoSerial.write('b');
    }
  }
}
int detectar_boton_fisico(){
  int vb = 0;
  if (puertoSerial.available()>0){
    char comando = (char) puertoSerial.read();
    if(comando == 'C'){
      vb=1;
      println("pulsa E1 para prender L1");
    }else if (comando == 'c'){
      vb=2;
      println("pulsa E1 para apagar L1");
    }
    if(comando == 'D'){
      println("pulsa E2 para prender L2");
      vb=3;
    }else if (comando == 'd'){
      vb=4;
      println("pulsa E1 para apagar L2");
    }
  }
  delay(100);
  return vb;
}
