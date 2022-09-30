import signal
from flask import Flask, request, render_template
from yt_dlp import YoutubeDL
from flask import jsonify
import mysql.connector
import os

con = mysql.connector.connect(
    host="mysql",
    user="root",
    password=os.environ['DB_ROOT_PASS'],
    database=os.environ['DB_NAME']
)

cur = con.cursor()
cur.execute("""
    CREATE TABLE IF NOT EXISTS videos(
        client_ip varchar(255),
        title varchar(255),
        videoId varchar(255),
        CONSTRAINT UC_video UNIQUE (client_ip, title, videoId))
    """)

app = Flask(__name__, static_url_path='')

app_ready = True


@app.route("/")
def home():
    return render_template('index.html')


@app.route("/load")
def load():
    import random
    x = 0.0001
    for i in range(1000000):
        x += random.random()**0.5

    return 'OK!'


@app.route("/heath")
def health():
    return 'OK'


@app.route("/ready")
def ready():
    return ('Ready', 200) if app_ready else ('Not ready', 500)


@app.route("/youtube", methods=['POST'])
def get_youtube():
    client_ip = request.remote_addr
    video_name = request.json['text']

    if video_name == 'my videos':
        cur.execute(f"SELECT * FROM videos WHERE client_ip='{client_ip}'")
        data = cur.fetchall()
        return jsonify({
            'items': [{'text': t, 'videoId': i} for _, t, i in data]
        }), 200

    with YoutubeDL() as ydl:
        videos = ydl.extract_info(f"ytsearch{1}:{video_name}", download=True)['entries']

        if videos:
            cur.execute(f"""INSERT IGNORE INTO videos VALUES ('{client_ip}', '{videos[0]['title']}', '{videos[0]['id']}')""")
            con.commit()

        return jsonify({
            'items': [{
                'text': videos[0]['title'] if videos else 'Video not found',
                'videoId': videos[0]['id'] if videos else ''
            }]
        }), 200


def handle_sig(sig, frame):
    global app_ready
    print(f'Got signal number {sig} {frame}')
    app_ready = False


if __name__ == '__main__':
    signal.signal(signal.SIGINT, handle_sig)
    signal.signal(signal.SIGTERM, handle_sig)
    app.run(host='0.0.0.0', port=8080)
