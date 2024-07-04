# Echo server program
import socket
import threading
import json
import random

d = ""

HOST = '0.0.0.0'                 # Symbolic name meaning all available interfaces
PORT = 5007              # Arbitrary non-privileged port
datas = {
}

    
# {
#     "room":{
#         "player":["aa"],
#         "Pcharactor":[0],
#         "aa":[0,0,0],
#         "deamon":"bbb",
#         "Dchatactor":["deamon1"],
#         "bbb":[0,0,0],
#         "key":0,
#         "worldID":"random 0-3 int型",
#         "breakbrock":[0,0,0,0,0],
#         "clearPlayernum":0
#     }
# }

# ソケット通信開始
s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
s.bind((HOST, PORT))
s.listen(5)
clients = []


def re(conn, addr):
    global d
    while True:
        get_data = conn.recv(1024)
        if not get_data: break
        get_data = get_data.decode('utf-8')
        # print(data)
        if get_data.startswith("damage"):
            get_data = get_data.split(",")
            print(get_data)
            for i in datas[get_data[1]]["player"]:
                if datas[get_data[1]][i][:-2] == list(map(float, [get_data[2],get_data[3],get_data[4]])):
                    d = i
                    print(">>",d)
        else:
            print(get_data)
            try:
                data = json.loads(get_data)
            except json.decoder.JSONDecodeError:
                continue

            # 送信されるデータ
            # ルーム名 ユーザー名 プレイヤーステータス x y z angle0 鍵の数
            # もしルームがなければ生成
            if data["room"] not in datas:
                datas[data["room"]] = {"player":list(),"deamon":"","key":0,"clearPlayernum":0,"breakblock":[0,0,0,0],"worldID":random.randint(0,0),"Pcharactor":list(),"Dcharactor":""}
            if data["userstatus"] == "player" and data["user"] not in datas[data["room"]]["player"] and len(datas[data["room"]]["player"]) < 5:
                datas[data["room"]]["player"].append(data["user"])
                datas[data["room"]]["Pcharactor"].append(data["avatar"])
            if data["userstatus"] == "deamon" and  data["user"] != datas[data["room"]]["deamon"] and datas[data["room"]]["deamon"] == "":
                datas[data["room"]]["deamon"] = data["user"]
            datas[data["room"]][data["user"]] = data["pos"]
            if datas[data["room"]]["key"] < data["key"]:
                datas[data["room"]]["key"] = data["key"]
            if datas[data["room"]]["breakblock"] < data["breakblock"]:
                datas[data["room"]]["breakblock"] = data["breakblock"]
            
            print(datas)
            if d != "":
                print(d)
            # print(data, d)
            if data["user"] == d:
                print('yes')
                conn.send("damage".encode('utf-8'))
                d = ""
            
            conn.send(bytes(json.dumps(datas[data["room"]]), 'utf-8'))
            # conn.send(json.dumps(datas[data["room"]]).encode('utf-8'))


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