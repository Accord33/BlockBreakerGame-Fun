class Wait {
    Wait() {}

    void update() {
        println(avatar.size());
        client.write("{\"room\":\""+roomID+"\",\"user\":\""+user+"\",\"userstatus\":\""+userstatus+"\",\"pos\":["+str(player.x)+","+str(player.y)+","+str(player.z)+","+player.angle[0]+"],\"key\":"+key_num+",\"breakblock\":["+blockstatus[0]+","+blockstatus[1]+","+blockstatus[2]+","+blockstatus[3]+"],\"avatar\":\""+avatar_data+"\"}");
        if (avatar.size() != 2) {
            background(100);
            textAlign(CENTER);
            text("ゲーム開始にはあと"+(2-avatar.size())+"人必要です。", width/2, height/2);
        }
        else {
            gamestatus++;
        }
    }
}