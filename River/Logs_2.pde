int log1X = 0;
int log1Y = 0;

void logDraw(){
  fill(#711010);
  log1X += 1;
  log1Y += 1;
  //noFill();
   //These Are The Logs And Rock To Avoid
    beginShape();
 //Log 1
  vertex(100, 100);//1
  vertex(200, 100);//2
  vertex(202, 90);//3
  vertex(207, 90);//4
  vertex(209, 100);//5
  vertex(250, 100);//6
  vertex(250, 105);//7
  vertex(240, 110);//8
  vertex(250, 115);//9
  vertex(240, 120);//10
  vertex(250, 125);//11
  vertex(250, 150);
  vertex(100, 150);

 endShape(CLOSE);

 
  beginShape();
  //Log2
  fill(#E8943F);
  vertex(100, 200); //1
  vertex(200, 200); //2
  vertex(202, 190); //3
  vertex(207, 190); //4
  vertex(209, 200); //5
  vertex(250, 200); //6
  vertex(250, 200); //7
  vertex(250, 210); //8
  vertex(250, 215); //9
  vertex(240, 220); //10
  vertex(250, 225); //11
  vertex(250, 250);
  vertex(100, 250);
  endShape(CLOSE);
  
  beginShape();
  //Log3
  fill(#3E1F00);
  vertex(100, 300); //1
  vertex(135, 300); //2
  vertex(137, 290); //3
  vertex(140, 290); //4
  vertex(145, 300); //5
  vertex(250, 300); //6
  vertex(250, 300); //7
  vertex(250, 310); //8
  vertex(250, 315); //9
  vertex(240, 320); //10
  vertex(250, 325); //11
  vertex(250, 350);
  vertex(100, 350);
  endShape(CLOSE);
  
  
  

  //These Are The Cans
  
  beginShape();
  //PurpleCan
  fill(#8504C6);
  strokeWeight(0);
  ellipse(168.0, 692, 35, 4);
  rect(150.5, 637, 35, 55);
  ellipse(168.0, 638, 35, 7);
  endShape(CLOSE);
  
  //RedCan
  beginShape();
  fill(#C60407);
  strokeWeight(0);
  ellipse(219.0, 692, 35, 4);
  rect(202.0, 637, 35, 55);
  ellipse(219.5, 638, 35, 7);
  endShape();
  
  //GreenCan
  beginShape();
  fill(#51C604);
  strokeWeight(0);
  ellipse(270.0, 692, 35, 4);
  rect(253.0, 637, 35, 55);
  ellipse(270.0, 638, 35, 7);
  
  endShape();

//This Is The Rock I Made
  beginShape();
  
  fill(#2C2C2C);
  vertex(270, 200); 
  vertex(320, 150);
  vertex(370, 130);
  vertex(420, 160);
  vertex(440, 220);
  vertex(410, 260);
  vertex(360, 240);
  vertex(330, 230);
  vertex(290, 210); 
  
  endShape(CLOSE);


}
