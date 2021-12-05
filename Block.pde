/*
 * Block class.
 *
 * Clase para definir la funcionalidad de los bloques.
 */ 

public class Block {
  
  private float x;
  private float y;
  private int blockWidth;
  private int blockHeight;
  float blockU; 
  float blockD; 
  float blockL; 
  float blockR;
  
  public Block(float x, float y, int blockWidth, int blockHeight){
    
    this.x = x;
    this.y = y;
    this.blockWidth = blockWidth;
    this.blockHeight = blockHeight;
    
    blockU = y - blockHeight/2;    // hacia arriba
    blockD = y + blockHeight/2;    // hacia abajo
    blockL = x - blockWidth/2;     // hacia la izquierda
    blockR = x + blockWidth/2;     // hacia la derecha
    
  }
  
  // Dibujamos los bloques.
  public void draw() {
    
    fill(255);
    rect(this.x, this.y, this.blockWidth, this.blockHeight);
    
  }
  
}
