// class UI {
//     String sent;
//     UI(){
//     }

//     void update(float tx,float ty,float tz,float angle) {
//         pushMatrix();
//         translate(sin(angle)*100+tx, ty-130, cos(angle)*100+tz);
//         // translate(sin(angle)*200+tx, ty-130, cos(angle)*200+tz);
//         rotateY(angle+PI);
//         textAlign(CENTER);
//         // fill(0,0,0);
//         fill(255,0, 0);
//         // stroke(255);
//         textSize(3);
        
//         if (key_num == 4) {
//             sent = "出口が開放されました。";
//         }
//         else {
//             sent = (4-key_num)+"個のブロックが破壊されていません";
//         }
//         text(sent, 0, -50, 0);
//         rotateY(-(angle*PI));
//         popMatrix();
//     }

//     // どれくらい破壊したかメーター
//     void progressbar(float tx,float ty,float tz,float angle) {
//         pushMatrix();
//         noStroke();
//         translate(sin(angle+radians(20))*141+tx, ty-130, cos(angle+radians(20))*141+tz);
//         rotateY(angle);
//         translate(-breakmeter/10, 0, 0);
//         box(breakmeter/5, 10, 1);
//         popMatrix();
//     }

//     void blood_show(float tx,float ty,float tz,float angle) {
//         pushMatrix();
//         // translate(sin(angle+radians(30))*120+tx, ty-130, cos(angle+radians(30))*120+tz);
//         translate(sin(angle-radians(45))*110+tx, ty-130, cos(angle-radians(45))*110+tz);
//         rotateY(angle);
//         blood.resize(width/8, height/8);
//         translate(0, -height/16, 0);
//         image(blood, 0, 0);
//         popMatrix();
//     }
// }