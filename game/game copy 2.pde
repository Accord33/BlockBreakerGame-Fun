// import processing.net.*;
// import java.nio.charset.StandardCharsets;
// import ddf.minim.*;


// // 画面サイズ
// int win_width = 1200;
// int win_height = 800;

// // 画面のインスタンス
// Start start;
// Home home;
// Wait wait;
// Player player;
// Gamedraw gamedraw;

// // ゲームのステータス(スタートかホームかプレイ中かなど)
// int gamestatus = 2;

// // サーバーアクセス系
// String IP = "10.124.78.133";
// int PORT = 5007;
// Client client;

// ArrayList <Avatar_obj> avatar = new ArrayList<>();


// // 画面サイズを変数で宣言する時はsetting関数を使わなければいけない
// public void settings() {
//     size(win_width, win_height, "processing.opengl.PGraphics3D");                             
// }

// void setup() {
//     surface.setResizable( true );
    
//     // フォントの設定
//     PFont font = createFont("Meiryo", 50);
//     textFont(font);

//     client = new Client(this, IP, PORT);

//     start = new Start();
//     home = new Home();
//     wait = new Wait();
//     player = new Player(600, 400, 0);
//     gamedraw = new Gamedraw();
//     player.setting("room1", "user1", "normal", 10, "walk_man");
// }

// void draw() {
//         switch (gamestatus) {
//         case 0:
//             start.draw();
//             break;
//         case 1:
//             home.draw();
//             break;
//         case 2:
//             wait.draw(player);
//             break;
//         case 3:
//             gamedraw.draw();
//             player.draw();
//             break;
//         case 4:
//             break;
//         case 5:
//             break;
//     }
// }

// void keyPressed() {
//     switch (gamestatus) {
//         case 0:
//             start.keyPressed();
//             break;
//         case 1:
//             home.keyPressed();
//             break;
//         case 2:
//             break;
//         case 3:
//             player.keyPressed();
//             break;
//         case 4:
//             break;
//         case 5:
//             break;
//     }
// }
// void keyReleased() {
//     switch (gamestatus) {
//         case 0:
//             break;
//         case 1:
//             break;
//         case 2:
//             break;
//         case 3:
//             player.keyReleased();
//             break;
//         case 4:
//             break;
//         case 5:
//             break;
//     }

// }

// void mousePressed() {
//     switch (gamestatus) {
//     case 1:
//         home.mousePressed();
//         break;
//     }
// }


// void clientEvent(Client c) {
//     switch (gamestatus) {
//         case 2:
//             wait.clientEvent(c);
//             break;
//         case 3:
//             gamedraw.clientEvent(c);
//             break;
//     }
// }