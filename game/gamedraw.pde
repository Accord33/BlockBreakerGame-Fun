
// 破壊可能ブロック座標
float breakblock[][][] = {
    {
        { - 1086,300.0, -141} ,
        { - 1430, -620,2048} ,
        { - 4136, -620.0,5558} ,
        { - 5325, -620,3948}
    }
};


// 当たり判定を持つ床
float collision_list[][] = {
    // 一階床
    { - 7018,400, -2345, 10200,0,3932} ,
    
    // 一階階段1
    { - 574,400,254, 305,220,365} ,
    { - 574,180,619, 305,0,150} ,
    { - 574,180,769, 305,260,345} ,
    
    // 一階階段2
    { - 5613,400,254, 305,220,365} ,
    { - 5613,180,619, 305,0,150} ,
    { - 5613,180,769, 305,260,345} ,
    
    // 2階床1
    { - 5325, -80, 175, 4751, 0, 939} ,
    { - 269, -80, 175, 3500, 0, 939} ,
    { - 5613, -80, 1114, 8800, 0, 1735} ,
    
    // 2階階段1
    { - 574, -80,1507, 305,220,365} ,
    { - 574, -300,1872, 305,0,150} ,
    { - 574, -300,2022, 305,220,305} ,
    
    // 2階階段2
    { - 5613, -80,1507, 305,220,365} ,
    { - 5613, -300,1872, 305,0,150} ,
    { - 5613, -300,2022, 305,220,305} ,
    
    // 3階床1
    { - 5325, -520, 1450, 4752, 0, 900} ,
    { - 269, -520, 1450, 3500, 0, 900} ,
    { - 7018, -520, 2327, 10200, 0, 8260} ,
    
    
    
};

// 壁
float wallcollision_list[][] = {
    { - 5613, 400, -2345, 10200, 10, 10} ,
    { - 7018, 400, -2345, 1415, 930, 7730} ,
    { - 5613, 400, 3932, 10200, 10, 10} ,
    
    { - 265, 400, 254, 695, 480, 1100}
    
};

// ゴール座標
float goal[] = { - 6977, -520,5847, 250, 200, 250};

// objファイルのURL
String worldObj_URL[] = {
    "../model/FUN/fun1.obj"
    
};
// objファイルから読み込んだオブジェクトの座標と角度
float worldObj[][] = {
    {600, 400, 0, 0, 0, 0}
};

// 可変長リストの作成
ArrayList <GameObject_obj> gameobject_obj = new ArrayList<>();
ArrayList <Collision> collision = new ArrayList<>();
ArrayList <AreaCollision> wallcollition = new ArrayList<>();
// ArrayList <Avatar_obj> avatar = new ArrayList<>();

// ゴールエリアの生成
AreaCollision goalarea = new AreaCollision(goal[0],goal[1],goal[2],goal[3],goal[4],goal[5]);


class Gamedraw {
    int num = 0;
    
    Gamedraw() {
        // ゲームに必要なデータの読み込み
        // ワールドを読み込み
        for (int i = 0; i < worldObj.length; i++) {
            gameobject_obj.add(new GameObject_obj(worldObj[i][0], worldObj[i][1], worldObj[i][2], worldObj[i][3], worldObj[i][4], worldObj_URL[i]));
        }
        // 床の当たり判定の読み込み
        for (int i = 0; i < collision_list.length; i++) {
            collision.add(new Collision(collision_list[i][0], collision_list[i][1], collision_list[i][2], collision_list[i][3], collision_list[i][4], collision_list[i][5]));
        }
        // 壁の当たり判定の読み込み
        for (int i = 0; i < wallcollision_list.length;i++) {
            wallcollition.add(new AreaCollision(wallcollision_list[i][0], wallcollision_list[i][1], wallcollision_list[i][2], wallcollision_list[i][3], wallcollision_list[i][4], wallcollision_list[i][5]));
        }
    }
    void draw() {
        background(255);
        
        fill(0, 255, 10);
        if (num > 0) {
            pointLight(255, 255, 255, player.x, player.y, player.z);
            num++;
            if (num > 120) {
                num = 0;
            }
        }
        else{
            pointLight(200, 200, 200, player.x, player.y, player.z);
        }
        
        
        strokeWeight(1);
        
        noStroke();
        fill(0);
        
        // ワールド描画
        for (GameObject_obj obj : gameobject_obj) {
            obj.update();
        }
        
        // 1にすると重力がなくなる
        int a = 1;
        
        // 床の当たり判定を生成
        for (Collision obj : collision) {
            obj.update();
            float i = obj.bounce(player.x, player.y, player.z);
            if (i != 0) {
                player.y = i;
                a++;
            }
        }

        if (a ==  0) {
            player.freeFall();
        }
    }
    void clientEvent(Client c) {
        
    }
}