float m, M;
float r;
float g;
float dt;
float u;
float x, dx, ddx;
float theta, dtheta, ddtheta;
float K;
float v;

boolean frag;

float k1, k2, k3, k4;
float l1, l2, l3, l4;
float m1, m2, m3, m4;
float n1, n2, n3, n4;

void setup() {
  size(800, 450);
  m = 0.1;
  M = 0.01;
  r = 2;
  g = 9.8;
  dt = 0.1;
  u = 0;

  K =1;

  x =width/100;
  dx = 0;

  theta = PI+0.01;
  dtheta = 0;
}
void draw() {
  //disturbance
  if (mousePressed == true)
  {
    if (mouseButton == LEFT)
      u = 2;
    if (mouseButton == RIGHT)
      u = -2;
  }
  //energy method
  if (abs(theta) > 0.5 && frag == true) {
    v = 0.3*dx-K*dtheta*cos(theta);
  }else if(frag == false){
    v = -0.2*(x - width/100) - dx; 
    if(abs(dtheta)< 0.001 && abs(dx) < 0.01){
      frag = true;
    }
  }
  //PD Control
  if (abs(theta) <= 0.3) {
    v = 10*sin(theta) + 0.1*(x - width/100) + 2* dtheta + 1*dx;
    frag = false;
  }
  //off screen
  if((50*x < 0 || width < 50*x) || abs(dtheta) > 2.5){
    v = -0.2*(x - width/100); 
    frag = false;
  }
  
  ddx = -0.3*dx + v + u;
  ddtheta = -0.5*ddx*cos(theta) -0.2*dtheta +0.6*sin(theta);
  u = 0;
  print("x: ");print(x);
  print(", dx: ");print(dx);
  print(", theta: ");print(theta);
  print(", dtheta: ");println(dtheta);
  print(", frag: ");println(frag);

  //Runge-Kutta method
  k1 = ddtheta*dt;
  k2 = (ddtheta + k1/2)*dt;
  k3 = (ddtheta + k2/2)*dt;
  k4 = (ddtheta + k3)*dt;
  dtheta += (k1 + 2*k2 + 2*k3 + k4)/6;
  l1 = dtheta*dt;
  l2 = (dtheta + l1/2)*dt;
  l3 = (dtheta + l2/2)*dt;
  l4 = (dtheta + l3)*dt;
  theta += (l1 + 2*l2 + 2*l3 + l4)/6;

  m1 = ddx*dt;
  m2 = (ddx + m1/2)*dt;
  m3 = (ddx + m2/2)*dt;
  m4 = (ddx + m3)*dt;
  dx += (m1 + 2*m2 + 2*m3 + m4)/6;
  n1 = dx*dt;
  n2 = (dx + n1/2)*dt;
  n3 = (dx + n2/2)*dt;
  n4 = (dx + n3)*dt;
  x += (n1 + 2*n2 + 2*n3 + n4)/6;


  //draw
  background(200);
  noFill();
  strokeWeight(3);
  rect(50*x, height/2, 50, 50);
  strokeWeight(8);
  point(50*x, height/2);
  strokeWeight(20);
  point(50*x - r*40*cos(theta + PI/2), height/2 - r*40*sin(theta + PI/2));
  strokeWeight(5);
  line(50*x, height/2, 50*x - r*40*cos(theta + PI/2), height/2 - r*40*sin(theta + PI/2));
  strokeWeight(2);
  int n = 5;
  for (int k = 0; k<n; k++) {
    line(50*x, height/2 - 6*2*k, 50*x, height/2 - 6*(2*k-1));
  }
  rectMode(CENTER);

  fill(255);
  textSize(20);
  //text("Runge-Kutta", width/2, height/2-100);
}
