# Firma de archiv mediante OpenSSL (hash SHA-256):

```sh
openssl dgst -sha256 -sign private.pem -out file.sign file.txt
```
Verificación de firma con OpenSSL (mediante el hash SHA-256):
```sh
openssl dgst -sha256 -verify public.pem -signature file.sign file.txt
```
