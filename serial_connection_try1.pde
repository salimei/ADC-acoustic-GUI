

// version 1 of the visualization software 



import processing.serial.*;    // Importing the serial library to communicate with the Arduino 

Serial myPort;      // Initializing a vairable named 'myPort' for serial communication
float input ;   // Variable coming from stm32
float decay;    // decay and expansion of circle over time 
float decay_2; // decay of circle created by mouse event 
int time_1;  // start of decay 
int x = 0; // x cord of mouse
int y = 0; // y cord of mouse 

  void setup ( ) {

    size (1200,  900);     // Size of the serial window, you can increase or decrease as you want
    //myPort  =  new Serial (this, "COM10",  115200); // Set the com port and the baud rate according to the Arduino IDE
    //myPort.bufferUntil ( '\n' );   // Receiving the data from the Arduino IDE
    frameRate(24);
    

    
  } 

  void draw ( ) {
    //serialEvent(myPort);          // keep listening to the port 
    //print(input);
    
    
    MakeBackground();
    noFill();
    circle(width/2, height/2, decay ); // redraw  the updated circle 
    circle(width/2, height/2, decay/2);   
    
    circle(x, y, decay_2 );   // circle created by click  
    circle(x, y, decay_2/2);
    decay = decay * 1.05 + width/30; // adjusting contant 
    decay_2 = decay_2 *1.05 +  width/30; 
   
  }




// find a way to deal with null pointer exception 
  void serialEvent  (Serial myPort) {
    input  =  float (myPort.readStringUntil ( '\n' ) ) ;  // Changing the background color according to received data
    time_1= millis();
   } 
   
  void mouseClicked() {
    x = mouseX;
    y = mouseY;  
    decay_2 = 0;
   }

  void MakeBackground() {   // draw a basic background 
    background(0);
    stroke(0, 153, 255);  // set color of following code 
    line(0, height/2, width, height/2); // draw line just like in Java 
  }
  
  float LevelDecay(int time_1) {  // returns a decay proportional to the passed time 
    int time_2;
    time_2 = millis() - time_1;  // compute the ellapsed time (ms)
    return (float) time_2/(0.2*width) ; // set speed
  }
