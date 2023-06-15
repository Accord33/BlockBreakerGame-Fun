import processing.net.*;

int win_width = 1200;
int win_height = 800;
boolean key_list[] = new boolean[26];
boolean keycodes[] = new boolean[2];
Client client;
String roomID = "room3";
String user = "ayuyu";
String userstatus = "player";
float player_all[][] = new float[2][4];
float deamon[] = new float[4];
int gamestatus = 2;
Start start = new Start();
Home home = new Home();
EndGame end = new EndGame();
String IP = "10.124.49.230";
int PORT = 5007;
UI ui = new UI();

// 破壊可能ブロック座標
float breakblock[][][] = {{
    {200, 270, -500},
    {-1682,-210,2726},
    {3575,-210,648},
    {4428,-650,5568}
}};

// 破壊メーター
float breakmeter = 0;
// 破壊スピード
float breakspeed = 1;
// 鍵の数
int key_num = 0;
// 鍵のステータスリスト
int blockstatus[] = new int[4];
// 鍵の場所リスト
int blockplace = 0;
// 移動速度
int move_speed = 10;


// 当たり判定を持つ床
float collision_list[][] = {
    // 一階床
    {-2000, 400, -2350, 10150, 0, 4000},

    // 一階階段右
    {600+870, 400, 248, 305, 220, 355},
    {600+870, 400-220, 603, 305, 0, 200},
    {600+870, 400-220, 760, 305, 260, 355},

    // 一階階段左
    {600+5910, 400, 248, 305, 220, 355},
    {600+5910, 400-220, 603, 305, 0, 200},
    {600+5910, 400-220, 760, 305, 260, 355},

    // 2階床
    {-2000, 400-480, 1120, 10150, 0, 1750},
    {-2000, 400-480, 180, 3460, 0, 940},
    {1775, 400-480, 180, 4730, 0, 940},

    // 2階階段右
    {600+870, 400-480, 1500, 305, 220, 355},
    {600+870, 400-700, 1855, 305, 0, 200},
    {600+870, 400-700, 2012, 305, 220, 320},

    // 2階階段左
    {600+5910, 400-480, 1500, 305, 220, 355},
    {600+5910, 400-700, 1855, 305, 0, 200},
    {600+5910, 400-700, 2012, 305, 220, 320},

    // 3階床
    {-2000, 400-920, 2332, 10150, 0, 8000},
    {-2000, 400-920, 1467, 3460, 0, 865},
    {1775, 400-920, 1467, 4730, 0, 865},

};

// 壁
float wallcollision_list[][] = {
    {-2000, 400, -2350, 10150, 10, 10},
    {-1920, 400, -2350, 10, 10, 4000},

    {-1810, 400, 250, 2420, 10, 1130},
    {770, 400, 250, 700, 470, 1130},

    {-2000, -80, 190, 10000, 10, 10}
};

// ゴール座標
float goal[] = {7947, -520.0, 5830, 250, 200, 250};

// objファイルのURL
String worldObj_URL[] = {
    "./untitled.obj"
};
// objファイルから読み込んだオブジェクトの座標と角度
float worldObj[][] = {
    {600, 400, 0, 0, 0, 0}
};

// 可変長リストの作成
ArrayList <GameObject_obj> gameobject_obj = new ArrayList<>();
ArrayList <Collision> collision = new ArrayList<>();
ArrayList <AreaCollision> wallcollition = new ArrayList<>();

// ゴールエリアの生成
AreaCollision goalarea = new AreaCollision(goal[0],goal[1],goal[2],goal[3],goal[4],goal[5]);

// プレイヤークラスを宣言
Player player = new Player(600, 400, 0);

// 使う文字のUnicode ID
int charactor[] = {'a'-'a','s'-'a','w'-'a','d'-'a'};

// 画面サイズを変数で宣言する時はsetting関数を使わなければいけない
public void settings() {
    size(win_width, win_height, "processing.opengl.PGraphics3D");                             
}

