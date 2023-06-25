class Start {
    Start() {
    }
    // スタート画面
    void draw() {
        background(0);
        img.resize(width, height);
        image(img, 0, 0);

        textSize(50);
        textAlign(LEFT);
        text("Press Enter to Start", win_width/2, win_height*2/3);
    }
}