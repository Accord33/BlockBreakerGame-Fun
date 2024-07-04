// // WebSocketライブラリをインポート
// import websockets.*;

// WebsocketClient wsc;
// boolean connected = false;
// String username = "Player1";
// String avatar = "normal";
// float playerX, playerY;
// ArrayList<Player> otherPlayers = new ArrayList<Player>();

// void setup() {
//     size(800, 600);
//     playerX = width / 2;
//     playerY = height / 2;
    
//     //WebSocketクライアントの初期化
//     wsc = new WebsocketClient(this, "ws://localhost:8765");
// }

// void draw() {
//     background(200);
    
//     if(connected) {
//         // 自分のプレイヤーを描画
//         fill(255, 0, 0);
//         ellipse(playerX, playerY, 20, 20);
        
//         // 他のプレイヤーを描画
//         fill(0, 0, 255);
//         for (Player p : otherPlayers) {
//             ellipse(p.x, p.y, 20, 20);
//             text(p.username, p.x, p.y - 20);
//         }
// } else {
//         textAlign(CENTER, CENTER);
//         text("Connecting to server...", width / 2, height / 2);
// }
// }

// void keyPressed() {
//     if(connected) {
//         // プレイヤーの移動
//         if (keyCode == UP) playerY -= 5;
//         if (keyCode == DOWN) playerY += 5;
//         if (keyCode == LEFT) playerX -= 5;
//         if (keyCode == RIGHT) playerX += 5;
        
//         // サーバーに位置情報を送信
//         sendPosition();
// }
// }

// void sendPosition() {
//     JSONObject data = new JSONObject();
//     data.setString("status", "play");
//     data.setString("username", username);
//     data.setString("avatar", avatar);
//     data.setFloat("x", playerX);
//     data.setFloat("y", playerY);
//     data.setFloat("z", 0);  // 2Dゲームなのでzは0
    
//     wsc.sendMessage(data.toString());
// }

// void webSocketEvent(String msg) {
//     JSONObject data = parseJSONObject(msg);
//     if(data != null) {
//         if (data.hasKey("player_num")) {
//             println("Connected players: " + data.getInt("player_num"));
//         }
//         if (data.hasKey("players_pos")) {
//             updatePlayerPositions(data.getJSONArray("players_pos"));
//         }
// }
// }

// void updatePlayerPositions(JSONArray playersData) {
//     otherPlayers.clear();
//     for (int i = 0; i < playersData.size(); i++) {
//         JSONObject playerData = playersData.getJSONObject(i);
//         String playerUsername = playerData.getString("username");
//         if (!playerUsername.equals(username)) {
//             float x = playerData.getFloat("x");
//             float y = playerData.getFloat("y");
//             otherPlayers.add(new Player(playerUsername, x, y));
//         }
// }
// }

// void webSocketConnected() {
//     println("Connected to server");
//     connected = true;
    
//     //接続後、初期状態を送信
//     JSONObject data = new JSONObject();
//     data.setString("status", "wait");
//     data.setString("username", username);
//     data.setString("avatar", avatar);
    
//     wsc.sendMessage(data.toString());
// }

// class Player {
//     String username;
//     float x, y;
    
//     Player(String username, float x, float y) {
//         this.username = username;
//         this.x = x;
//         this.y = y;
// }
// }