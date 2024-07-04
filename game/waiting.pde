class Wait {
    boolean tf = false;
    Wait() {

    }

    // 特定の人数いないとゲームが始まらない
    void draw(Player player) {
        client.write("{\"room\":\""+player.roomID+"\",\"user\":\""+player.username+"\",\"userstatus\":\""+player.userstatus+"\",\"pos\":["+str(player.x)+","+str(player.y)+","+str(player.z)+","+player.angle[0]+","+m+"],\"key\":"+key_num+",\"breakblock\":["+blockstatus[0]+","+blockstatus[1]+","+blockstatus[2]+","+blockstatus[3]+"],\"avatar\":\""+avatar_data+"\"}");
        if (avatar.size() != 1) {
            background(100);
            textAlign(CENTER);
            text("ゲーム開始にはあと"+(2-avatar.size())+"人必要です。", width/2, height/6);
        }
        else {
            gamestatus++;
        }
    }
    void clientEvent(Client c) {
        
    }
}