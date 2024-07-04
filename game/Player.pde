class Player {
    float x, y, z, v, hp;
    float angle[] = {160, 0};
    String username;
    String roomID;
    String userstatus;
    int move_speed;
    // プレイヤー操作系
    boolean key_list[] = new boolean[26];
    boolean keycodes[] = new boolean[3];
    // プレイヤーアバター
    Avatar_obj avatar;
    // frame
    int frame = 0;
    boolean isMoving = true;
    
    Player(float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.angle = angle;
        this.v = 0;
        this.hp = 100;
    }
    void setting(String roomID, String username, String userstatus, int move_speed, String uri) {
        this.roomID = roomID;
        this.username = username;
        this.userstatus = userstatus;
        this.move_speed = move_speed;
        this.avatar = new Avatar_obj(uri);
    }
    void draw() {
        // this.frame = frame % 32 + 1;
        move();
        this.avatar.update(this.x, this.y-110, this.z, this.angle[0], this.isMoving);
        camera(-sin(this.angle[0])*300+this.x, this.y - 130, -cos(this.angle[0])*300+this.z,
            this.x, this.y-130, this.z,
            0, 1, 0);
    }
    void freeFall() {
        this.y += 10;
    }
    
    void move() {
        // 入力されているキーを移動量に変換
        if (this.key_list['d' - 'a'] ==  true) {
            this.x -= sin(0.5 * PI + this.angle[0]) * this.move_speed;
            this.z -= cos(0.5 * PI + this.angle[0]) * this.move_speed;
        }
        if (this.key_list['a' - 'a'] ==  true) {
            this.x += sin(0.5 * PI + this.angle[0]) * this.move_speed;
            this.z += cos(0.5 * PI + this.angle[0]) * this.move_speed;
        }
        if (this.key_list['s' - 'a'] ==  true) {
            this.x -= sin(this.angle[0]) * this.move_speed;
            this.z -= cos(this.angle[0]) * this.move_speed;
        }
        if (this.key_list['w' - 'a'] ==  true) {
            this.x += sin(this.angle[0]) * this.move_speed;
            this.z += cos(this.angle[0]) * this.move_speed;
        }
        if (this.key_list['q' - 'a'] ==  true) {
            this.angle[0] += 0.01 * PI;
        }
        if (this.key_list['e' - 'a'] ==  true) {
            this.angle[0] -= 0.01 * PI;
        }
        if (this.key_list['t' - 'a'] ==  true) {
            this.y -= 10;
        }
        if (this.key_list['g' - 'a'] ==  true) {
            this.y += 10;
        }
    }
    void keyPressed() {
        if (key - 'a' >= - 1 && key - 'a' < 26) {
            this.key_list[key - 'a'] = true;
        }
    }
    void keyReleased() {
        if (key - 'a' >= -1 && key - 'a' < 26) {
            this.key_list[key - 'a'] = false;
        }
    }
}