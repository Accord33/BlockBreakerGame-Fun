class Home {
    String room = "";
    int counter = 0;
    int focus = 0;
    Home(){}

    void draw() {
        background(255, 150, 0);
        
        fill(255);
        textAlign(CENTER);
        text("Room名", width/4, height/4, 0);

        rect(width/4*2, height/4-60, 500, 80);

        // 敵キャラクター選択
        rect(width/10, height/4*2, width/10, width/10);

        // プレイヤーキャラクター選択
        


        textAlign(LEFT);
        fill(0);
        text(room, width*2/4+20, height/4, 0);

        counter = (counter+1)%20;
    }
    void keyPressed() {
        if (key == CODED) {
        }

        // テキストエリアにフォーカスが当たっている時、文字入力を受け付ける
        if (focus == 1){
            if (key == DELETE) {
                if (room != ""){
                    room = room.substring(0, room.length()-1);
                }
            }
            else if (key == BACKSPACE) {
                if (room != ""){
                    room = room.substring(0, room.length()-1);
                }
            }
            else {
                room += key;
            }
        }
    }
    void mousePressed() {
        if (width/4*2 < mouseX && mouseX < width/4*2+500) {
            if (height/4-60 < mouseY && mouseY < height/4-60+80) {
                focus = 1;
            }
            else {
                focus = 0;
            }
        }
    }
}