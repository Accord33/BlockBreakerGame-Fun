// objファイルから持ってきたオブジェクトの生成  bんクラス
class Avatar_obj {
    // float x, y, z, angle1, angle2;
    String url;
    PShape obj;
    float angle;
    Objseq file;
    int frame = 0;
    Avatar_obj(String url) {
        this.obj = loadShape("../model/"+url+"/"+url+".obj");
        this.file = new Objseq(32, "../model/"+url+"/"+url+"/"+url+"");
        this.obj.rotate(PI);
    }

    void update(float x, float y, float z, float angle1, boolean moveing) {
        pushMatrix();
        translate(x, y+110, z);
        // translate(sin(angle1)*100+x, y+110, cos(angle1)*100+z);
        if (moveing) {
            this.file.models.get(this.frame).rotateY(angle1);
            scale(8000.0);
            shape(this.file.models.get(this.frame));
            this.file.models.get(this.frame).rotateY(-angle1);
        }
        else {
            scale(80);
            obj.rotateY(angle1);
            shape(obj);
            obj.rotateY(-angle1);
        }
        popMatrix();
        this.frame = (this.frame+1)%32;
    }
}


class Objseq {
    int seqlen;
    String filename;
    ArrayList<PShape> models = new ArrayList<PShape>();

    Objseq(int len, String name) {
        seqlen = len;
        filename = name;
        for (int i=1; i<seqlen+1; i++) {
            println(filename+i+".obj");
            models.add(loadShape(filename+i+".obj"));
            models.get(i-1).rotate(PI);
        }
    }

    void objshape(int a) {
        shape(models.get(0));
    }
    void objscale(float s) {
        for (int i=0; i<models.size(); i++) {
            models.get(i).scale(s);
        }
    }
    
}