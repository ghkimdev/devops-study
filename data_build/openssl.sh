openssl genrsa -out ca.key 2048
openssl req -new -sha256 -key ca.key -out ca.csr
echo "
[ req ]
default_bits            = 2048
default_md              = sha1
default_keyfile         = ca.key
distinguished_name      = req_distinguished_name
extensions              = v3_ca
req_extensions = v3_ca

[ v3_ca ]
basicConstraints       = critical, CA:TRUE, pathlen:0
subjectKeyIdentifier   = hash
keyUsage               = keyCertSign, cRLSign
nsCertType             = sslCA, emailCA, objCA

[ req_distinguished_name ]
countryName                     = Country Name (2 letter code)
countryName_default             = KR
countryName_min                 = 2
countryName_max                 = 2

organizationName              = Organization Name (eg, company)
organizationName_default      = hognod Inc.

#organizationalUnitName          = Organizational Unit Name (eg, section)
#organizationalUnitName_default  = hognod Project

commonName                     = Common Name (eg, your name or your server's hostname)
commonName_default             = hognod CA
commonName_max                 = 65" > ca.conf

openssl req -new -sha256 -key ca.key -config ca.conf -out ca.csr
openssl x509 -req -sha256 -days 9999 -extensions v3_ca -set_serial 1 -in ca.csr -signkey ca.key -extfile ca.conf -out ca.crt
openssl genrsa -out server.key 2048

echo "[ req ]
default_bits            = 2048
default_md              = sha1
default_keyfile         = ca.key
distinguished_name      = req_distinguished_name
extensions              = v3_user

[ v3_user ]
basicConstraints         = CA:FALSE
authorityKeyIdentifier   = keyid,issuer
subjectKeyIdentifier     = hash
keyUsage                 = nonRepudiation, digitalSignature, keyEncipherment

extendedKeyUsage         = serverAuth,clientAuth
subjectAltName           = @alt_names

[ alt_names ]
DNS.1   = *.ghdev.com
#DNS.2   = hognod.com
#DNS.3   = *.hognod.com

[req_distinguished_name ]
countryName                     = Country Name (2 letter code)
countryName_default             = KR
countryName_min                 = 2
countryName_max                 = 2

organizationName              = Organization Name (eg, company)
organizationName_default      = hognod Inc.

organizationalUnitName          = Organizational Unit Name (eg, section)
organizationalUnitName_default  = hognod Project

commonName                      = Common Name (eg, your name or your server's hostname)
commonName_default              = *.ghdev.com
commonName_max                  = 64" > server.conf

openssl req -new -sha256 -key server.key -config server.conf -out server.csr
openssl x509 -req -sha256 -days 9999 -extensions v3_user -in server.csr -CA ca.crt -CAcreateserial -CAkey ca.key -extfile server.conf -out server.crt
openssl pkcs12 -export -in server.crt -inkey server.key -out server.pfx
keytool -importkeystore -srckeystore server.pfx -srcstoretype pkcs12 -destkeystore server.jks -deststoretype jks
