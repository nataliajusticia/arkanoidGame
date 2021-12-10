/*
 * Práctica final.
 * Fundamentos físicos de la multimedia.
 * Natalia Justicia Villanueva
 * 
 * Videojuego 'Arkanoid' donde el objetivo es 
 * eliminar unos bloques, haciendo chocar contra ellos 
 * una bola impulsada por una barra.
 */

/*
 * LEYES DE LA FÍSICA EMPLEADAS EN LA PRÁCTICA
 *
 * 1. Choques entre partículas con el Movimiento Rectilíneo Uniforme (MRU).
 * 2. Refracción del fotón al pasar de un medio material a otro.
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
float paddleY = 450;            // posición y de la barra
float paddleX = width/2;        // posición x de la barra
float paddleWidth = 96;         // anchura de la barra
float paddleHeight = 16;        // altura de la barra
int blockWidth = 32;            // anchura de los bloques
int blockHeight = 16;           // altura de los bloques

int lifes = 3;                  // vidas
int score = 0;                  // puntuación
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
  
  // El juego todavía no ha empezado.
  if (gameState == 0) {
    drawBackground();
    fill(255);
    text("Toca el botón izquierdo del\nratón para empezar", width/2, height/2);
  }
  
  // El juego ha empezado.
  else if (gameState == 1) {
    drawBackground();
    drawBlocks();
    drawPaddle();
    drawBall();
    
    textSize(15);
    textAlign(LEFT);
    text("Vidas: " + lifes, 10, 470);
    text("Puntos: " + score, 80, 470);
    textAlign(CENTER);
    textSize(40);
  }
  
  // El jugador ha perdido todas sus vidas.
  else if (gameState == 2) {
    looseGame();
  }
  
  // El jugador ha ganado y eliminado todos los bloques.
  else if (gameState == 3) {
    winGame();
  }

  // Comprobamos la puntuación del jugador y el número de bloques.
  checkGameState();
  
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
 
  if (lifes < 1) {
    text("Toco el botón izquierdo del\nratón para empezar", width/2, height/2);
  } 
  
  else {
    text("Game Over\nToca 'r' para reiniciar", width/2, height/2);
 }
 
}

/*
 * Función winGame().
 * 
 * Esta función es ejecutada cuando se ha ganado.
 */
void winGame() {
  
  text("Felicidades\nHas ganado!", width/2, height/2);

}

/*
 * Función checkGameState().
 * 
 * Esta función comprueba el estado del juego.
 */
void checkGameState() {
  
  // Si el jugador no tiene vidas, ha perdido.
  if (lifes < 0) {
    gameState = 2;
  }

  // Si no quedan bloques, el jugador ha ganado.
  if (blocks.size() == 0) {
    gameState = 3;
  }

}

/*
 * Función mousePressed().
 * 
 * Esta función es ejecutada cuando el ratón es pulsado.
 */
void mousePressed() {
  
  // Iniciamos el juego.
  if (mousePressed && mouseButton == LEFT) {
    blocks.clear();
    startGame();
    lifes = 3;
    score = 0;
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
    lifes--;
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
 * Esta función dibuja el fondo de la pantalla.
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

    if (ballX >= block.blockL - ballRadius/2 && ballX <= block.blockR + ballRadius/2 && ballY >= block.blockU - ballRadius/2 && ballY <= block.blockD + ballRadius/2) {
      if ((ballX - ballXSpeed < block.blockL || ballX - ballXSpeed > block.blockR) && ballY - ballYSpeed > block.blockU && ballY - ballYSpeed < block.blockD) {
        ballXSpeed *= -1;
        
        score++;
      } 
      
      else {
        ballYSpeed *= -1;
        
        score++;
      }

      blocks.remove(i);
      break;
    }
  }

}

/*
 * Función drawPaddle().
 * 
 * Esta función dibuja la pala.
 * 
 * TODO: Al rebotar con las esquinas la pelota realizará otro efecto.
 */
void drawPaddle() {

  fill(255);
  rect(paddleX, paddleY, paddleWidth, paddleHeight);
  paddleX = constrain(mouseX, paddleWidth/2, width-paddleWidth/2);

  if ((ballX > paddleX - paddleWidth/2) && (ballX < paddleX + paddleWidth/2) && (ballY > paddleY - paddleHeight/2) && (ballY < paddleY)) {
    ballYSpeed *= -1;
  }

}

/*
 * Función drawPaddle().
 * 
 * Esta función dibuja la pelota y controla su movimiento.
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
