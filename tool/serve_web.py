from http.server import SimpleHTTPRequestHandler, ThreadingHTTPServer
from pathlib import Path
from urllib.parse import urlsplit

ROOT = Path(__file__).resolve().parents[1] / 'build' / 'web'

class Handler(SimpleHTTPRequestHandler):
    def __init__(self, *args, **kwargs):
        super().__init__(*args, directory=str(ROOT), **kwargs)

    def do_GET(self):
        route = urlsplit(self.path).path
        if not Path(self.translate_path(route)).exists():
            self.path = '/index.html'
        super().do_GET()

if __name__ == '__main__':
    print('Serving Homework 4 at http://127.0.0.1:8268', flush=True)
    ThreadingHTTPServer(('127.0.0.1', 8268), Handler).serve_forever()
