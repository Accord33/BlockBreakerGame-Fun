// objファイルから持ってきたオブジェクトの生成  bんクラス
class Avatar_obj {
    // float x, y, z, angle1, angle2;
    String url;
    PShape obj;
    float angle;
    Avatar_obj(String url) {
        this.obj = loadShape(url);
        this.obj.rotate(PI);
    }

    void update(float x, float y, float z, float angle1) {
        pushMatrix();
        translate(x, y+100, z);
        scale(100.0);
        shape(obj);
        if (angle != angle1) {
            obj.rotateY(angle1-angle);
            angle = angle1;
        }
        popMatrix();
    }
}