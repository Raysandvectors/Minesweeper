import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
private MSButton[][] buttons; 
private ArrayList <MSButton> bombs; 
public void setup() {
    size(400, 500);
    textAlign(CENTER,CENTER);
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for (int r = 0; r < buttons.length; r++) {
        for (int c = 0; c < buttons[0].length; c++) {
            buttons[r][c] = new MSButton(r,c);
        }
      }
 bombs = new ArrayList <MSButton>();
 setBombs();
}
public void setBombs() {
 //your code
    while (bombs.size() < 80) {
        int r = (int)(Math.random()*NUM_ROWS);
        int c = (int)(Math.random()*NUM_COLS);
        if (bombs.contains(buttons[r][c]) == false) {
            bombs.add(buttons[r][c]);
            // println(r + ", " + c);
        }
    }
}



public void draw() {
    // background( 0 );
    if (isWon()) {
        displayWinningMessage();
    }
}

public boolean isWon() {
    //your code here
    for (MSButton temp: bombs) {
        if (temp.isMarked() == false) {
            return false;
        }
    }

    return true;
}



public void displayLosingMessage() {
    //your code here
    for (MSButton temp: bombs) {
        temp.setClick();
    }
    fill(0, 0, 255);
    // textSize(20);
    text("You Lost!", 200, 450);
    // println("You Lost!");
}



public void displayWinningMessage() {
    //your code here
    if (isWon()) {
        fill(0, 0, 255);
        // textSize(20);
        text("You Won!", 200, 450);
        // println("You Won!");
    }
}





public class MSButton {
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;  
    public MSButton ( int rr, int cc ) {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c * width;
        y = r * height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }



    public boolean isMarked() {
        return marked;
    }



    public boolean isClicked() {
        return clicked;
    }



    public void setClick() {
        clicked = true;
    }





    // called by manager

    

    public void mousePressed() {
        clicked = true;
        //your code here
        if (mouseButton == RIGHT) {
            marked = !marked;
            if (marked == false) {
                clicked = false;
            }
        } else if (bombs.contains(this)) {
            displayLosingMessage();
        } else if (!marked && countBombs(r,c) > 0) {
            setLabel("" + countBombs(r,c));
        } else {
            for (int nR = -1; nR <= 1; nR++) {
                for (int nC = -1; nC <= 1; nC++) {
                    if (isValid(r+nR,c+nC) && !(nR == 0 && nC == 0) && !(buttons[r+nR][c+nC].isClicked())) {
                       buttons[r+nR][c+nC].mousePressed();
                    }
                }
            }
        }
    }



    public void draw() {
        if (marked) {
            fill(0);
        } else if ( clicked && bombs.contains(this) ) {
            fill(255,0,0);
        } else if (clicked) {
            fill( 200 );
        } else {
            fill( 100 );
        }


        rect(x, y, width, height);
        fill(0);
        text(label,x + width/2, y + height/2);
    }



    public void setLabel(String newLabel) {
        label = newLabel;
    }



    public boolean isValid(int r, int c) {
        //your code here
        if (r >= 0 && r <= NUM_ROWS) {
            if (c >= 0 && c <= NUM_COLS) {
                return true;
            }
        }
        return false;
    }



    public int countBombs(int row, int col) {
        int numBombs = 0;
       //your code here
        for (int r = -1; r <= 1; r++) {
            for (int c = -1; c <= 1; c++) {
                if (isValid(row+r, col+c) && bombs.contains(buttons[row+r][col+c])) {
                    numBombs++;
                }
            }
        }
       return numBombs;
    }
}
