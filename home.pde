class Home {
    String room="";
    Home(){}

    void draw() {
        background(0);
        text("Room名", width/3, height/2, 0);
        text(room, width*2/3, height/2, 0);
    }
    void keyPressed() {
        if (key == CODED) {

        }
        else if (key == DELETE) {
            room = room.substring(0, room.length()-1);
            println(room);
        }
        else {
            room += key;
        }
        if (key == ENTER) {
            gamestatus++;
        }
    }
}