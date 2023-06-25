void createBreakBlock(float x, float y, float z) {

    // 破壊するブロックの生成データ
    
    fill(0, 0, 200);

    beginShape();
    vertex(x+50, y, z+50);
    vertex(x+50, y, z-50);
    vertex(x, y-100, z);
    endShape();
    beginShape();
    vertex(x-50, y, z+50);
    vertex(x-50, y, z-50);
    vertex(x, y-100, z);
    endShape();
    beginShape();
    vertex(x-50, y, z+50);
    vertex(x+50, y, z+50);
    vertex(x+0, y-100, z);
    endShape();
    beginShape();
    vertex(x-50, y, z-50);
    vertex(x+50, y, z-50);
    vertex(x, y-100, z);
    endShape();

    beginShape();
    vertex(x+50, y, z+50);
    vertex(x+50, y, z-50);
    vertex(x, y+100, z);
    endShape();
    beginShape();
    vertex(x-50, y, z+50);
    vertex(x-50, y, z-50);
    vertex(x, y+100, z);
    endShape();
    beginShape();
    vertex(x-50, y, z+50);
    vertex(x+50, y, z+50);
    vertex(x+0, y+100, z);
    endShape();
    beginShape();
    vertex(x-50, y, z-50);
    vertex(x+50, y, z-50);
    vertex(x, y+100, z);

    endShape();
}

