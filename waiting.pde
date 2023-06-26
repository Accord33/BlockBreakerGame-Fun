class Wait {
    boolean tf = false;
    Wait() {}

    // 特定の人数いないとゲームが始まらない
    void update() {
        int m = 0;
        if (keyPressed) m = 1;
        client.write("{\"room\":\""+roomID+"\",\"user\":\""+user+"\",\"userstatus\":\""+userstatus+"\",\"pos\":["+str(player.x)+","+str(player.y)+","+str(player.z)+","+player.angle[0]+","+m+"],\"key\":"+key_num+",\"breakblock\":["+blockstatus[0]+","+blockstatus[1]+","+blockstatus[2]+","+blockstatus[3]+"],\"avatar\":\""+avatar_data+"\"}");
        if (avatar.size() < 2) {
            background(100);
            textAlign(CENTER);
            text("ゲーム開始にはあと"+(2-avatar.size())+"人必要です。", width/2, height/6);
        }
        else {
            // fill(255);
            // pushMatrix();
            // translate(width/6*3, height/3, 0);
            // box(width/6, height/3, 0);
            // popMatrix();
            gamestatus++;
        }
        // if (!(tf)) {
        //     for (int i=0; i<player_all.length;i++) {
        //         if (!(i >= avatar.size())) {
        //             avatar.get(i).update(width/6*(i+2), height/2, 0, PI, 0);
        //         }
        //     }
        //     ikabo.update(width/3, height/2, 0, PI);
        // }
    }
}