class Badend {
    Badend() {}

    void draw() {
        background(0);
        textSize(100);
        textAlign(CENTER);
        resetMatrix();
        fill(255,255,255);
        text("脱出失敗...", 0, 0, -500);
    }
}