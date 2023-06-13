class Player {
    float x, y, z, v;
    float angle[] = {160, 0};
    Player(float x, float y, float z) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.angle = angle;
        this.v = 0;
    }
    void update() {
        camera(this.x, this.y-130, this.z,
            sin(this.angle[0])+this.x, this.y-130+sin(this.angle[1]), cos(this.angle[0])+this.z,
            0, 1, 0);
        
        // freeFall();
    }
    
    void freeFall() {
        this.v = num*g;
        // this.y += 0.2 * this.v * num;
        this.y += 10;
    }
}