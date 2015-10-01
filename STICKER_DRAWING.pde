import processing.serial.*;


//TRY ADDING INTERPOLATION FOR LOST PIXELS

//ADD COMMENTS TO EXPLAIN WHAT EVERYTHING DOES

//ADD A PREVIEW WINDOW

Table readVal; 

 PImage img;

boolean[][] squares;

int[] colours;
int[][] squaresR;
int[][] squaresG;
int[][] squaresB;
boolean[][] isOver;
Table save2Table;
TableRow[][] saveRow;
TableRow[][] readRow;

boolean bucket = false;

boolean eraser = false;

boolean grid = false;

int brushSize = 1;

Serial myPort;

Grid g = new Grid();
Key k = new Key();
Mouse m = new Mouse();
Colour c = new Colour();  
Save s = new Save();
Read r = new Read();
Serial ser = new Serial();





void setup()
{
  // selectInput("select", "fileSelected");
  
  
  
  isOver = new boolean[32][32];
  
  squaresR = new int[32][32];
  squaresG = new int[32][32];
  squaresB = new int[32][32];

  squares = new boolean[32][32];
  colours = new int[3];
  
  saveRow = new TableRow[32][32];
  
  save2Table = new Table();
  
  readRow = new TableRow[32][32];
  
  
  
  
    save2Table.addColumn("x");
    save2Table.addColumn("y");
    save2Table.addColumn("r");
    save2Table.addColumn("g");
    save2Table.addColumn("b");



  size(876, 736);

  //stroke(48);

  noSmooth();
  
  readVal  = loadTable("data/big mario mushroom.csv", "header");

  for (int i = 0; i < 32; i++)
  {
    for (int j = 0; j < 32; j++)
    {
      squares[i][j] = false;
      isOver[i][j] = false;
    }
  }
  
    for(int i = 0; i < 32; i++)
   {
      for(int j = 0; j < 32; j++) 
      {
        
        int counter = i*32+j;
        
        readRow[i][j] = readVal.getRow(counter);
        
        squares[i][j] = true;
        
        squaresR[i][j] = readRow[i][j].getInt("r");
        squaresG[i][j] = readRow[i][j].getInt("g");
        squaresB[i][j] = readRow[i][j].getInt("b");
      }
   }
 
   
}




void draw()
{
  g.update();
  c.update();
  //k.update();
  // m.update();
  
  
}

void keyPressed()
{
  if(key == 's' || key == 'S')selectOutput("select", "outSelect");
  if(key == 'r' || key == 'R')selectInput("select", "fileSelect");   
  if(key == 'p' || key == 'P')selectOutput("select", "areaSelect");
  
  k.update(key);
}



void mouseDragged()
{
   m.update();
}

void mousePressed()
{
  m.update();
}

 void fileSelect(File selection) 
 {
 r.readVal  = loadTable(selection.getAbsolutePath(), "header");
 
  r.read();
 
}


void outSelect(File selection)
{
  s.saveToTable(selection.getAbsolutePath());
}

void areaSelect(File selection)
{
  k.print(selection.getAbsolutePath());
}