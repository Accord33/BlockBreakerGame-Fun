class Home {
    
    // ルーム名、ユーザー名、キャラクターの選択
    String input[] = {"","",""};
    int counter = 0;
    int focus = 0;
    String userstatus = "";
    String roomID = "";
    String user = "";
    
    Home() {}
    
    void draw() {
        background(255, 150, 0);
        
        fill(255);
        textAlign(CENTER);
        text("Room名", width / 4, height / 5, 0);
        rect(width / 4 * 2, height / 5 - 60, 500, 80);
        text("プレイヤー名", width / 4, height / 5 * 2, 0);
        rect(width / 4 * 2, height / 5 * 2 - 60, 500, 80);
        
        text("キャラクター選択", width / 2, height / 11 * 6);
        
        // 敵キャラクター選択
        fill(255, 0, 0);
        rect(width / 15 * 2, height / 5 * 3, width / 15, width / 15);
        
        // プレイヤーキャラクター選択
        fill(0, 0, 255);
        rect(width / 15 * 9, height / 5 * 3, width / 15, width / 15);
        
        fill(255);
        rect(width / 5 * 2, height / 5 * 4, width / 5, 80);
        fill(0);
        text("挑戦",width / 2, height / 5 * 4 + 60);
        
        
        textAlign(LEFT);
        fill(0);
        text(input[1], width * 2 / 4 + 20, height / 5, 0);
        text(input[2], width * 2 / 4 + 20, height / 5 * 2, 0);
        
        counter = (counter + 1) % 20;
    }
    void keyPressed() {
        if (key == CODED) {
        }
        
        // テキストエリアにフォーカスが当たっている時、文字入力を受け付ける
        if (focus == 1 || focus == 2) {
            if (key == DELETE) {
                if (input[focus] != "") {
                    input[focus] = input[focus].substring(0, input[focus].length() - 1);
                }
            }
            else if (key == BACKSPACE) {
                if (input[focus] != "") {
                    input[focus] = input[focus].substring(0, input[focus].length() - 1);
                }
            }
            else {
                input[focus] += key;
            }
        }
    }
    // クリック座標を取得してボタンの処理
    void mousePressed() {
        if (width / 4 * 2 < mouseX && mouseX < width / 4 * 2 + 500) {
            // 上のインプットの枠を選択
            if (height / 5 - 60 < mouseY && mouseY < height / 5 - 60 + 80) {
                focus = 1;
            }
            // 下のインプットの枠を選択
            else if (height / 5 * 2 - 60 < mouseY && mouseY < height / 5 * 2 - 60 + 80) {
                focus = 2;
            }
            // 選択を外す
            else {
                focus = 0;
            }
        }
        if (height / 5 * 3 < mouseY && mouseY < height / 5 * 3 + width / 15) {
            // プレイヤーかデーモンかの選択
            if (width / 15 * 2 < mouseX && mouseX < width / 15 * 3) {
                println("deamon");
                userstatus = "deamon";
                // move_speed = 10;
            }
            else if (width / 15 * 9 < mouseX && mouseX < width / 15 * 10) {
                println("player");
                userstatus = "player";
                // move_speed = 6;
            }
        }

        // rect(width / 5 * 2, height / 5 * 4, width / 5, 80);

        if (width / 5 * 2 < mouseX && mouseX < width / 5 * 3) {
            if (height / 5 * 4 < mouseY && mouseY < height / 5 * 4 + 80) {
                roomID = input[1];
                user = input[2];
                player.roomID = this.roomID;
                player.username = this.user;
                player.userstatus = this.userstatus;
                gamestatus++;
            }
        }
    }
}

void clientEvent(Client c) {
    switch gamestatus {
        case 3:
            wait.clientEvent(c);
            break;
        case 3:
            gamedraw.clientEvent(c);
            break;
    }
}