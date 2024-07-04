class Wait {
    boolean tf = false;
    int playerNum = 0;
    Wait() {

    }

    // 特定の人数いないとゲームが始まらない
    void draw(Player player) {
        // client.write("{\"room\":\""+player.roomID+"\",\"user\":\""+player.username+"\",\"userstatus\":\""+player.userstatus+"\",\"pos\":["+str(player.x)+","+str(player.y)+","+str(player.z)+","+player.angle[0]+","+m+"],\"key\":"+key_num+",\"breakblock\":["+blockstatus[0]+","+blockstatus[1]+","+blockstatus[2]+","+blockstatus[3]+"],\"avatar\":\""+avatar_data+"\"}");
        // if (avatar.size() != 1) {
        //     background(100);
        //     textAlign(CENTER);
        //     text("ゲーム開始にはあと"+(2-avatar.size())+"人必要です。", width/2, height/6);
        // }
        // else {
        //     gamestatus++;
        // }
        // client.write("{'statys':'wait','username':'"+player.username+"','roomID':'"+player.roomID+"','userstatus':'"+player.userstatus+"','avatar':'"+player.avatar+"'}");

        if (this.playerNum == 2) {
            gamestatus++;
        }
        else {
            // client.write('{"status":"wait","userbame":"'+player.username+'","roomID":"'+player.roomID+'","userstatus":"'+player.userstatus+'","avatar":"'+player.avatar+'"}');
            client.write("{\"status\":\"wait\",\"username\":\""+player.username+"\",\"roomID\":\""+player.roomID+"\",\"userstatus\":\""+player.userstatus+"\",\"avatar\":\""+player.avatar+"\"}");
            background(100);
            textAlign(CENTER);
            text("人数が足りません。"+this.playerNum, width/2, height/6);
        }

    }
    void clientEvent(Client c) {
        String s = null;
        if (c!=null) {
            byte[] b = c.readBytes();
            s = new String(b, StandardCharsets.UTF_8);
            println(s);
        }

        if (s != null) {
            JSONObject json = JSONObject.parse(s);
            if (json.get("player_num") != null) {
                this.playerNum = json.getInt("player_num");
            }
        }
    }
}