void setup() {
    // 画面サイズ変更可
    surface.setResizable( true );
    // 可変長リストに代入
    for (int i=0; i<worldObj.length; i++) {
        gameobject_obj.add(new GameObject_obj(worldObj[i][0], worldObj[i][1], worldObj[i][2], worldObj[i][3], worldObj[i][4], worldObj_URL[i]));
    }
    for (int i=0; i<collision_list.length; i++) {
        collision.add(new Collision(collision_list[i][0], collision_list[i][1], collision_list[i][2], collision_list[i][3], collision_list[i][4], collision_list[i][5]));
    }
    for (int i=0; i<wallcollision_list.length;i++) {
        wallcollition.add(new AreaCollision(wallcollision_list[i][0], wallcollision_list[i][1], wallcollision_list[i][2], wallcollision_list[i][3], wallcollision_list[i][4], wallcollision_list[i][5]));
    }
    client = new Client(this, IP, PORT);
    PFont font = createFont("Meiryo", 50);
    textFont(font);
}

void draw() {
    switch (gamestatus) {
        case 0:
            start.draw();
            break;
        case 1:
            home.draw();
            break;
        case 2:
            update();
            break;
        case 3:
            end.draw();
            break;
    }
}

void update() {

    background(255);

    fill(0, 255, 10);
    pointLight(255, 255, 255, player.x, player.y, player.z);

    strokeWeight(1);

    player.update();

    noStroke();
    fill(0);

    // ワールド描画
    for (GameObject_obj obj : gameobject_obj) {
        obj.update();
    }

    // 1にすると重力がなくなる
    int a =0;

    // 床の当たり判定を生成
    for (Collision obj : collision) {
        obj.update();
        float i = obj.bounce(player.x, player.y, player.z);
        if (i != 0) {
            player.y = i;
            a++;
        }
    }

    goalarea.update();
    if (key_num == 4) {
        if (goalarea.hit(player.x, player.y, player.z)) {
            println("脱出しました！！！");
            gamestatus++;
        }
    }

    // キー入力にあたる移動
    move();

    // 壁の当たり判定
    for (AreaCollision obj : wallcollition) {
        obj.update();
        if (obj.hit(player.x, player.y, player.z)) {
            for (int i=0;i<charactor.length;i++) {
                key_list[charactor[i]] = !key_list[charactor[i]];
            }
            while (obj.hit(player.x, player.y, player.z)) {
                move();
            }
            for (int i=0;i<charactor.length;i++) {
                key_list[charactor[i]] = !key_list[charactor[i]];
            }
        }
    }

    // 破壊可能ブロックの生成
    stroke(0,255,255);
    for (int i=0; i<breakblock[blockplace].length;i++) {
        if (blockstatus[i] == 1){
            breakblock[blockplace][i][1] = 1000;
        }
        createBreakBlock(breakblock[blockplace][i][0],breakblock[blockplace][i][1],breakblock[blockplace][i][2]);

        // SPACEキーを押している間に破壊　ただし一度でも動くと最初から
        if (dist(breakblock[blockplace][i][0],breakblock[blockplace][i][1],breakblock[blockplace][i][2],player.x,player.y,player.z) < 300) {
            // println("めっちゃ近いよ！！！");
            if (keycodes[0]==true) {
                breakmeter += breakspeed;
                println(breakmeter);
            }
            if (breakmeter >= 300) {
                key_num++;
                println(key_num+"本目の鍵を取得しました！！！");
                breakmeter = 0;
                blockstatus[i] = 1;
            }
        }
    }

    if (a==0) {
        player.freeFall();
    }


    // stroke(0);
    // strokeWeight(0.5);
    // for (int i=0; i<110; i++) {
    //     line(width/2+i*100-5000, height/2, -5000, width/2+i*100-5000, height/2, 5000);
    //     line(width/2-5000, height/2, -5000+i*100, width/2+5000, height/2, -5000+i*100);
    // }

    // print(player.x);
    // print(" ");
    // print(player.y);
    // print(" ");
    // println(player.z);

    // データをサーバーに送信
    // 送信するデータをjsonにしたい...
    // client.write(room+","+user+","+userstatus+","+str(player.x)+","+str(player.y)+","+str(player.z)+","+player.angle[0]+","+key_num);
    client.write("{\"room\":\""+roomID+"\",\"user\":\""+user+"\",\"userstatus\":\""+userstatus+"\",\"pos\":["+str(player.x)+","+str(player.y)+","+str(player.z)+","+player.angle[0]+"],\"key\":"+key_num+",\"breakblock\":["+blockstatus[0]+","+blockstatus[1]+","+blockstatus[2]+","+blockstatus[3]+"]}");
    
    // プレイヤーを描画
    otherplayer();

    ui.update(player.x,player.y,player.z,player.angle[0]);
}

