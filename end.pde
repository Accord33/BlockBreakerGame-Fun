class EndGame {
    EndGame() {}

    void draw() {
        background(0);
        textSize(100);
        textAlign(CENTER);
        resetMatrix();
        fill(255,255,255);
        text("Game Clear", 0, 0, -500);
    }
}