ArrayList<float[]> coord; //holds the coordinates necessary for translating and drawing in each recursive call
float r; //circle's radius
int numOfCycles;
boolean alpha;
float alphaValue;

void setup() {
  size(800, 800);

  r = 200;
  numOfCycles = 6; //NUMBER OF RECURSIVE CALLS
  alpha = true; //WHETHER OR NOT USING ALPHA FOR STROKE OF CIRCLE
  alphaValue = 255;

  coord = new ArrayList<float[]>();
  //STARTING SET OF COORDINATES FOR THE FIRST 4 POINTS
  coord.add(new float[2]);
  coord.add(new float[2]);
  coord.add(new float[2]);
  coord.add(new float[2]);

  //ASSIGN THE COORDINATES (CLOCKWISE)
  coord.get(0)[0] = 0;
  coord.get(0)[1] = -r;

  coord.get(1)[0] = r;
  coord.get(1)[1] = 0;

  coord.get(2)[0] = 0;
  coord.get(2)[1] = r;

  coord.get(3)[0] = -r;
  coord.get(3)[1] = 0;

  background(0);
  noFill();
  stroke(255);

  pushMatrix();
  //TRANSLATE COORDINATES SYSTEM TO CENTER OF SCREEN
  translate(width/2, height/2);

  //DRAW THE FIRST CIRCLE IN THE MIDDLE OF THE SCREEN
  ellipse(0, 0, r*2, r*2);

  //CALL RECURSIVE FUNCTION
  drawCircles(r, coord, 0, alpha, alphaValue);

  popMatrix();
  println("Finished");
}

void drawCircles(float _r, ArrayList<float[]> _coord, int _count, boolean _alpha, float _alphaValue) {
  //SAVE NUMBER OF ELEMENTS IN CURRENT LIST
  //the size of the list will grow inside the for loop, that's why I save the value
  //so I can use it as the condition for the loop
  int _listSize = _coord.size();

  //println("Original list size: " + listSize);

  if (_count < numOfCycles) {
    if (_alpha) {
      _alphaValue -= (_alphaValue * 0.3); //EACH CYCLE DECREASE DE ALPHA VALUE BY x%
      stroke(255, _alphaValue);
    }
    for (int i=0; i<_listSize; i++) {
      pushMatrix();
      //TRANSLATE TO THE FIRST SET OF COORDINATES IN THE LIST
      translate(_coord.get(i)[0], _coord.get(i)[1]);
      ellipse(0, 0, _r, _r);
      //FOR EACH COORDINATE IN THE LIST, ADD 4 MORE FOR THE NEXT CYCLE
      _coord.add(new float[2]);
      _coord.get(_coord.size()-1)[0] = _coord.get(i)[0] + 0;
      _coord.get(_coord.size()-1)[1] = _coord.get(i)[1] - (_r/2);
      _coord.add(new float[2]);
      _coord.get(_coord.size()-1)[0] = _coord.get(i)[0] + _r/2;
      _coord.get(_coord.size()-1)[1] = _coord.get(i)[1];
      _coord.add(new float[2]);
      _coord.get(_coord.size()-1)[0] = _coord.get(i)[0] + 0;
      _coord.get(_coord.size()-1)[1] = _coord.get(i)[1] + (_r/2);
      _coord.add(new float[2]);
      _coord.get(_coord.size()-1)[0] = _coord.get(i)[0] - (_r/2);
      _coord.get(_coord.size()-1)[1] = _coord.get(i)[1];
      popMatrix();
    }

    //println("New list size: " + _coord.size());

    //REMOVE PREVIOUSLY USED COORDINATES 
    _coord.subList(0, _listSize).clear();

    //println("Updated list size: " + _coord.size());

    //REDUCE RADIUS IN HALF FOR NEXT RECURSIVE CALL
    _r *= 0.5;

    _count++;

    //CALL NEXT CYCLE WITH NEW RADIUS AND NEW COORDINATES
    drawCircles(_r, _coord, _count, _alpha, _alphaValue);
  }
}
