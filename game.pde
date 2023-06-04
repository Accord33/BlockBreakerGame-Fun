int length = 10;
Bullet bullet[] = new Bullet[length];
int win_width = 600;
int win_height = 500;
float blocks[][] = {
    {50,100,50,win_width/2, win_height/2, -100},
    {50,100,50,win_width/2+100, win_height/2, -100},
    {50,100,50,win_width/2+200, win_height/2, -100},
    {50,100,50,win_width/2-100, win_height/2, -100},
    };

ArrayList <GameObject> gameobject = new ArrayList<>();
int num = 0;
float front = 15;
float camera_angle[] = {0, 0};
//float pos[] = {win_width/2, win_height/2,0};
float pos[] = {win_width/2, win_height/2, 200};

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
    stroke(0);
    line(width/2-10, height/2, width/2+10, height/2);
    line(width/2, height/2-10, width/2, height/2+10);

    pushMatrix();

    camera(pos[0], pos[1], pos[2],
        pos[0], pos[1], 0,
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
            pos[0] += 10;
        }
        if (key == 'a') {
            pos[0] -= 10;
        }
        if (key == 's') {
            pos[2] += 10;
        }
        if (key == 'w') {
            pos[2] -= 10;
        }
    }
    hitObject();
}

void hitObject() {
    for (int i=0; i<gameobject.size(); i++) {
        for (int j=0; j<bullet.length; j++) {
            if (bullet[j] != null) {
                if (abs(gameobject.get(i).x - bullet[j].x) < gameobject.get(i)._depth/2) {
                    gameobject.remove(i);
                }
            }
        }
    }
}

void mousePressed() {
    bullet[num] = new Bullet(pos[0], pos[1], pos[2]-100,0,0,5);
    num = (num+1)%length;
}

void keyReleased() {
    key = 'q';
}