int length = 10;
Bullet bullet[] = new Bullet[length];
int win_width = 600;
int win_height = 500;
float blocks[][] = {
    {50,100,50,win_width/2, win_height/2, -100},
    {50,100,50,win_width/2+100, win_height/2, -200},
    {50,100,50,win_width/2+200, win_height/2, 0},
    {50,100,50,win_width/2-100, win_height/2, -100},
    };

ArrayList <GameObject> gameobject = new ArrayList<>();
int num = 0;
float front = 15;
Player player_data = new Player(win_width/2, win_height/2, 0);

void setup() {
    size(600, 500, P3D);
    for (int i=0; i<blocks.length;i++) {
        gameobject.add(new GameObject(blocks[i][0],blocks[i][1],blocks[i][2],blocks[i][3],blocks[i][4],blocks[i][5]));
    }
    Bullet test = new Bullet(0, 0, 0, 0, 0, 0);
    println(test.x);
}

void draw() {
    background(255);


    pushMatrix();
    camera(player_data.x, player_data.y, player_data.z,
        sin(player_data.direction[0])+player_data.x, player_data.y, 0,
        0, 1, 0);


    fill(0, 255, 10);

    for (GameObject obj : gameobject) {
        obj.update();
    }

    noStroke();
    fill(0);

    for (int i=0; i < length; i++) {
       if (bullet[i] != null) {
            bullet[i].update();
        }
    }
    popMatrix();

    if (keyPressed) {
        if (key=='d') {
            player_data.x += 10;
        }
        if (key == 'a') {
            player_data.x -= 10;
        }
        if (key == 's') {
            player_data.z += 10;
        }
        if (key == 'w') {
            player_data.z -= 10;
        }
        if (key == 'q') {
            player_data.direction[0] += (1/6)*PI;
        }
        if (key == 'e') {
            player_data.direction[0] -= (1/6)*PI;
        }

    }
    hitObject();

    stroke(0);
    line(width/2-10, height/2, width/2+10, height/2);
    line(width/2, height/2-10, width/2, height/2+10);
}

void hitObject() {
    for (int i=0; i<gameobject.size(); i++) {
        for (int j=0; j<bullet.length; j++) {
            if (bullet[j] != null) {
                if (abs(gameobject.get(i).x - bullet[j].x) < gameobject.get(i)._width/2) {
                    if (abs(gameobject.get(i).y - bullet[j].y) < gameobject.get(i)._height/2) {
                        if (abs(gameobject.get(i).z - bullet[j].z) < gameobject.get(i)._depth/2) {
                            gameobject.remove(i);
                        }
                     }
                }
            }
        }
    }
}

void mousePressed() {
    bullet[num] = new Bullet(player_data.x, player_data.y, player_data.z,0,0,10);
    num = (num+1)%length;
}

void keyReleased() {
    key = 't';
}