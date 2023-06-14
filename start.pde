class Start {
    Start() {}

    void draw() {
        background(0);
        textSize(100);
        textAlign(CENTER);
        text("Let's Play Game", win_width/2, win_height/2);

        textSize(50);
        textAlign(LEFT);
        text("Press Enter to Start", win_width/2, win_height*2/3);
    }
}