void move() {
    // 入力されているキーを移動量に変換
    if (key_list['d'-'a']==true) {
        player.x -= sin(0.5*PI+player.angle[0])*move_speed;
        player.z -= cos(0.5*PI+player.angle[0])*move_speed;
        breakmeter = 0;

    }
    if (key_list['a'-'a']==true) {
        player.x += sin(0.5*PI+player.angle[0])*move_speed;
        player.z += cos(0.5*PI+player.angle[0])*move_speed;
        breakmeter = 0;

    }
    if (key_list['s'-'a']==true) {
        player.x -= sin(player.angle[0])*move_speed;
        player.z -= cos(player.angle[0])*move_speed;
        breakmeter = 0;
    }
    if (key_list['w'-'a']==true) {
        player.x += sin(player.angle[0])*move_speed;
        player.z += cos(player.angle[0])*move_speed;
        breakmeter = 0;
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
}

// キーが押されたら配列の特定の場所をTrueにする
void keyPressed() {
    switch (gamestatus) {
        case 0:
            if (keyCode == ENTER) {
                gamestatus++;
            }
            break;	
        case 1:
            home.keyPressed();
            break;
        case 2:
            if (key == ' ') {
                keycodes[0] = true;
            }
            if (keyCode == SHIFT) {
                keycodes[1] = true;
            }
            if (key-'a'>=-1 && key-'a'<26){
                key_list[key-'a'] = true;
            }
            break;
    }
}

// キーが離されたら特定の場所をFalseにする
void keyReleased() {
    switch (gamestatus) {
        case 2:
            if (key == ' ') {
                keycodes[0] = false;
            }
            if (keyCode == SHIFT) {
                keycodes[1] = false;
            }
            if (key-'a'>=-1 && key-'a'<26){
                key_list[key-'a'] = false;
            }
            break;
    }
}

void mousePressed() {
    switch (gamestatus) {
        case 1:
            home.mousePressed();
    }
}

// サーバーから受信したデータを座標として見る
void clientEvent(Client c) {
    String s = c.readString();

    if (s!=null) {
        // 文字列データをjsonデータに書き直してプレイヤーの座標に合わせる プレイヤー側
        JSONObject room = parseJSONObject(s);
        // JSONObject room = jsobject.getJSONObject(roomID);
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
        
            // print(x);
            // print(" ");
            // print(y);
            // print(" ");
            // println(z);
        }

        // 鬼側
        String name = room.getString("deamon");
        // println(name);
        if (name != "") {
        JSONArray a = room.getJSONArray(name);

        float x = a.getFloat(0);
        float y = a.getFloat(1);
        float z = a.getFloat(2);
        float angle1 = a.getFloat(3);
        deamon[0] = x;
        deamon[1] = y;
        deamon[2] = z;
        deamon[3] = angle1;
        }
        // 鍵の数
        key_num = room.getInt("key");
        // 壊したブロックの同期
        JSONArray blockstatus_list = room.getJSONArray("breakblock");
        for (int i=0;i<4;i++) {
            blockstatus[i] = blockstatus_list.getInt(i);
        }
        blockplace = room.getInt("worldID");

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