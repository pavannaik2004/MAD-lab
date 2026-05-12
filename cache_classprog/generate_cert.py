import subprocess
import sys


def ensure_pyopenssl():
    try:
        from OpenSSL import crypto  # noqa: F401
        return
    except ModuleNotFoundError:
        subprocess.run([sys.executable, "-m", "pip", "install", "pyopenssl"], check=True)


def generate_self_signed_cert():
    from OpenSSL import crypto

    key = crypto.PKey()
    key.generate_key(crypto.TYPE_RSA, 2048)

    cert = crypto.X509()
    cert.get_subject().CN = "localhost"
    cert.set_serial_number(1000)
    cert.gmtime_adj_notBefore(0)
    cert.gmtime_adj_notAfter(365 * 24 * 60 * 60)
    cert.set_issuer(cert.get_subject())
    cert.set_pubkey(key)
    cert.sign(key, "sha256")

    with open("cert.pem", "wb") as cert_file:
        cert_file.write(crypto.dump_certificate(crypto.FILETYPE_PEM, cert))

    with open("key.pem", "wb") as key_file:
        key_file.write(crypto.dump_privatekey(crypto.FILETYPE_PEM, key))


if __name__ == "__main__":
    ensure_pyopenssl()
    generate_self_signed_cert()
    print("✓ Certificate generated: cert.pem and key.pem")
