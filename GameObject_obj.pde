// objファイルから持ってきたオブジェクトのクラス
class GameObject_obj {
    float x, y, z, angle1, angle2;
    String url;
    PShape obj;
    GameObject_obj(float x, float y, float z, float angle1, float angle2, String url) {
        this.x = x;
        this.y = y;
        this.z = z;
        this.angle1 = angle1;
        this.angle2 = angle2;
        this.obj = loadShape(url);
        this.obj.rotate(PI);
    }
    void update() {
        pushMatrix();
        translate(this.x, this.y, this.z);
        scale(100.0);
        shape(obj);
        obj.rotateY(angle1);
        popMatrix();
    }
}