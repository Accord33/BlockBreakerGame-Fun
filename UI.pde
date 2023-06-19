class UI {
    String sent;
    UI(){
    }

    void update(float tx,float ty,float tz,float angle) {
        pushMatrix();
        translate(sin(angle)*100+tx, ty-130, cos(angle)*100+tz);
        rotateY(angle+PI);
        textAlign(CENTER);
        // fill(0,0,0);
        fill(255,255,255);
        stroke(255);
        textSize(3);
        
        if (key_num == 4) {
            sent = "出口が開放されました。";
        }
        else {
            sent = (4-key_num)+"個のブロックが破壊されていません";
        }
        text(sent, 0, -50, 0);
        rotateY(-(angle+PI));
        popMatrix();
    }

    void write(float tx,float ty,float tz,float angle) {
        pushMatrix();
        translate(sin(angle)*100+tx, ty-130, cos(angle)*100+tz);
        rotateY(angle+PI);
        textAlign(CENTER);
        // fill(0,0,0);
        fill(255,255,255);
        stroke(255);
        textSize(3);
        
        if (key_num == 4) {
            sent = "出口が開放されました。";
        }
        else {
            sent = (4-key_num)+"個のブロックが破壊されていません";
        }
        text(sent, 0, -50, 0);
        rotateY(-(angle+PI));
        popMatrix();
    }
}