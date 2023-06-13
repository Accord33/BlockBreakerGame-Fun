# Echo server program
import socket
import threading
import json

HOST = ''                 # Symbolic name meaning all available interfaces
PORT = 5007              # Arbitrary non-privileged port
datas = {
    "room1" : {
        "player":["Staycia", "bot1"],
        "Staycia":[0,0,0,0],
        "bot1":[0,0,0,0],
        "deamon":"a",
        "a":[0,0,0,0]
    }
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
        datas[data[0]][data[1]] = list(map(float, [data[2],data[3],data[4], data[5]]))
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