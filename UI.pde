class UI {
    String sent;
    UI(){
    }

    void update(float tx,float ty,float tz,float angle) {
        pushMatrix();
        translate(sin(angle)*100+tx, ty-130, cos(angle)*100+tz);
        // translate(sin(angle)*200+tx, ty-130, cos(angle)*200+tz);
        rotateY(angle+PI);
        textAlign(CENTER);
        // fill(0,0,0);
        fill(255,0, 0);
        // stroke(255);
        textSize(3);
        
        if (key_num == 4) {
            sent = "出口が開放されました。";
        }
        else {
            sent = (4-key_num)+"個のブロックが破壊されていません";
        }
        text(sent, 0, -50, 0);
        rotateY(-(angle*PI));
        popMatrix();
    }

    void progressbar(float tx,float ty,float tz,float angle) {
        pushMatrix();
        noStroke();
        translate(sin(angle)*100+tx, ty-130, cos(angle)*100+tz);
        rotateY(angle);
        box(breakmeter/2, 10, 10);
        popMatrix();
    }
}