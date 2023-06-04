class Bullet {
    public float x, y, z, dx, dy, dz;
    Bullet(float x, float y, float z, float  dx, float  dy, float dz) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.dx = dx;
        this.dy = dy;
        this.dz = dz;
    }
    void update() {
        this.x += this.dx;
        this.y += this.dy;
        this.z -= this.dz;
        pushMatrix();
        translate(this.x, this.y, this.z);
        sphere(5);
        popMatrix();
    }
}