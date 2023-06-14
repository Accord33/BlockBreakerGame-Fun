# Echo server program
import socket
import threading
import json

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
        data = data.decode('utf-8').split(",")
        # 送信されるデータ
        # ルーム名 ユーザー名 プレイヤーステータス x y z angle0 鍵の数
        # もしルームがなければ生成
        print(data)
        if data[0] not in datas:
            datas[data[0]] = dict()
        # もしplayer要素がなければ生成
        if "player" not in datas[data[0]]:
            datas[data[0]]["player"] = list()
        # もしユーザーがプレイヤーリストに入っていなければ追加 ただし5人以下
        if data[1] not in datas[data[0]]["player"] and len(datas[data[0]]["player"]) <= 4 and data[2]=="player":
            datas[data[0]]["player"].append(data[1])
        # もし鬼リストがなければ生成
        if "deamon" not in datas[data[0]]:
            datas[data[0]]["deamon"] = ""
        # もしユーザーが鬼リストに入っていなければ追加 ただし1人以下
        if data[1] not in datas[data[0]]["deamon"] and len(datas[data[0]]["deamon"]) <= 1 and data[2]=="deamon":
            datas[data[0]]["deamon"] = data[1]

        datas[data[0]][data[1]] = list(map(float, [data[3],data[4],data[5], data[6]]))
        datas[data[0]]["key"] = int(data[7])

        
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