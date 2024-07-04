import asyncio
import json
import websockets
import uuid
import os

class GameServer:
    def __init__(self):
        # クライアントとルームの情報を格納する辞書
        self.clients = {}  # {client_id: {"websocket": websocket, "room": room_id}}
        self.rooms = {}    # {room_id: {"players": {client_id: player_data}}}

    async def handle_client(self, websocket, path):
        # 新しいクライアント接続を処理
        client_id = str(uuid.uuid4())
        self.clients[client_id] = {"websocket": websocket, "room": None}

        try:
            async for message in websocket:
                # クライアントからのメッセージを処理
                print(client_id, message)
                await self.process_message(client_id, message)
        finally:
            # クライアントが切断されたときの処理
            print("disconnected", client_id)
            await self.disconnect_client(client_id)

    async def process_message(self, client_id, message):
        # クライアントからのメッセージを解析して適切な処理を行う
        data = json.loads(message)
        status = data.get("status")

        if status == "wait":
            print(client_id)
            await self.handle_wait(client_id, data)
        elif status == "play":
            await self.handle_play(client_id, data)

    async def handle_wait(self, client_id, data):
        # 待機状態の処理
        room_id = data.get("roomID") or str(uuid.uuid4())
        if room_id not in self.rooms:
            self.rooms[room_id] = {"players": {}}

        # プレイヤー情報をルームに追加
        self.rooms[room_id]["players"][client_id] = {
            "username": data["username"],
            "userstatus": data["userstatus"],
            "avatar": data["avatar"]
        }
        self.clients[client_id]["room"] = room_id

        # クライアントに現在のプレイヤー数を返す
        response = {
            "player_num": len(self.rooms[room_id]["players"])
        }
        await self.clients[client_id]["websocket"].send(json.dumps(response))

    async def handle_play(self, client_id, data):
        # プレイ状態の処理
        room_id = data.get("roomID") or self.clients[client_id]["room"]
        if room_id not in self.rooms:
            return  # エラー処理を追加すべき

        # プレイヤー情報を更新
        self.rooms[room_id]["players"][client_id].update({
            "username": data["username"],
            "userstatus": data["userstatus"],
            "avatar": data["avatar"],
            "x": 0,
            "y": 0,
            "z": 0
        })

        # 全プレイヤーの位置情報を含むレスポンスを作成
        response = {
            "player_num": len(self.rooms[room_id]["players"]),
            "players_pos": [
                {
                    "username": player["username"],
                    "avatar": player["avatar"],
                    "x": player.get("x", 0),
                    "y": player.get("y", 0),
                    "z": player.get("z", 0)
                } for player in self.rooms[room_id]["players"].values()
            ]
        }

        # 同じルーム内の全プレイヤーにブロードキャスト
        await self.broadcast(room_id, json.dumps(response))

    async def broadcast(self, room_id, message):
        # 指定されたルーム内の全クライアントにメッセージを送信
        if room_id in self.rooms:
            for client_id in self.rooms[room_id]["players"]:
                await self.clients[client_id]["websocket"].send(message)

    async def disconnect_client(self, client_id):
        # クライアントの切断処理
        if client_id in self.clients:
            room_id = self.clients[client_id]["room"]
            if room_id:
                if room_id in self.rooms:
                    # ルームからプレイヤーを削除
                    del self.rooms[room_id]["players"][client_id]
                    # プレイヤーがいなくなったらルームを削除
                    if not self.rooms[room_id]["players"]:
                        del self.rooms[room_id]
            # クライアント情報を削除
            del self.clients[client_id]

async def main():
    server = GameServer()
    
    # 環境変数からホストとポートを取得（デフォルト値つき）
    host = os.environ.get("GAME_SERVER_HOST", "0.0.0.0")
    port = int(os.environ.get("GAME_SERVER_PORT", 5007))

    # SSL/TLS証明書の設定（本番環境では必須）
    # ssl_context = None
    # cert_path = os.environ.get("SSL_CERT_PATH")
    # key_path = os.environ.get("SSL_KEY_PATH")
    # if cert_path and key_path:
    #     ssl_context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
    #     ssl_context.load_cert_chain(cert_path, key_path)

    # WebSocketサーバーを起動
    # async with websockets.serve(server.handle_client, host, port, ssl=ssl_context):
    async with websockets.serve(server.handle_client, host, port):
        print(f"Server is running on {host}:{port}")
        await asyncio.Future()  # サーバーを永続的に実行

if __name__ == "__main__":
    asyncio.run(main())

if __name__ == "__main__":
    asyncio.run(main())