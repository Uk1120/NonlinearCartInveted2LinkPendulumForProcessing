float[][] x = new float[3][3];
float[] cof = new float[20];
float u;
float dt;

float[][] RK1 = new float[2][3];
float[][] RK2 = new float[2][3];
float[][] RK3 = new float[2][3];
float[][] RK4 = new float[2][3];

void setup() {
  size(800, 450);
  
  dt = 0.1;
  
  cof[0] = 0.2;
  cof[1] = 0.4;
  cof[2] = 0.2;
  cof[3] = 0.2;
  cof[4] = 0.4;
  cof[5] = 0.6;
  cof[6] = 0.2;
  cof[7] = 0.8;
  cof[8] = 0.1;
  cof[9] = 0.3;


  x[0][0] =width/100;
  x[1][0] = 0;

  x[0][1] = 0;
  x[1][1] = 0;
  
  x[0][2] = 0;
  x[1][2] = 0.001;
  
  
}
void draw() {
  if (mousePressed == true)
  {
    if (mouseButton == LEFT)
      u = 0.5;
    if (mouseButton == RIGHT)
      u = -0.5;
  }

  x[2][0] = -cof[0]*x[1][0] + u;
  x[2][1] = -cof[1]*x[2][0]*cos(x[0][1]) - cof[5]*x[2][2]*cos(x[0][1]-x[0][2]) - cof[3]*sq(x[1][1])*sin(x[0][1]-x[0][2]) + cof[4]*sin(x[0][1]) - cof[8]*x[1][1];
  x[2][2] = -cof[5]*x[2][1]*cos(x[0][1]-x[0][2]) - cof[6]*sq(x[1][2])*sin(x[0][1]-x[0][2]) + cof[7]*sin(x[0][1]-x[0][2]) - cof[9]*x[1][2];
  
  u = 0;

  /*
   x[][] left bracket is differential order, right bracket is variable type.
   x[][0] = x
   x[][1] = theta1
   x[][2] = theta2
  */
  
  for (int j=2; j>=0; j--) { //variable type
    for (int i=1; i>=0; i--) { //differential order
      //Runge-Kutta method
      RK1[i][j] =  x[i+1][j] *dt;
      RK2[i][j] = (x[i+1][j] + RK1[i][j]/2)*dt;
      RK3[i][j] = (x[i+1][j] + RK2[i][j]/2)*dt;
      RK4[i][j] = (x[i+1][j] + RK3[i][j])*dt;
      x[i][j] += (RK1[i][j] + 2*RK2[i][j] + 2*RK3[i][j] + RK4[i][j])/6;
    }
  }

  //draw
  background(200);
  noFill();
  strokeWeight(3);
  rect(50*x[0][0], height/2, 50, 50); //cart
  strokeWeight(8);
  point(50*x[0][0], height/2); //cart joint
  strokeWeight(20);
  point(50*x[0][0] - 80*cos(x[0][1] + PI/2), height/2 - 80*sin(x[0][1] + PI/2)); //pendulum weight1
  point(50*x[0][0] - 80*cos(x[0][1] + PI/2) - 80*cos(x[0][2] + PI/2), height/2 - 80*sin(x[0][1] + PI/2) - 80*sin(x[0][2] + PI/2)); //pendulum weight2
  strokeWeight(5);
  line(50*x[0][0], height/2, 50*x[0][0] - 80*cos(x[0][1] + PI/2), height/2 - 80*sin(x[0][1] + PI/2)); //pendulum rod1
  line(50*x[0][0] - 80*cos(x[0][1] + PI/2), height/2 - 80*sin(x[0][1] + PI/2), 50*x[0][0] - 80*cos(x[0][1] + PI/2) - 80*cos(x[0][2] + PI/2), height/2 - 80*sin(x[0][1] + PI/2) - 80*sin(x[0][2] + PI/2)); //pendulum rod1
  strokeWeight(2);
  int n = 5;
  for (int k = 0; k<n; k++) {
    line(50*x[0][0], height/2 - 6*2*k, 50*x[0][0], height/2 - 6*(2*k-1));
  }
  rectMode(CENTER);

  fill(255);
  textSize(20);
  //text("Runge-Kutta", width/2, height/2-100);
}
