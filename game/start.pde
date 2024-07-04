class Start {
    PImage start_img;

    Start() {
        this.start_img = loadImage("../pic/start.png");
    }
    // スタート画面
    void draw() {
        background(0);
        this.start_img.resize(width, height);
        image(this.start_img, 0, 0);

        textSize(50);
        textAlign(LEFT);
        text("Press Enter to Start", win_width/2, win_height*2/3);
    }
    void keyPressed() {
        if (key == ENTER) {
            gamestatus++;
        }
    }
}