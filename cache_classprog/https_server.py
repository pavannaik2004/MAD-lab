#!/usr/bin/env python3
import http.server
import ssl
import os
import socket
from pathlib import Path

PORT = 8443
CERT_FILE = "cert.pem"
KEY_FILE = "key.pem"

# Get local IP address
def get_local_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip = s.getsockname()[0]
        s.close()
        return ip
    except:
        return "127.0.0.1"

# Check if certificates exist
if not os.path.exists(CERT_FILE) or not os.path.exists(KEY_FILE):
    print("❌ Certificates not found!")
    print("Run: python generate_cert.py")
    exit(1)

# Create HTTPS server
handler = http.server.SimpleHTTPRequestHandler
httpd = http.server.HTTPServer(("0.0.0.0", PORT), handler)

# Create SSL context
context = ssl.SSLContext(ssl.PROTOCOL_TLS_SERVER)
context.load_cert_chain(CERT_FILE, KEY_FILE)
httpd.socket = context.wrap_socket(httpd.socket, server_side=True)

local_ip = get_local_ip()
print("\n" + "="*60)
print("🔒 HTTPS Server Running")
print("="*60)
print(f"Local:  https://localhost:{PORT}")
print(f"Mobile: https://{local_ip}:{PORT}")
print("\n⚠️  Accept SSL warning on mobile (self-signed cert)")
print("="*60 + "\n")

try:
    httpd.serve_forever()
except KeyboardInterrupt:
    print("\n✓ Server stopped")
