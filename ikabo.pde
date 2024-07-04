class Ikabo {
    PShape obj;
    Ikabo() {
        this.obj = loadShape("model/ikabo/ikabo.obj");
        // this.obj = loadShape("model/walk_man/walk_man.obj");
        this.obj.rotate(PI);
    }

    void update(float x, float y, float z, float angle1) {
        // push();
        pushMatrix();
        translate(x, y-65, z);
        scale(80.0);
        this.obj.rotateY(angle1);
        shape(this.obj);
        this.obj.rotateY(-angle1);
        popMatrix();
        
        // pushMatrix();
        // translate(x, y-130, z);
        // fill(255, 0, 0);
        // rotateY(angle1);
        // box(50);
        // popMatrix();
    }
}