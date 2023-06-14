# Echo server program
import socket
import threading
import json
import random

HOST = ''                 # Symbolic name meaning all available interfaces
PORT = 5007              # Arbitrary non-privileged port
datas = {

}

s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(5)
clients = []

def re(conn, addr):
    while True:
        data = conn.recv(1024)
        if not data: break
        print(data)
        data = json.loads(data.decode('utf-8'))
        # 送信されるデータ
        # ルーム名 ユーザー名 プレイヤーステータス x y z angle0 鍵の数
        # もしルームがなければ生成
        if data["room"] not in datas:
            datas[data["room"]] = {"player":list(),"deamon":"","key":0,"clearPlayernum":0,"breakblock":[0,0,0,0],"worldID":random.randint(0,0)}
        if data["userstatus"] == "player" and data["user"] not in datas[data["room"]]["player"] and len(datas[data["room"]]["player"]) < 5:
            datas[data["room"]]["player"].append(data["user"])
        if data["userstatus"] == "deamon" and  data["user"] != datas[data["room"]]["deamon"] and datas[data["room"]]["deamon"] == "":
            datas[data["room"]]["deamon"] = data["user"]
        datas[data["room"]][data["user"]] = data["pos"]
        if datas[data["room"]]["key"] < data["key"]:
            datas[data["room"]]["key"] = data["key"]
        if datas[data["room"]]["breakblock"] < data["breakblock"]:
            datas[data["room"]]["breakblock"] = data["breakblock"]
        
        print(datas)
        conn.send(json.dumps(datas).encode('utf-8'))

while True:
    try:
        conn, addr = s.accept()

        print('Connected by', addr)

    except KeyboardInterrupt:
        s.close()
        print('O')
        raise
    clients.append((conn, addr))
    thread = threading.Thread(target=re, args=(conn, addr), daemon=True)
    thread.start()