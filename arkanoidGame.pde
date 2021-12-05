/*
 * Práctica final.
 * Fundamentos físicos de la multimedia.
 * Natalia Justicia Villanueva
 * 
 * El objetivo de la práctica es crear 
 * una especie de juego similar al Arkanoid.
 */


float ballRadius = 25;          // tamaño del fotón
float ballX;                    // posición x del fotón
float ballY;                    // posición y del fotón
float ballSpeed = 5;            // velocidad del fotón
float ballXSpeed = 5;           // velocidad x del fotón
float ballYSpeed = 5;           // velocidad y del fotón
float ballU;                    // enviar la pelota hacia arriba
float ballD;                    // enviar la pelota hacia abajo
float ballL;                    // enviar la pelota hacia la izquierda
float ballR;                    // enviar la pelota hacia la derecha
float ay;                       // ángulo de incidencia
float aic;                      // ángulo de incidencia con la horizontal
float ar;                       // ángulo de refracción
float arco;                     // ángulo de refracción con la horizontal
float n;                        // índice de refracción
float nold;                     // índice de refracción antiguo
float paddleY = 440;            // posición y de la barra
float paddleX = width/2;        // posición x de la barra
float paddleWidth = 96;         // anchura de la barra
float paddleHeight = 16;        // altura de la barra
int blockWidth = 32;            // anchura de los bloques
int blockHeight = 16;           // altura de los bloques

int score = 3;                  // puntuación
int gameState = 0;              // estado del juego
int column = 16;                // número de columnas
int row = 6;                    // número de filas

ArrayList<Block> blocks;        // lista que contiene un número variable de bloques 

/*
 * Función setup().
 * 
 * Esta función es llamada una sola vez cuando el programa inicia.
 */
void setup() {
 
  // Definimos el tamaño de la pantalla y sus características.
  size(640, 480);
  rectMode(CENTER);
  ellipseMode(CENTER);
  textSize(40);
  textAlign(CENTER);
  frameRate(60);
  noStroke();
  
  // Dibujamos las figuras con contornos suavizados.
  smooth();
  
  blocks = new ArrayList<Block>();
    
  // Inicializamos el juego.
  startGame();

}

/*
 * Función draw().
 * 
 * Esta función es ejecutada constantemente.
 */
void draw() {
  
  if (gameState == 0) {
    drawBackground();
    fill(255);
    text("Toca el botón izquierdo del\nratón para empezar", width/2, height/2);
  }
  
  else if (gameState == 1) {
    drawBackground();
    drawBlocks();
    drawPaddle();
    drawBall();
    
    textSize(15);
    textAlign(LEFT);
    text("Vidas: " + score, 10, 470);
    textAlign(CENTER);
    textSize(40);
  }
  
  else if (gameState == 2) {
    looseGame();
  }
  
  else if (gameState == 3) {
    winGame();
  }

  checkScore();
  
}

/*
 * Función startGame().
 * 
 * Esta función inicia el juego.
 */
void startGame() {
  
  ballX = width/2+ballRadius/2; 
  ballY = height/2;
  
  for (int i = 0; i < row; i++) {
    for (int j = 0; j < column; j++) {
      blocks.add(new Block((1.2*j+1)*blockWidth, (1.4*i+1)*blockHeight, blockWidth, blockHeight));
    }
  }
  
}

/*
 * Función looseGame().
 * 
 * Esta función es ejecutada cuando se ha perdido.
 */
void looseGame() {
 
  if (score < 1) {
    text("Toco el botón izquierdo del\nratón para empezar", width/2, height/2);
  } 
  
  else {
    text("Game Over\nToca ’r’ para reiniciar", width/2, height/2);
 }
 
}

/*
 * Función winGame().
 * 
 * Esta función es ejecutada cuando se ha perdido.
 */
void winGame() {
  
  text("Felicidades\nHas ganado!", width/2, height/2);

}

/*
 * Función checkScore().
 * 
 * Esta función comprueba las vidas disponibles del jugador.
 */
void checkScore() {
  
  if (score < 0) {
    gameState = 2;
  }

}

/*
 * Función mousePressed().
 * 
 * Esta función es ejecutada cuando una el ratón es pulsado.
 */
void mousePressed() {
  
  // Iniciamos el juego.
  if (mousePressed && mouseButton == LEFT) {
    blocks.clear();
    startGame();
    score = 3;
    gameState = 1;
  }

}

/*
 * Función keyPressed().
 * 
 * Esta función es ejecutada cuando una tecla es pulsada.
 */
void keyPressed() {
  
  // Reiniciamos el juego.
  if (keyPressed && (key == 'r' || key == 'R')) {
    blocks.clear();
    startGame();
    score--;
    gameState = 1;
  }
  
  // Mostramos el nombre del autor del juego.
  if (keyPressed && (key == 'n' || key == 'N')) {
    text("Natalia Justicia Villanueva", width/2, height/2);
  }

}

/*
 * Función drawBackground().
 * 
 * Esta función dibuja el fondo de pantalla.
 */
void drawBackground() {
  
  fill(0, 10);                               
  rect(width/2, height/4, width, height/2);  
  fill(0,0,150,10);                           
  rect(width/2,3*height/4, width, height/2);
  
}

/*
 * Función drawBlocks().
 * 
 * Esta función dibuja los bloques.
 */
void drawBlocks() {

  for (Block block : blocks) {
    block.draw();
  }
  
  for (int i = blocks.size() - 1; i >= 0; i--) {
    Block block = blocks.get(i);

    if (ballX >= block.blockL - ballRadius/2
      && ballX <= block.blockR + ballRadius/2
      && ballY >= block.blockU - ballRadius/2
      && ballY <= block.blockD + ballRadius/2) {
      if ((ballX - ballXSpeed < block.blockL || ballX - ballXSpeed > block.blockR) 
        && ballY - ballYSpeed > block.blockU 
        && ballY - ballYSpeed < block.blockD) {
        ballXSpeed *= -1;
      } else {
        ballYSpeed *= -1;
      }

      blocks.remove(i);
      break;
    }
  }
  
  if (blocks.size() == 0) {
    gameState = 3;
  }

}

/*
 * Función drawPaddle().
 * 
 * Esta función dibuja la pala.
 */
void drawPaddle() {

  fill(255);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
  paddleX = constrain(mouseX, paddleWidth/2, width- paddleWidth/2);
  
  float max = paddleX + paddleWidth/2; 
  float min = paddleX - paddleWidth/2;

  if (ballY > paddleY - paddleHeight/2 && ballY < paddleY + paddleHeight/2 && ballX < max && ballX > min) {
    ballYSpeed *= -1;
  }

}

/*
 * Función drawPaddle().
 * 
 * Esta función dibuja la pelota.
 */
void drawBall() {

  fill(255);
  ellipse(ballX, ballY, ballRadius, ballRadius);
  
  // Las posiciones aumentan basadas en la velocidad.
  ballX += ballXSpeed;
  ballY += ballYSpeed;
  
  if (ballX > width || ballX < 0) {
    ballXSpeed *= -1;
  } 
  
  else if (ballY < 0) {
    ballYSpeed *= -1;
  } 
  
  else if (ballY > height) {
    gameState = 2;
  }

}
