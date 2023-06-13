import processing.net.*;
int win_width = 1200;
int win_height = 800;
float g = 1;
boolean key_list[] = new boolean[26];
boolean keycodes[] = new boolean[2];
Client client;
String room = "room1";
String user = "Staycia";
float player_all[][] = new float[2][4];
float deamon[] = new float[4];


// 当たり判定を持つ床
float collision_list[][] = {
    // 一階床
    {-2000, win_height/2, -2350, 10150, 0, 4000},

    // 一階階段右
    {win_width/2+870, win_height/2, 248, 305, 220, 355},
    {win_width/2+870, win_height/2-220, 603, 305, 0, 200},
    {win_width/2+870, win_height/2-220, 760, 305, 260, 355},

    // 一階階段左
    {win_width/2+5910, win_height/2, 248, 305, 220, 355},
    {win_width/2+5910, win_height/2-220, 603, 305, 0, 200},
    {win_width/2+5910, win_height/2-220, 760, 305, 260, 355},

    // 2階床
    {-2000, win_height/2-480, 1120, 10150, 0, 1600},
    {-2000, win_height/2-480, 180, 3460, 0, 940},
    {1775, win_height/2-480, 180, 4730, 0, 940},

    // 2階階段右
    {win_width/2+870, win_height/2-480, 1500, 305, 220, 355},
    {win_width/2+870, win_height/2-700, 1855, 305, 0, 200},
    {win_width/2+870, win_height/2-700, 2012, 305, 220, 320},

    // 2階階段左
    {win_width/2+5910, win_height/2-480, 1500, 305, 220, 355},
    {win_width/2+5910, win_height/2-700, 1855, 305, 0, 200},
    {win_width/2+5910, win_height/2-700, 2012, 305, 220, 320},

    // 2階床
    {-2000, win_height/2-920, 2332, 10150, 0, 8000},
    {-2000, win_height/2-920, 1467, 3460, 0, 865},
    {1775, win_height/2-920, 1467, 4730, 0, 865},

};

// objファイルのURL
String worldObj_URL[] = {
    "/Users/sakabekazuto/prg/Processing/game/untitled.obj"
};
// objファイルから読み込んだオブジェクトの座標と角度
float worldObj[][] = {
    {win_width/2, win_height/2, 0, 0, 0, 0}
};

// 可変長リストの作成
ArrayList <GameObject_obj> gameobject_obj = new ArrayList<>();
ArrayList <Collision> collision = new ArrayList<>();

// プレイヤークラスを宣言
Player player = new Player(win_width/2, win_height/2, 0);

// 画面サイズを変数で宣言する時はsetting関数を使わなければいけない
public void settings() {
    size(win_width, win_height, "processing.opengl.PGraphics3D");                             
}

void setup() {
    // 可変長リストに代入
    for (int i=0; i<worldObj.length; i++) {
        gameobject_obj.add(new GameObject_obj(worldObj[i][0], worldObj[i][1], worldObj[i][2], worldObj[i][3], worldObj[i][4], worldObj_URL[i]));
    }
    for (int i=0; i<collision_list.length; i++) {
        collision.add(new Collision(collision_list[i][0], collision_list[i][1], collision_list[i][2], collision_list[i][3], collision_list[i][4], collision_list[i][5]));
    }
    client = new Client(this, "127.0.0.1", 5007); 
}

