class EndGame {
    EndGame() {
    }

    // ゲームが終了した時の処理
    void draw() {
        background(0);
        textSize(100);
        textAlign(CENTER);
        resetMatrix();
        fun.resize(width, height);
        image(fun, 0, 0);
        fill(255,255,255);
        text("脱出した！！", 0, 0, -500);
    }
}