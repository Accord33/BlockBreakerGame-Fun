import socket
import threading
import json
import random

# サーバーの設定
HOST = '0.0.0.0'  # すべてのネットワークインターフェースでリッスン
PORT = 5007       # 使用するポート番号

# ゲームルームを管理するディクショナリ
rooms = {}

def handle_client(conn, addr):
    """
    クライアントとの接続を処理する関数
    :param conn: クライアントとのコネクション
    :param addr: クライアントのアドレス
    """
    while True:
        try:
            # クライアントからデータを受信
            data = conn.recv(1024).decode('utf-8')
            if not data:
                break
            
            # JSONデータをパース
            request = json.loads(data)
            # リクエストを処理してレスポンスを生成
            response = process_request(request)
            
            # レスポンスをクライアントに送信
            conn.send(json.dumps(response).encode('utf-8'))
        except json.JSONDecodeError:
            print(f"無効なJSONを受信: {addr}")
        except Exception as e:
            print(f"クライアント {addr} の処理中にエラーが発生: {e}")
            break
    
    # 接続を閉じる
    conn.close()

def process_request(request):
    """
    クライアントからのリクエストを処理する関数
    :param request: クライアントからのリクエスト（ディクショナリ）
    :return: レスポンス（ディクショナリ）
    """
    status = request.get('status')
    username = request.get('username')
    room_id = request.get('roomID') or str(random.randint(1000, 9999))
    user_status = request.get('userstatus')
    avatar = request.get('avatar')

    # ルームが存在しない場合、新しいルームを作成
    if room_id not in rooms:
        rooms[room_id] = {
            'players': [],
            'daemon': None,
            'player_positions': {},
            'world_id': random.randint(0, 3),
            'break_blocks': [0, 0, 0, 0, 0],
            'clear_player_num': 0
        }

    room = rooms[room_id]

    if status == 'wait':
        # 待機状態の処理
        print(username, user_status, room['players'], len(room['players']))
        if user_status == 'player' and len(room['players']) < 5:
            if username not in room['players']:
                room['players'].append(username)
        elif user_status == 'daemon' and room['daemon'] is None:
            room['daemon'] = username            
            
        return {
            'player_num': len(room['players'])
        }

    elif status == 'play':
        # プレイ状態の処理
        if username not in room['player_positions']:
            room['player_positions'][username] = {'x': 0, 'y': 0, 'z': 0}

        return {
            'player_num': len(room['players']),
            'players_pos': [
                {
                    'username': player,
                    'avatar': avatar,
                    'x': room['player_positions'][player]['x'],
                    'y': room['player_positions'][player]['y'],
                    'z': room['player_positions'][player]['z']
                } for player in room['players']
            ]
        }

    # 未知のステータスの場合は空のレスポンスを返す
    return {}

def main():
    """
    メイン関数：サーバーの起動と接続の受け入れを行う
    """
    # サーバーソケットの作成
    server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    server_socket.bind((HOST, PORT))
    server_socket.listen(5)
    print(f"サーバーが {HOST}:{PORT} でリッスンしています")

    while True:
        try:
            # クライアントからの接続を受け入れ
            conn, addr = server_socket.accept()
            print(f"接続されました: {addr}")
            # 各クライアントを別スレッドで処理
            client_thread = threading.Thread(target=handle_client, args=(conn, addr), daemon=True)
            client_thread.start()
        except KeyboardInterrupt:
            print("サーバーをシャットダウンしています...")
            break
        except Exception as e:
            print(f"接続の受け入れ中にエラーが発生しました: {e}")

    # サーバーソケットを閉じる
    server_socket.close()

if __name__ == "__main__":
    main()