void draw() {
    background(255);

    fill(0, 255, 10);
    pointLight(255, 255, 255, player.x, player.y, player.z);

    strokeWeight(1);

    player.update();

    noStroke();
    fill(0);

    for (GameObject_obj obj : gameobject_obj) {
        obj.update();
    }

    int a = 0;
    for (Collision obj : collision) {
        obj.update();
        float i = obj.bounce(player.x, player.y, player.z);
        if (i != 0) {
            player.y = i;
            a++;
        }
    }

    if (a==0) {
        player.freeFall();
    }

    if (key_list['d'-'a']==true) {
        player.x -= sin(0.5*PI+player.angle[0])*10;
        player.z -= cos(0.5*PI+player.angle[0])*10;
    }
    if (key_list['a'-'a']==true) {
            player.x += sin(0.5*PI+player.angle[0])*10;
            player.z += cos(0.5*PI+player.angle[0])*10;
    }
    if (key_list['s'-'a']==true) {
            player.x -= sin(player.angle[0])*10;
            player.z -= cos(player.angle[0])*10;
    }
    if (key_list['w'-'a']==true) {
            player.x += sin(player.angle[0])*10;
            player.z += cos(player.angle[0])*10;
    }
    if (key_list['q'-'a']==true) {
        player.angle[0] += 0.01*PI;
    }
    if (key_list['e'-'a']==true) {
        player.angle[0] -= 0.01*PI;
    }
    if (key_list['g'-'a']==true) {
        player.angle[1] += 0.01*PI;
    }
    if (key_list['f'-'a']==true) {
        player.angle[1] -= 0.01*PI;
    }
    if (keycodes[0]==true) {
        player.y -= 10;
    }
    if (keycodes[1]==true) {
        player.y += 10;
    }

    stroke(0);
    strokeWeight(0.5);
    for (int i=0; i<110; i++) {
        line(width/2+i*100-5000, height/2, -5000, width/2+i*100-5000, height/2, 5000);
        line(width/2-5000, height/2, -5000+i*100, width/2+5000, height/2, -5000+i*100);
    }

    // print(player.x);
    // print(" ");
    // print(player.y);
    // print(" ");
    // println(player.z);


    client.write(room+","+user+","+str(player.x)+","+str(player.y)+","+str(player.z)+","+player.angle[0]);
    otherplayer();
}

// キーが押されたら配列の特定の場所をTrueにする
void keyPressed() {
    if (key == ' ') {
        keycodes[0] = true;
    }
    if (keyCode == SHIFT) {
        keycodes[1] = true;
    }
    if (key-'a'>=-1 && key-'a'<26){
    key_list[key-'a'] = true;
    }
}

// キーが離されたら特定の場所をFalseにする
void keyReleased() {
    if (key == ' ') {
        keycodes[0] = false;
    }
    if (keyCode == SHIFT) {
        keycodes[1] = false;
    }
    if (key-'a'>=-1 && key-'a'<26){
        key_list[key-'a'] = false;
    }
}

// サーバーから受信したデータを座標として見る
void clientEvent(Client c) {
    String s = c.readString();
        // println(s);

    if (s!=null) {
        // 文字列データをjsonデータに書き直してプレイヤーの座標に合わせる プレイヤー側
        JSONObject jsobject = parseJSONObject(s);
        JSONObject room = jsobject.getJSONObject("room1");
        JSONArray jsarray = room.getJSONArray("player");

        for (int i=0; i<jsarray.size(); i++) {
            String name = jsarray.getString(i, "*");
            JSONArray a = room.getJSONArray(jsarray.getString(i, "*"));
            float x = a.getFloat(0);
            float y = a.getFloat(1);
            float z = a.getFloat(2);
            float angle1 = a.getFloat(3);
            player_all[i][0] = x;
            player_all[i][1] = y;
            player_all[i][2] = z;
            player_all[i][3] = angle1;
        }

        // 鬼側
        String name = room.getString("deamon");
        // println(name);
        JSONArray a = room.getJSONArray(name);

        float x = a.getFloat(0);
        println(x);
        float y = a.getFloat(1);
        float z = a.getFloat(2);
        float angle1 = a.getFloat(3);
        deamon[0] = x;
        deamon[1] = y;
        deamon[2] = z;
        deamon[3] = angle1;
    }
}

// プレイヤーのアバターを表示する
void otherplayer() {
    for (int i=0; i<player_all.length;i++) {
        pushMatrix();
        // print(player_all[i][0]);
        // print(" ");
        // print(player_all[i][1]);
        // print(" ");
        // println(player_all[i][2]);
        translate(player_all[i][0], player_all[i][1]-130, player_all[i][2]);
        fill(0, 0, 255);
        rotateY(player_all[i][3]);
        box(50);
        popMatrix();
    }

    pushMatrix();
    translate(deamon[0], deamon[1]-130, deamon[2]);
    fill(255, 0, 0);
    rotateY(deamon[3]);
    box(50);
    popMatrix();
}