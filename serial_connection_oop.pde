

int time_1;  // start of decay 
int x = 0; // x cord of mouse
int y = 0; // y cord of mouse 
int n = 0;
Syst a;

  void setup ( ) {
    //frameRate(60);        // fixed framerate 
    size (1200,  900);     // Size of the serial window, you can increase or decrease as you want   
    a = new Syst();                     
    a.circle = new ArrayList<Circle>();
    
    Circle p = new Circle();   // draws an initial circle on the canvas (used for debugging)
    p.setCircle(width/2, height/2, 0);
    a.AddCircle(p);
  } 

  void draw ( ) { 
    MakeBackground();    // redraws the background
    a.run();             // runs the update routine 
  }
  
  // fix the array stuff
  
  class Syst {                 // the system class groups all actions related to the circle class
    ArrayList<Circle> circle;  // arraylist where we store the objects 
    
    void AddCircle(Circle p) {  // adds circles to the arraylist
      circle.add(p);  
    }
    
    void run() {
       
      //int i = 0;
      System.out.println(circle.size());
      /*
      while( i <  circle.size()) {
        Circle p = circle.get(i);
        p.update();
      }
      */

      for (int i = circle.size()-1; i >= 0; i--) { //cycle through each circle to update them
        Circle p = circle.get(i);  
        p.update();       // update the radius of the circle 
        
        if (p.isDead()) {
          circle.remove(i);   // get rid of old circles 
        }   
      }
    }
    
  }
  
// make circles into objects so we can multiple in parallel 
  
  class Circle  {   // by defining the circles as objects, we can have multiple of them
  // on the screen 
     int x_c = 0;   // x cord of circle 
     int y_c = 0;  // y cord of circle 
     float radius = 0;    // radius of circle 
     float lifespan = 25;  // the lifespan is a useful tool to get rid of circles
     //once they out of screen 
     
    void setCircle(int x_c, int y_c, float radius) {
      this.x_c = x_c;
      this.y_c = y_c;
      this.radius = radius;
    } 
     
    void update() {  // called at each cycle 
      radius = radius * 1.05 + width/30; // increases the radius exponentially 
      noFill();   // empty circles 
      circle(x_c, y_c, radius); // updates the radius 
      lifespan -= 1.0;    // decrements the lifespan 
    }
    
    boolean isDead() {  // checks if the circle reached its lifespan 
      if (lifespan < 0.0) {
        return true;
      } else {
        return false;
      }
    }
  }
 // mouse handler 
  void mouseClicked() {  // event triggered at each click, serves to create new circles 
    Circle p = new Circle();
    x = mouseX;  // fectch the x cord of the mouse 
    y = mouseY;  // fectch the y cord of the mouse 
    p.setCircle(x, y, 0); // sets the center of the circle 
    a.AddCircle(p); // adds the circle to the list 
   }

// background 
  void MakeBackground() {   // draw a basic background 
    background(0);
    stroke(0, 153, 255);  // set color of following code 
    line(0, height/2, width, height/2); // draw line just like in Java 
  }
  
 
